package com.swan.model;

public class MemberManageDTO {
	/* 회원 관리 기능에 회원 아이디가 필요함 */
	private String id;
	
	/* 관리자가 회원 정보 수정 후 있었던 페이지로 리다이렉트 하도록 할 것.
	 * 기존에 있었던 페이지로 가기 위해선 페이징 정보가 필요함. */
	private String keyword;
	private int amount;
	private int pageNum;
	
	public MemberManageDTO() {}

	public MemberManageDTO(String id, String keyword, int amount, int pageNum) {
		super();
		this.id = id;
		this.keyword = keyword;
		this.amount = amount;
		this.pageNum = pageNum;
	}

	public String getid() {
		return id;
	}

	public void setid(String id) {
		this.id = id;
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
		return "MemberManageDTO [id=" + id + ", keyword=" + keyword + ", amount=" + amount + ", pageNum="
				+ pageNum + "]";
	}
	
}
