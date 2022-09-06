package com.swan.model;

public class CateVO {
	
	/* 카테고리 등급 */
	private int tier;
	
	/* 카테고리 이름 */
	private String kind_name;
	
	/* 카테고리 넘버*/
	private String kind_id;
	
	/* 상위 카테고리 */
	private String cateparent;
	
	public CateVO() {}

	public CateVO(int tier, String kind_name, String kind_id, String cateparent) {
		super();
		this.tier = tier;
		this.kind_name = kind_name;
		this.kind_id = kind_id;
		this.cateparent = cateparent;
	}

	public int getTier() {
		return tier;
	}

	public void setTier(int tier) {
		this.tier = tier;
	}

	public String getKind_name() {
		return kind_name;
	}

	public void setKind_name(String kind_name) {
		this.kind_name = kind_name;
	}

	public String getKind_id() {
		return kind_id;
	}

	public void setKind_id(String kind_id) {
		this.kind_id = kind_id;
	}

	public String getCateparent() {
		return cateparent;
	}

	public void setCateparent(String cateparent) {
		this.cateparent = cateparent;
	}

	@Override
	public String toString() {
		return "CateVO [tier=" + tier + ", kind_name=" + kind_name + ", kind_id=" + kind_id + ", cateparent="
				+ cateparent + "]";
	}
	
}
