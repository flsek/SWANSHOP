package com.swan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.swan.model.CartDTO;
import com.swan.model.MemberVO;
import com.swan.service.CartService;

@Controller
public class CartController {

	@Autowired // 의존성 주입
	private CartService cartService;

	/*
	 * 1. 개요
	 * 
	 * 2. 수량 버튼
	 * 
	 * 3. '장바구니 추가' 버튼
	 * 
	 * 4. 테스트
	 */
	
	// 장바구니 추가 요청을 처리하는 URL 매핑 메서드를 작성
	@PostMapping("/cart/add")
	@ResponseBody // 화면을 반환하는 것이 아니라 데이터를 반환하기 때문에 @ResponseBody 추가
	public String addCartPOST(CartDTO cart, HttpServletRequest request) {
		// 로그인 체크
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		if (mvo == null) {
			return "5";
		}

		// 카트 등록

		int result = cartService.addCart(cart);
		return result + "";
	}
	
	// 장바구니 뷰 페이지 이동 요청을 수행하는 URL매핑 메서드를 추가
	@GetMapping("/cart/{member_id}")
	public String cartPageGET(@PathVariable("member_id") String member_id, Model model) {
		model.addAttribute("cartInfo", cartService.getCartList(member_id));
		
		return "/cart";
	}
	
	/* 장바구니 수량 수정 */
	@PostMapping("/cart/update")
	public String updateCartPOST(CartDTO cart) {
		
		cartService.modifyCount(cart);
		
		return "redirect:/cart/" + cart.getMember_id();
	}
	
	/* 장바구니 수량 수정 */
	@PostMapping("/cart/delete")
	public String deleteCartPOST(CartDTO cart) {
		
		cartService.deleteCart(cart.getCart_id());
		
		return "redirect:/cart/" + cart.getMember_id();
		
	}
}
