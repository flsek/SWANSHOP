package com.swan.model;

// OrderPageItemDTO에서 선언한 클래스를 generic 타입으로 가지는 List 타입의 변수를 선언
import java.util.List;

public class OrderPageDTO {

	public OrderPageDTO() {}
	
	private List<OrderPageItemDTO> orders;

	public List<OrderPageItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderPageItemDTO> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderPageDTO [orders=" + orders + "]";
	}
	
	
}