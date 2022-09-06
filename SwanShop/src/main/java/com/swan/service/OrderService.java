package com.swan.service;

import java.util.List;

import com.swan.model.OrderCancelDTO;
import com.swan.model.OrderDTO;
import com.swan.model.OrderListVO;
import com.swan.model.OrderPageItemDTO;

public interface OrderService {
	/* 주문 정보 */
	public List<OrderPageItemDTO> getProductsInfo(List<OrderPageItemDTO> orders);
	
	/* 주문 */
	public void order(OrderDTO ord);
	
	/* 주문 취소 */
	public void orderCancle(OrderCancelDTO dto);

	/* 특정 유저의 주문 목록 */
	public List<OrderDTO> orderList(OrderDTO order) throws Exception;
	
	/* 특정 주문 목록 */
	public List<OrderListVO> orderView(OrderDTO order) throws Exception;
}
