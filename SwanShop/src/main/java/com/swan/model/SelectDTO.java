package com.swan.model;

import java.util.List;

// 메인페이지에 평점이 높은 상품 노출을 구현
// 노출 시킬 정보는 '상품 이미지', '상품 이름', '상품 카테고리', '상품 평점'
public class SelectDTO {

	/* 상품 id */
	private int product_id;
	
	/* 상품 이름 */
	private String product_title;
	
	/* 카테고리 이름 */
	private String kind_name;
	
	/* 평점 */
	private double ratingavg;	
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;
	
	public SelectDTO() {}

	public SelectDTO(int product_id, String product_title, String kind_name, double ratingavg,
			List<AttachImageVO> imageList) {
		super();
		this.product_id = product_id;
		this.product_title = product_title;
		this.kind_name = kind_name;
		this.ratingavg = ratingavg;
		this.imageList = imageList;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public String getKind_name() {
		return kind_name;
	}

	public void setKind_name(String kind_name) {
		this.kind_name = kind_name;
	}

	public double getRatingavg() {
		return ratingavg;
	}

	public void setRatingavg(double ratingavg) {
		this.ratingavg = ratingavg;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "SelectDTO [product_id=" + product_id + ", product_title=" + product_title + ", kind_name=" + kind_name
				+ ", ratingavg=" + ratingavg + ", imageList=" + imageList + "]";
	}

	
}
