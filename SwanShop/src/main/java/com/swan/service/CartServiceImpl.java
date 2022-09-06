package com.swan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swan.mapper.AttachMapper;
import com.swan.mapper.CartMapper;
import com.swan.mapper.SwanMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private AttachMapper attachMapper;

	@Override
	public int addCart(CartDTO cart) {
		// 장바구니 데이터 체크
		CartDTO checkCart = cartMapper.checkCart(cart);

		if (checkCart != null) {
			return 2;
		}

		// 장바구니 등록 & 에러 시 0 반환
		// addCart()가 "throws Exception" 통해서 예외를 던지도록 했기 때문에 이 메서드를 호출할 때 try-catch 문으로 감싸주어야 함.
		try {
			return cartMapper.addCart(cart);
		} catch (Exception e) {
			return 0;
		}
	}

	/* 장바구니 정보 리스트 */
	@Override
	public List<CartDTO> getCartList(String member_id) {
		// List <CartDTO> 타입의 cart 변수를 선언하여 사용자의 장바구니 정보를 모두 가져오는 getCart() Mapper 메서드를 호출
		List<CartDTO> cart = cartMapper.getCart(member_id);
		
		for(CartDTO dto : cart) {
			// 종합 정보 초기화
			dto.initSaleTotal();
			
			/* 이미지 정보 얻기 */
			int product_id = dto.getProduct_id();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(product_id);
			
			dto.setImageList(imageList);
		}
		
		return cart;
	}
	
	/* 장바구니 수량 수정 */
	@Override
	public int modifyCount(CartDTO cart) {
		return cartMapper.modifyCount(cart);
	}

	/* 장바구니 수량 수정 */
	@Override
	public int deleteCart(int cart_id) {
		return cartMapper.deleteCart(cart_id);
	}

}
