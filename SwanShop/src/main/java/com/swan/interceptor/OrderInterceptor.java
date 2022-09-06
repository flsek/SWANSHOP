package com.swan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.swan.model.MemberVO;

//"/orders/**" url을 이용하는 사용자가 요청을 하였을 때 Controller로 요청이 가기 전 요청자가 로그인을 하였는지 확인 하는 것
public class OrderInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		MemberVO mvo = (MemberVO) session.getAttribute("member");

		if (mvo == null) {
			response.sendRedirect("/member/login");
			return false;
		} else {
			return true;
		}
	}
	
}
