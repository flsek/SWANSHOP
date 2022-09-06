package com.swan.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.swan.mapper.AttachMapper;
import com.swan.mapper.CartMapper;
import com.swan.mapper.MemberMapper;
import com.swan.mapper.OrderMapper;
import com.swan.mapper.SwanMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.CartDTO;
import com.swan.model.MemberVO;
import com.swan.model.OrderCancelDTO;
import com.swan.model.OrderDTO;
import com.swan.model.OrderItemDTO;
import com.swan.model.OrderListVO;
import com.swan.model.OrderPageItemDTO;
import com.swan.model.SwanVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired(required=false)
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private OrderMapper orderMapper;

	// 이미지 정보를 가져오는 Service 메서드가 정의된 AttachMapper 객체가 필요
	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private CartMapper cartMapper;

	@Autowired
	private SwanMapper swanMapper;

	@Override
	public List<OrderPageItemDTO> getProductsInfo(List<OrderPageItemDTO> orders) {

		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();

		for (OrderPageItemDTO ord : orders) {

			OrderPageItemDTO productsInfo = orderMapper.getProductsInfo(ord.getProduct_id());

			productsInfo.setProduct_count(ord.getProduct_count());

			productsInfo.initSaleTotal();

			List<AttachImageVO> imageList = attachMapper.getAttachList(productsInfo.getProduct_id());

			productsInfo.setImageList(imageList);

			result.add(productsInfo);
		}

		return result;
	}

	/* 주문 */
	@Override
	@Transactional // 여러 쿼리를 처리하게 되는데 하나의 단위로 처리가 되도록 @Transactional 어노테이션을 추가
	public void order(OrderDTO ord) {
		/* 사용할 데이터가져오기 */
		/* 회원 정보 */
		MemberVO member = memberMapper.getMemberInfo(ord.getMember_id());

		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		for (OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getProduct_id());
			// 수량 셋팅
			orderItem.setProduct_count(oit.getProduct_count());
			
			// 기본 정보 셋팅
			orderItem.initSaleTotal();
			
			// List객체 추가
			ords.add(orderItem);
		}
		/* OrderDTO 셋팅 */
		ord.setOrders(ords);
		ord.getOrderPriceInfo();

		/* DB 주문, 주문 상품, (배송 정보) 넣기 */

		/* order_id만들기 및 OrderDTO객체 order_id에 저장 */
		String order_id = member.getId() + new Date().getTime();
		ord.setOrder_id(order_id);

		/* db넣기 */
		orderMapper.enrollOrder(ord); // orders 등록
		for (OrderItemDTO oit : ord.getOrders()) { // orderItem 등록
			oit.setOrder_id(order_id);
			orderMapper.enrollOrderItem(oit);
		}

		/* 재고 변동 적용 */
		for (OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			SwanVO swan = swanMapper.getGoodsInfo(oit.getProduct_id());
			swan.setProduct_stock(swan.getProduct_stock() - oit.getProduct_count());
			/* 변동 값 DB 적용 */
			orderMapper.deductStock(swan);
		}

		/* 장바구니 제거 */
		for (OrderItemDTO oit : ord.getOrders()) {
			CartDTO dto = new CartDTO();
			dto.setMember_id(ord.getMember_id());
			dto.setProduct_id(oit.getProduct_id());

			cartMapper.deleteOrderCart(dto);
		}
	}

	/* 주문 취소 */
	@Override
	@Transactional // 여러 쿼리가 실행이 되기 때문에 하나의 단위로 동작할 수 있도록 @Transactional 어노테이션을 추가
	public void orderCancle(OrderCancelDTO dto) {
		/* 주문, 주문상품 객체 */
		/* 회원 */
		MemberVO member = memberMapper.getMemberInfo(dto.getMember_id());
		
		/* 주문상품 */
		List<OrderItemDTO> ords = orderMapper.getOrderItemInfo(dto.getOrder_id());
		for (OrderItemDTO ord : ords) {
			ord.initSaleTotal();
		}
		
		/* 주문 */
		OrderDTO orw = orderMapper.getOrder(dto.getOrder_id());
		orw.setOrders(ords);

		orw.getOrderPriceInfo();

		/* 주문상품 취소 DB */
		orderMapper.orderCancle(dto.getOrder_id());

		/* 재고 변환 */
		/* 재고 */
		for (OrderItemDTO ord : orw.getOrders()) {
			SwanVO swan = swanMapper.getGoodsInfo(ord.getProduct_id());
			swan.setProduct_stock(swan.getProduct_stock() + ord.getProduct_count());
			orderMapper.deductStock(swan);
		}

	}

	/* 특정 유저의 주문 목록 */
	@Override
	public List<OrderDTO> orderList(OrderDTO order) throws Exception{
		return orderMapper.orderList(order);
	}

	/* 특정 주문 목록 */
	@Override
	public List<OrderListVO> orderView(OrderDTO order) throws Exception {
		List<OrderListVO> orderView = orderMapper.orderView(order);
		
		for(OrderListVO ord : orderView) {
			
			/* 이미지 정보 얻기 */
			int product_id = ord.getProduct_id();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(product_id);
			
			ord.setImageList(imageList);
		}
		
		return orderView;
	}

	

}
