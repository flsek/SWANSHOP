package com.swan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

// 이전 작업 중 세션이 완전히 제거되지 않아 로그인을 위해 새로운 세션을 저장할 때 발생할 수 있는 에러를 방지
// 해당 클래스를 Interceptor로 사용하기 위해서 클래스 선언부에 HandlerInterceptor 상속을 선언
public class LoginInterceptor implements HandlerInterceptor {
	// 하고자 하는 작업은 Controller에 진입하기 전에 작업을 원하기 때문에 preHandle() 메서드를 오버 라이딩
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// preHandle() 메서드 구현부에 세션을 제거해주는 코드를 추가
		System.out.println("LoginInterceptor preHandle 작동");
		HttpSession session = request.getSession();
		session.invalidate();

		return true;
	}
}
