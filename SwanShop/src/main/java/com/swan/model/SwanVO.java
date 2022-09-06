package com.swan.model;

import java.sql.Date;
import java.util.List;

public class SwanVO {
	/* 상품 id */
	private int product_id;
	
	/* 상품 명 */
	private String product_title;
	
	/* 상품 설명 */
	private String product_content;
	
	/* 상품 가격 */
	private int product_price;
	
	/* 상품 수량 */
	private int product_stock;
	
	/* 상품 조회수 */
	private int product_count;
	
	/* 대카테고리 */
	private String kind_id;
	
	private String kind_name;
	
	/* 상품 생성 날짜 */
	private Date product_create_date;
	
	/* 상품 수정 날짜 */
	private Date product_modify_date;
	
	/* 상품 상태 */
	private String product_status;
	
	/* 이미지 리스트 */
	private List<AttachImageVO> imageList;
	
	/* 상품 평점 */
	private double ratingavg;	
	
	public SwanVO() {}

	public SwanVO(int product_id, String product_title, String product_content, int product_price, int product_stock,
			int product_count, String kind_id, String kind_name, Date product_create_date, Date product_modify_date,
			String product_status, List<AttachImageVO> imageList, double ratingavg) {
		super();
		this.product_id = product_id;
		this.product_title = product_title;
		this.product_content = product_content;
		this.product_price = product_price;
		this.product_stock = product_stock;
		this.product_count = product_count;
		this.kind_id = kind_id;
		this.kind_name = kind_name;
		this.product_create_date = product_create_date;
		this.product_modify_date = product_modify_date;
		this.product_status = product_status;
		this.imageList = imageList;
		this.ratingavg = ratingavg;
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

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
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

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public String getKind_id() {
		return kind_id;
	}

	public void setKind_id(String kind_id) {
		this.kind_id = kind_id;
	}

	public String getKind_name() {
		return kind_name;
	}

	public void setKind_name(String kind_name) {
		this.kind_name = kind_name;
	}

	public Date getProduct_create_date() {
		return product_create_date;
	}

	public void setProduct_create_date(Date product_create_date) {
		this.product_create_date = product_create_date;
	}

	public Date getProduct_modify_date() {
		return product_modify_date;
	}

	public void setProduct_modify_date(Date product_modify_date) {
		this.product_modify_date = product_modify_date;
	}

	public String getProduct_status() {
		return product_status;
	}

	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	public double getRatingavg() {
		return ratingavg;
	}

	public void setRatingavg(double ratingavg) {
		this.ratingavg = ratingavg;
	}

	@Override
	public String toString() {
		return "SwanVO [product_id=" + product_id + ", product_title=" + product_title + ", product_content="
				+ product_content + ", product_price=" + product_price + ", product_stock=" + product_stock
				+ ", product_count=" + product_count + ", kind_id=" + kind_id + ", kind_name=" + kind_name
				+ ", product_create_date=" + product_create_date + ", product_modify_date=" + product_modify_date
				+ ", product_status=" + product_status + ", imageList=" + imageList + ", ratingavg=" + ratingavg + "]";
	}


}
