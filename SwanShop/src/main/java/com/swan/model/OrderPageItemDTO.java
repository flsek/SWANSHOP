package com.swan.model;

import java.util.List;

// 상품 데이터를 담을 클래스
public class OrderPageItemDTO {

	/* 뷰로부터 전달받을 값 */
    private int product_id;
    
    private int product_count;
    
	/* DB로부터 꺼내올 값 */
    private String product_title;
    
    private int product_price;
    
	/* 만들어 낼 값 */
    private int totalPrice;
    
    /* 상품 이미지 */
	private List<AttachImageVO> imageList;

    public OrderPageItemDTO() {}
    
	
	public OrderPageItemDTO(int product_id, int product_count, String product_title, int product_price, int totalPrice,
			List<AttachImageVO> imageList) {
		super();
		this.product_id = product_id;
		this.product_count = product_count;
		this.product_title = product_title;
		this.product_price = product_price;
		this.totalPrice = totalPrice;
		this.imageList = imageList;
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

	
	
	@Override
	public String toString() {
		return "OrderPageItemDTO [product_id=" + product_id + ", product_count=" + product_count + ", product_title="
				+ product_title + ", product_price=" + product_price + ", totalPrice=" + totalPrice + ", imageList="
				+ imageList + "]";
	}


	public void initSaleTotal() {
		this.totalPrice = this.product_price*this.product_count;
	}
}
