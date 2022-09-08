package com.swan.controller;

import java.util.HashMap;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swan.model.MemberVO;
import com.swan.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcrypt;

	@Autowired
	private JavaMailSender mailSender;

	// 회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void loginGET() {

		logger.info("회원가입 페이지 진입");

	}

	// 로그인 페이지 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void joinGET() {

		logger.info("로그인 페이지 진입");

	}
	
	// 아이디 찾기 페이지 이동
	@RequestMapping(value="/find_id_form")
	public void findIdGET() {
		logger.info("아이디 찾기 페이지 진입");
	}
	
	/* 아이디 찾기 */
	@RequestMapping(value = "/find_id")
	public String getIdPOST(HttpServletResponse response, @RequestParam(value="email") String email, Model model)  throws Exception{
		model.addAttribute("id", memberService.getId(response, email));
		logger.info("아이디 찾기 성공");
		
		/* PrintWriter out = response.getWriter(); out을 이용해서 alert를 띄우면 redirect를 사용했을 때  
		 * java.lang.IllegalStateException: 응답이 이미 커밋된 후에는, sendRedirect()를 호출할 수 없습니다.
		 * 에러 발생 
		 */
		return "/member/find_id";
		
	}
	
	
	// 비밀번호 찾기 페이지 이동
	@RequestMapping(value="/find_pwd_form", method = RequestMethod.GET)
	public void findPwdGET() {
		logger.info("비밀번호 찾기 페이지 진입");
	}
	
	/* 비밀번호 찾기 */
	@RequestMapping(value = "/find_pwd", method = RequestMethod.POST)
	public void find_pwd(@ModelAttribute MemberVO member, HttpServletResponse response) throws Exception{		
		memberService.find_pwd(response, member);

		logger.info("비밀번호 찾기 성공");
	}

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		logger.info("join 진입");

		/* 비밀번호 암호화 */
		// BCrypt
		// 원본 데이터 -> salting, salt값 -> 암호화 데이터
		// (random)
//				System.out.println(bcrypt);
		String encPwd = bcrypt.encode(member.getPwd());
		member.setPwd(encPwd);
		System.out.println(encPwd);

		// 회원가입 서비스 실행
		memberService.insertMember(member);
		logger.info("join Service 성공");

		return "redirect:/member/login";

	}

	// 아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody // 해당 코드를 추가해주지 않는다면 join.jsp로 메서드의 결과가 반환되지 않습니다.
	public String memberIdChkPOST(String id) throws Exception {

		logger.info("memberIdChk() 진입");

		int result = memberService.idCheck(id);

		logger.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {

			return "success"; // 중복 아이디 x

		}

	} // memberIdChkPOST() 종료

	// 로그인
	@RequestMapping(value = "login.me", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, Model model, RedirectAttributes rttr)
			throws Exception {

//		System.out.println("login 메서드 진입");
//		System.out.println("전달된 데이터 : " + member);

		HttpSession session = request.getSession();
		// 암호화해서 얻은 비밀번호로 교체
		System.out.println(bcrypt.encode(member.getPwd()));

		// login()를 요청하게 되면 MemberMapper.java를 거쳐 로그인 쿼리가 실행되게 되고 그 결과 값이 담긴 MemberVO
		// 객체를 반환 받아서 변수 lvo에 저장
		MemberVO lvo = memberService.login(member);

		// 비밀번호 암호화한 회원과 match 시키기
		// 어떻게 비교하는지는 보완상 비밀이며 matches가 내부 로직으로 비교해줌
		boolean match = bcrypt.matches(member.getPwd(), lvo.getPwd());

		System.out.println(lvo);

		if (match) {
			session.setAttribute("member", lvo);
			model.addAttribute("lvo", member); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
			return "redirect:/swan";
		} else { // 일치하지 않는 아이디, 비밀번호 입력 경우
			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";

		}
	}

	// 로그아웃
	@RequestMapping(value = "logout.me", method = RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) throws Exception {
		logger.info("logoutMainGET메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();

		return "redirect:/swan";
	}

	/* 마이페이지로 이동 */
	@RequestMapping(value = "/mypage_info", method = RequestMethod.GET)
	public void myinfoPOST() {
		logger.info("마이페이지 진입!");
	}

	/* 내 정보 수정 */
	@PostMapping("/updateMember")
	public String updateMemberPOST(@ModelAttribute MemberVO member, RedirectAttributes rttr, Model model)
			throws Exception {
		logger.info("updateMemberPOST.........." + member);

		int result = memberService.updateMember(member);
		MemberVO loginUser = memberService.login(member);

		model.addAttribute("member", loginUser);
		// 해당 메서드가 작업을 정상적으로 수행했음을 알리는 메시지를 mypage_info.jsp로 전송하는 코드
		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/member/mypage_info";

	}

	/* 비밀번호 수정 */
	@RequestMapping(value = "/updatePwd")
	public String updatePwdPOST(HttpSession session, @RequestParam("pwd") String oldPwd,
			@RequestParam("newPwd") String newPwd, Model model, RedirectAttributes rttr) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		int result = 0;
		String encode = null;
		if (bcrypt.matches(oldPwd, member.getPwd())) {
			// 넘길 값들을 HashMap을 통해 받아 놓음.
			HashMap<String, String> map = new HashMap<>();
			map.put("id", member.getId());
			encode = bcrypt.encode(newPwd);
			map.put("newPwd", encode);

			result = memberService.updatePwd(map);
		}
		member.setPwd(encode);
		model.addAttribute("member", member);
		// 해당 메서드가 작업을 정상적으로 수행했음을 알리는 메시지를 mypage_info.jsp로 전송하는 코드
		rttr.addFlashAttribute("updatePwd", result);

		return "redirect:/member/mypage_info";
	}

	/* 회원 탈퇴 */
	@RequestMapping(value = "/deleteMember")
	public String deleteMemberPOST(MemberVO member, HttpSession session, RedirectAttributes rttr) {
		logger.info("deleteMemberPOST........");

		String id = ((MemberVO) session.getAttribute("member")).getId();

		int result = memberService.deleteMember(id);
		rttr.addFlashAttribute("delete_result", result);

		if (result > 0) {
			return "redirect:logout.me";
		}
		return "redirect:/swan";
	}

	/*
	 * 반환 타입을 String으로 변경할 경우 View(회원가입페이지)로 온전히 데이터를 전송하기 위해선 @ResponseBody 어노테이션이
	 * 필요
	 */
	/* 이메일 인증 */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* 뷰(View)로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : " + email);

		/* 인증번호(난수) 생성 */
		Random random = new Random();

		/* 111111 ~ 999999 범위의 숫자를 얻기 위해서 nextInt(888888) + 111111를 사용 */
		int checkNum = random.nextInt(888888) + 111111;

		/* 인증번호가 정상적으로 생성되었는지 확인하기 위해서 logger 코드를 추가 */
		logger.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "본인 이메일";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "SWAN을 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		/* 이메일 전송을 위한 코드를 삽입 */
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/* 인증번호 뷰(회원가입 페이지)로 전송 */
		// tring 타입 변수 num을 선언하고 인증번호(checkNum)를 string으로 형 변환 한 값을 할당
		String num = Integer.toString(checkNum);
		
		return num;
	}

}
