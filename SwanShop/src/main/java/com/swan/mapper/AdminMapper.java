package com.swan.mapper;

import java.util.List;

import com.swan.model.AttachImageVO;
import com.swan.model.CateVO;
import com.swan.model.Criteria;
import com.swan.model.MemberVO;
import com.swan.model.OrderDTO;
import com.swan.model.QuestionVO;
import com.swan.model.SwanVO;

// 상품 등록 쿼리를 실행할 Mapper 메서드를 작성
public interface AdminMapper {
	/* 상품 등록 */
	public void swanEnroll(SwanVO swan);
	
	/* 카테고리 리스트 */
	public List<CateVO> cateList();
	
	/* 상품 리스트 */
	public List<SwanVO> productsGetList(Criteria cri);
	
	/* 상품 총 개수 */
	public int productsGetTotal(Criteria cri);
	
	/* 상품 조회 페이지 */
	public SwanVO productsGetDetail(int product_id);
	
	/* 상품 수정 */
	public int productsModify(SwanVO vo);
	
	/* 상품 정보 삭제 */
	public int productsDelete(int product_id);
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImageVO vo);
	
	/* 지정 상품 이미지 전체 삭제 */
	public void deleteImageAll(int product_id);
	
	/* 어제자 날짜 이미지 리스트 */
	public List<AttachImageVO> checkFileList();
	
	/* 지정 상품 이미지 정보 얻기 */
	public List<AttachImageVO> getAttachInfo(int product_id);

	/* 주문 상품 리스트 */
	public List<OrderDTO> getOrderList(Criteria cri);

	/* 주문 총 개수 */
	public int getOrderTotal(Criteria cri);

	/* 카테고리 리스트 */
	public String[] getCateList(Criteria cri);
	
	/* 문의사항 리스트 */
	public List<QuestionVO> getQuestionList(Criteria cri);
	
	/* 문의사항 총 개수 */
	public int getQuestionTotal(Criteria cri);

	/* 회원 리스트 */
	public List<MemberVO> getMemberList(Criteria cri);
	
	/* 총 회원 수 */
	public int getMemberTotal(Criteria cri);
	
	
}
