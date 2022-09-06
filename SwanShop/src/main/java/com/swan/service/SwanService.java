package com.swan.service;

import java.util.List;

import com.swan.model.CateFilterDTO;
import com.swan.model.CateVO;
import com.swan.model.Criteria;
import com.swan.model.SelectDTO;
import com.swan.model.SwanVO;

public interface SwanService {
	
	/* 상품 총 개수 */
	int productsGetTotal(Criteria cri);
	
	/* 상품 검색 */
	List<SwanVO> productsGetList(Criteria cri);
	
	/* 상품 정보 */
	public SwanVO getProductsInfo(int product_id);

	/* 상품 id, 이름 */
	public SwanVO getProductIdName(int product_id);

	/* 평점 순 상품 정보 */
	public List<SelectDTO> likeSelect();

	/* 생리대 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 월경컵 카테고리 리스트 */
	public List<CateVO> getCateCode2();	
	
	/* Y존 케어 카테고리 리스트 */
	public List<CateVO> getCateCode3();	
	
	/* 콘돔 카테고리 리스트 */
	public List<CateVO> getCateCode4();	
	
	/* 검색 결과 카테고리 필터 정보 */
	public List<CateFilterDTO> getCateInfoList(Criteria cri);
}
