package com.swan.model;

/* "하나"의 '주문 상품 정보'를 담는 클래스 */

public class OrderItemDTO {
	/* OrderItem 기본키 */
	private int order_item_id;
	
	/* 주문 번호 */
	private String order_id;
	
	/* 상품 번호 */
	private int product_id;
	
	/* 주문 수량 */
	private int product_count;
	
	/* 상품 한 개 가격 */
	private int product_price;
	
	/* DB테이블 존재 하지 않는 데이터 */
	/* 총 가격(적용된 가격 * 주문 수량) */
    private int totalPrice;
    
    public OrderItemDTO() {}

	public OrderItemDTO(int order_item_id, String order_id, int product_id, int product_count, int product_price,
			int totalPrice) {
		super();
		this.order_item_id = order_item_id;
		this.order_id = order_id;
		this.product_id = product_id;
		this.product_count = product_count;
		this.product_price = product_price;
		this.totalPrice = totalPrice;
	}

	public int getOrder_item_id() {
		return order_item_id;
	}

	public void setOrder_item_id(int order_item_id) {
		this.order_item_id = order_item_id;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [order_item_id=" + order_item_id + ", order_id=" + order_id + ", product_id=" + product_id
				+ ", product_count=" + product_count + ", product_price=" + product_price + ", totalPrice=" + totalPrice
				+ "]";
	}

	/* 주문 작업에 필요로 한 데이터를 세팅해주는 메서드를 추가 */
	public void initSaleTotal() {
		this.totalPrice = this.product_price*this.product_count;
	}
}
