package com.swan.model;

import java.sql.Date;
import java.util.List;


/*  뷰에서 전송하는 '주문 정보' 데이터를 담을 DTO 클래스 */
/* "여러 개"의 '주문 상품 정보'를 담음. 여러 개의 주문 상품 정보를 담는 방식은 OrderItemDTO를 요소를 가지는 List 객체를 통해 '여러 주문 상품 정보'를 가지게 됨. */
public class OrderDTO {
	/* 주문 번호 */
	private String order_id;
	
	/* 배송 받는이 */
	private String addressee;
	
	/* 주문 회원 아이디 */
	private String member_id;
	
	/* 회원 주소 */
	private String address;
	
	/* 회원 상세주소 */
	private String address2;
	
	/* 주문 상태 */
	private String order_state;
	
	/* 주문 상품 */
	private List<OrderItemDTO> orders;
	
	/* 배송비 */
	private int deliverycost;
	
	/* 주문 날짜 */
	private Date order_date;
	
	/* DB테이블 존재 하지 않는 데이터 */
	/* 판매가(모든 상품 비용) */
	private int orderPrice;
	
	/* 최종 판매 비용 */
	private int orderFinalPrice;
	
	public OrderDTO() {}
	
	public OrderDTO(String order_id, String addressee, String member_id, String address, String address2,
			String order_state, List<OrderItemDTO> orders, int deliverycost, Date order_date, int orderPrice,
			int orderFinalPrice) {
		super();
		this.order_id = order_id;
		this.addressee = addressee;
		this.member_id = member_id;
		this.address = address;
		this.address2 = address2;
		this.order_state = order_state;
		this.orders = orders;
		this.deliverycost = deliverycost;
		this.order_date = order_date;
		this.orderPrice = orderPrice;
		this.orderFinalPrice = orderFinalPrice;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public String getAddressee() {
		return addressee;
	}

	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getOrder_state() {
		return order_state;
	}

	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	public List<OrderItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderItemDTO> orders) {
		this.orders = orders;
	}

	public int getDeliverycost() {
		return deliverycost;
	}

	public void setDeliverycost(int deliverycost) {
		this.deliverycost = deliverycost;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public int getOrderFinalPrice() {
		return orderFinalPrice;
	}

	public void setOrderFinalPrice(int orderFinalPrice) {
		this.orderFinalPrice = orderFinalPrice;
	}
	
	@Override
	public String toString() {
		return "OrderDTO [order_id=" + order_id + ", addressee=" + addressee + ", member_id=" + member_id + ", address="
				+ address + ", address2=" + address2 + ", order_state=" + order_state + ", orders=" + orders
				+ ", deliverycost=" + deliverycost + ", order_date=" + order_date + ", orderPrice=" + orderPrice
				+ ", orderFinalPrice=" + orderFinalPrice + "]";
	}

	public void getOrderPriceInfo() {
		/* 상품 비용 */
			for(OrderItemDTO order : orders) {
				orderPrice += order.getTotalPrice();
			}
		/* 배송비용 */
			if(orderPrice >= 30000) {
				deliverycost = 0;
			} else {
				deliverycost = 3000;
			}
		/* 최종 비용(상품 비용 + 배송비 ) */
			orderFinalPrice = orderPrice + deliverycost;
	}
}
