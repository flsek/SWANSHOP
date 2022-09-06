package com.swan.model;
/*
 * 평점 평균 값을 product 테이블의 ratingAvg에 반영할 때 실행될 쿼리에는 '반영 할 평점 평균 값'과 
 * 어떠한 상품 평균 값을 구할지에 대한 조건인 '상품 번호(product_id)'가 필요함.
 * 평균 값 반영 쿼리를 실행 할 Mapper 메서드에 
 * 두 개의 데이터를 한 번에 전달 할 수 있도록 DTO클래스를 새로 작성
 * */
public class UpdateReplyDTO {

	private int product_id;
	private double ratingavg;
	
	public UpdateReplyDTO() {}

	public UpdateReplyDTO(int product_id, double ratingavg) {
		super();
		this.product_id = product_id;
		this.ratingavg = ratingavg;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public double getRatingavg() {
		return ratingavg;
	}

	public void setRatingavg(double ratingavg) {
		this.ratingavg = ratingavg;
	}

	@Override
	public String toString() {
		return "UpdateReplyDTO [product_id=" + product_id + ", ratingavg=" + ratingavg + "]";
	}
	
	
}
