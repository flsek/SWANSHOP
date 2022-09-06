package com.swan.model;

import java.sql.Date;
import java.util.List;

public class OrderListVO {
	/* 주문 번호 */
	private String order_id;
	/* 받는 사람 */
	private String addressee;
	/* 주문 회원 아이디 */
	private String member_id;
	/* 주소 */
	private String address;
	/* 상세 주소 */
	private String address2;
	/* 배송비 */
	private int deliverycost;
	/* 주문 날짜 */
	private Date order_date;
	/* 상품 아이디 */
	private int product_id;
	/* 상품 수량 */
	private int product_count;
	/* 상품 가격 */
	private int product_price;
	/* 상품명 */
	private String product_title;
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;
	
	public OrderListVO() {}

	public OrderListVO(String order_id, String addressee, String member_id, String address, String address2,
			int deliverycost, Date order_date, int product_id, int product_count, int product_price,
			String product_title, List<AttachImageVO> imageList) {
		super();
		this.order_id = order_id;
		this.addressee = addressee;
		this.member_id = member_id;
		this.address = address;
		this.address2 = address2;
		this.deliverycost = deliverycost;
		this.order_date = order_date;
		this.product_id = product_id;
		this.product_count = product_count;
		this.product_price = product_price;
		this.product_title = product_title;
		this.imageList = imageList;
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

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "OrderListVO [order_id=" + order_id + ", addressee=" + addressee + ", member_id=" + member_id
				+ ", address=" + address + ", address2=" + address2 + ", deliverycost=" + deliverycost + ", order_date="
				+ order_date + ", product_id=" + product_id + ", product_count=" + product_count + ", product_price="
				+ product_price + ", product_title=" + product_title + ", imageList=" + imageList + "]";
	}
	
	
}
