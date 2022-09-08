package com.swan.service;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.swan.mapper.MemberMapper;
import com.swan.model.MemberManageDTO;
import com.swan.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper membermapper;
	
	@Autowired(required=false)
	private BCryptPasswordEncoder bcrypt;

	// 회원가입
	@Override
	public void insertMember(MemberVO member) throws Exception {
		membermapper.insertMember(member);
	}

	// 아이디 중복 검사
	@Override
	public int idCheck(String id) throws Exception {
		return membermapper.idCheck(id);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO member) throws Exception {
		return membermapper.login(member);
	}

	/* 주문자 정보 */
	@Override
	public MemberVO getMemberInfo(String id) {
		return membermapper.getMemberInfo(id);
	}

	/* 내 정보 수정 */
	@Override
	public int updateMember(MemberVO member) throws Exception {
		return membermapper.updateMember(member);
	}

	/* 비밀번호 변경 */
	@Override
	public int updatePwd(HashMap<String, String> map) {
		return membermapper.updatePwd(map);
	}

	/* 회원 탈퇴 */
	@Override
	public int deleteMember(String id) {
		return membermapper.deleteMember(id);
	}

	/* 아이디 찾기 */
	@Override
	public String getId(HttpServletResponse response, String email) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = membermapper.getId(email);
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	}

	/* 관리자 회원 복구 */
	@Override
	public void updateMemberAdmin(MemberManageDTO dto) {
		/* 회원 */
		MemberVO member = membermapper.getMemberInfo(dto.getid());

		/* 회원 복구 DB */
		membermapper.updateMemberAdmin(dto.getid());

	}

	/* 관리자 회원 탈퇴 */
	@Override
	public void deleteMemberAdmin(MemberManageDTO dto) {
		MemberVO member = membermapper.getMemberInfo(dto.getid());

		/* 회원 탈퇴 DB */
		membermapper.deleteMemberAdmin(dto.getid());

	}

	/* 비밀번호 찾기 */
	@Override
	public void find_pwd(HttpServletResponse response, MemberVO member) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 아이디가 없으면
		if (membermapper.idCheck(member.getId()) == 0) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}
		// 가입에 사용한 이메일이 아니면
		else if (!member.getEmail().equals(membermapper.login(member.getId()).getEmail())) {
			out.println("<script>");
			out.println("alert('잘못된 이메일입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		} else {
			// 임시 비밀번호 생성
			String pwd = "";
			for (int i = 0; i < 12; i++) {
				pwd += (char) ((Math.random() * 26) + 97);
			}
			
			member.setPwd(pwd); // 임시 비밀번호 담기

			// 비밀번호 변경 메일 발송
			send_mail(member);
			
			// 순서 주의하기!!!!!!!!
			String encPwd = bcrypt.encode(member.getPwd());
			member.setPwd(encPwd);
			System.out.println(encPwd);
			
			// 비밀번호 변경
			membermapper.findUpdatePwd(member);

			

			out.println("<script>");
			out.println("alert('이메일로 임시 비밀번호를 발송하였습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}

	}

	// 이메일 발송
	@Override
	public void send_mail(MemberVO member) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "본인 이메일";
		String hostSMTPpwd = "본인 이메일 비밀번호";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "muchpretty99@naver.com";
		String fromName = "SWANSHOP";
		String subject = "";
		String msg = "";

		// 회원가입 메일 내용

		subject = "SWANSHOP 임시 비밀번호 입니다.";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += member.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += member.getPwd() + "</p></div>";

		// 받는 사람 E-Mail 주소
		String mail = member.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

}
