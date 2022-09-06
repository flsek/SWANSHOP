package com.swan.model;

// 추가적인 데이터들을  Mapper에 전달하기 위해서, 쿼리문에 생성에 필요로 한 데이터를 전달하는 용도로 생성
public class Criteria {
	/* 현재 페이지 번호 */
	private int pageNum;
	
	/* 페이지 표시 개수 */
	private int amount;
	
	/* 검색 타입 */
	private String type;
	
	/* 검색 키워드 */
	private String keyword;
	
	/* 카테고리 코드 */
	private String kind_id;
	
	/* 상품 번호(리뷰 기능에서 사용) */
	private int product_id;
	
	/* 문의사항 번호(답변 기능에서 사용) */
	private int q_id;
	
	/* Criteria 생성자 */
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	/* Criteria 기본 생성자 */
	public Criteria(){
		this(1,10);
	}
	
	/* 검색 타입 데이터 배열 변환 */
	public String[] getTypeArr() {
		return type == null? new String[] {}:type.split("");
	}

	public Criteria(int pageNum, int amount, String type, String keyword, String kind_id, int product_id, int q_id) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
		this.type = type;
		this.keyword = keyword;
		this.kind_id = kind_id;
		this.product_id = product_id;
		this.q_id = q_id;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getkind_id() {
		return kind_id;
	}

	public void setkind_id(String kind_id) {
		this.kind_id = kind_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword
				+ ", kind_id=" + kind_id + ", product_id=" + product_id + ", q_id=" + q_id + "]";
	}


	
	
	
}
