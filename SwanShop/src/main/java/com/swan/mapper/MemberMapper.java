package com.swan.mapper;

import java.util.HashMap;
import java.util.List;

import com.swan.model.Criteria;
import com.swan.model.MemberVO;
import com.swan.model.OrderDTO;

public interface MemberMapper {
	// 회원가입
	public void insertMember(MemberVO member);
	
	// 아이디 중복 검사
	public int idCheck(String id);
	
	// 로그인
    public MemberVO login(MemberVO member);
    
    /* 주문자 주소 정보 */
	public MemberVO getMemberInfo(String id);
	
	/* 내 정보 수정  */
	public int updateMember(MemberVO member);
	
	/* 회원 탈퇴 */
	public int deleteMember(String id);

	/* 비밀번호 수정 */
	public int updatePwd(HashMap<String, String> map);
	
	/* 아이디 찾기 */
	public String getId(String email);
	
	/* 비밀번호 찾기에서 비밀번호 변경 */
	public int findUpdatePwd(MemberVO member);
	
	/* 관리자 회원 탈퇴 */
	public int deleteMemberAdmin(String id);
	
	/* 관리자 회원 복구 */
	public int updateMemberAdmin(String id);
	
	/* 비밀번호 찾기 */
	public MemberVO login(String id);
	
	/* 주문 상품 리스트 */
	public List<OrderDTO> getOrderList(Criteria cri);
	
	
}
