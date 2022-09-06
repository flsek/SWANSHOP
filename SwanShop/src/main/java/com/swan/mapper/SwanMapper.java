package com.swan.mapper;

import java.util.List;

import com.swan.model.AttachImageVO;
import com.swan.model.CateFilterDTO;
import com.swan.model.CateVO;
import com.swan.model.Criteria;
import com.swan.model.SelectDTO;
import com.swan.model.SwanVO;

public interface SwanMapper {
	/* 상품 리스트 */
	public List<SwanVO> productsGetList(Criteria cri);
	
	/* 상품 총 개수 */
	public int productsGetTotal(Criteria cri);
	
	/* 상품 정보 */
	public SwanVO getGoodsInfo(int product_id);

	/* 상품 이미지 */
	public List<AttachImageVO> getAttachList(int product_id);
	
	/* 상품 id, 이름 */
	public SwanVO getProductIdName(int product_id);
	
	/* 평점 순 상품 정보 */
	public List<SelectDTO> likeSelect();
	
	/* 검색 대상 카테고리 리스트 */
	public String[] getCateList(Criteria cri);
	
	/* 카테고리 정보(+ 검색 대상 개수) */
	public CateFilterDTO getCateInfo(Criteria cri);

	/* 생리대 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 월경컵 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
	/* Y존 케어 카테고리 리스트 */
	public List<CateVO> getCateCode3();

	/* 콘돔 카테고리 리스트 */
	public List<CateVO> getCateCode4();

}
