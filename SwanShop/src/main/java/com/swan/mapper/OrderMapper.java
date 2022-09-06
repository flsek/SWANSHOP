package com.swan.mapper;

import java.util.List;

import com.swan.model.OrderDTO;
import com.swan.model.OrderItemDTO;
import com.swan.model.OrderListVO;
import com.swan.model.OrderPageItemDTO;
import com.swan.model.SwanVO;

public interface OrderMapper {
	/* 주문 상품 정보 */	
	public OrderPageItemDTO getProductsInfo(int product_id);
	
	/* 주문 상품 정보(주문 처리) */	
	public OrderItemDTO getOrderInfo(int product_id);
	
	/* 주문 테이블 등록 */
	public int enrollOrder(OrderDTO ord);
	
	/* 주문 아이템 테이블 등록 */
	public int enrollOrderItem(OrderItemDTO orid);
	
	/* 주문 재고 차감 */
	public int deductStock(SwanVO swan);
	
	/* 주문 취소 */
	public int orderCancle(String order_id);
	
	/* 주문 상품 정보(주문취소) */
	public List<OrderItemDTO> getOrderItemInfo(String order_id);
	
	/* 주문 정보(주문취소) */
	public OrderDTO getOrder(String order_id);

	/* 특정 유저의 주문 목록 */ 
	public List<OrderDTO> orderList(OrderDTO order);
	
	/* 특정 주문 목록 */
	public List<OrderListVO> orderView(OrderDTO order);
	
	 
}
