package com.swan.model;

import java.util.List;

public class CartDTO {
	private int cart_id;
	private String member_id;
	private int product_id;
	private int product_count;
	
	// swan
	private String product_title;
	private int product_price;
	private int product_stock;
	
	// 추가
	private int totalPrice;
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;
	
	public CartDTO() {}

	

	@Override
	public String toString() {
		return "CartDTO [cart_id=" + cart_id + ", member_id=" + member_id + ", product_id=" + product_id
				+ ", product_count=" + product_count + ", product_title=" + product_title + ", product_price="
				+ product_price + ", product_stock=" + product_stock + ", totalPrice=" + totalPrice + ", imageList="
				+ imageList + "]";
	}



	public int getCart_id() {
		return cart_id;
	}



	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}



	public String getMember_id() {
		return member_id;
	}



	public void setMember_id(String member_id) {
		this.member_id = member_id;
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



	public String getProduct_title() {
		return product_title;
	}



	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}



	public int getProduct_price() {
		return product_price;
	}



	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}



	public int getProduct_stock() {
		return product_stock;
	}



	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}



	public int getTotalPrice() {
		return totalPrice;
	}



	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}



	public List<AttachImageVO> getImageList() {
		return imageList;
	}



	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}



	public CartDTO(int cart_id, String member_id, int product_id, int product_count, String product_title,
			int product_price, int product_stock, int totalPrice, List<AttachImageVO> imageList) {
		super();
		this.cart_id = cart_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.product_count = product_count;
		this.product_title = product_title;
		this.product_price = product_price;
		this.product_stock = product_stock;
		this.totalPrice = totalPrice;
		this.imageList = imageList;
	}



	// totalPric 초기화
	public void initSaleTotal() {
		this.totalPrice = this.product_price * this.product_count;
	}
	
	
	
	
}
