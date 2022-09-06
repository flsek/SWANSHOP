package com.swan.model;

public class OrderCancelDTO {
	/* 주문 취소 기능에 회원 아이디와 주문 아이디가 필요함. */
	private String member_id;
	private String order_id;
	
	/* 주문 취소 완료 후 사용자가 있었던 페이지로 리다이렉트 하도록 할 것. 기존에 있었던 페이지로 가기 위해선 페이징 정보가 필요함. */
	private String keyword;
	private int amount;
	private int pageNum;
	
	public OrderCancelDTO() {}

	public OrderCancelDTO(String member_id, String order_id, String keyword, int amount, int pageNum) {
		super();
		this.member_id = member_id;
		this.order_id = order_id;
		this.keyword = keyword;
		this.amount = amount;
		this.pageNum = pageNum;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	@Override
	public String toString() {
		return "OrderCancelDTO [member_id=" + member_id + ", order_id=" + order_id + ", keyword=" + keyword
				+ ", amount=" + amount + ", pageNum=" + pageNum + "]";
	}
	
	
}
