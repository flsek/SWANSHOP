package com.swan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.swan.model.MemberVO;

// 관리자 메서드("/admin/**")에 접근하는 사용자의 admiCk 1인지 확인하는 작업이 핵심
// "member"session정보를 MemberVO타입의 변수에 담은 후, 해당 변수를 통해 admin_ck의 값을 호출하여 비교하는 로직을 작성
public class AdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();

		// "member" session을 호출하여 MemberVO타입의 lvo 변수에 저장
		// MemberVO 타입으로 형 변환(Casting)
		MemberVO lvo = (MemberVO) session.getAttribute("member");

		// if문을 통해서 lvo가 null이거나 getAdminCk() 메서드 반환 값이 0이면 main페이지로 리다이렉트 되도록 코드를 추가 후
		// false를 반환하도록 로직을 작성
		if (lvo == null || lvo.getAdmin_ck() == 0) { // 관리자 계정 아닌 경우

			response.sendRedirect("/swan"); // 메인페이지로 리다이렉트

			return false;

		}
		return true; // 관리자 계정 로그인 경우(lvo != null && lvo.getAdmin_ck() == 1)
	}

}
