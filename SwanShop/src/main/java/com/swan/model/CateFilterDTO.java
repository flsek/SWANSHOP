package com.swan.model;

public class CateFilterDTO {

	/* 카테고리 이름 */
	private String kind_name;
	
	/* 카테고리 넘버 */
	private String kind_id;
	
	/* 카테고리 상품 수 */
	private int cateCount;
	
	/* 대분류 */
	private String cateGroup;
	
	public CateFilterDTO() {}

	public CateFilterDTO(String kind_name, String kind_id, int cateCount, String cateGroup) {
		super();
		this.kind_name = kind_name;
		this.kind_id = kind_id;
		this.cateCount = cateCount;
		this.cateGroup = cateGroup;
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
		
		// cateGroup은 생리대의 경우 1, 월경컵의 경우 2, Y존 케어의 경우3, 콘돔일 경우 4의 값이 되도록 할 것
		this.cateGroup = kind_id.split("")[0];
	}

	public int getCateCount() {
		return cateCount;
	}

	public void setCateCount(int cateCount) {
		this.cateCount = cateCount;
	}

	public String getCateGroup() {
		return cateGroup;
	}

	public void setCateGroup(String cateGroup) {
		this.cateGroup = cateGroup;
	}

	@Override
	public String toString() {
		return "CateFilterDTO [kind_name=" + kind_name + ", kind_id=" + kind_id + ", cateCount=" + cateCount
				+ ", cateGroup=" + cateGroup + "]";
	}
	
	
}
