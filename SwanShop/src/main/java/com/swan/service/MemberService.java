package com.swan.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import com.swan.model.MemberManageDTO;
import com.swan.model.MemberVO;

public interface MemberService {
	// 회원가입
	public void insertMember(MemberVO member) throws Exception;

	// 아이디 중복 검사
	public int idCheck(String id) throws Exception;
	
	// 로그인
    public MemberVO login(MemberVO member) throws Exception;
    
    /* 주문자 정보 */
	public MemberVO getMemberInfo(String id);
	
	/* 내 정보 수정 */
	public int updateMember(MemberVO member) throws Exception;
	
	/* 비밀번호 변경 */
	public int updatePwd(HashMap<String, String> map);
	
	/* 회원 탈퇴 */
	public int deleteMember(String id);
	
	/* 아이디 찾기 */
	public String getId(HttpServletResponse response, String email) throws Exception;
	
	/* 관리자 회원 복구 */
	public void updateMemberAdmin(MemberManageDTO dto);
	
	/* 관리자 회원 탈퇴 */
	public void deleteMemberAdmin(MemberManageDTO dto);
	
	/* 비밀번호 찾기 */
	public void find_pwd(HttpServletResponse response, MemberVO member) throws Exception;

	public void send_mail(MemberVO member) throws Exception;
}
