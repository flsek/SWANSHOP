package com.swan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.swan.model.MemberVO;

//  "/cart/**" url을 이용하는 사용자가 요청을 하였을 때 Controller로 요청이 가기 전 요청자가 로그인을 하였는지 확인 하는 것
public class CartInterceptor implements HandlerInterceptor {

	// preHandler 메서드만 사용할 것이기 때문에 preHandler만 오버라이딩
	// source -> Override/Implement Methods
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		MemberVO mvo = (MemberVO) session.getAttribute("member");

		if (mvo == null) {
			response.sendRedirect("/swan");
			return false;
		} else {
			return true;
		}
	}

}
