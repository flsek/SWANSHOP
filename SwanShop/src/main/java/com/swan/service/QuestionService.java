package com.swan.service;

import java.util.List;

import com.swan.model.Criteria;
import com.swan.model.QuestionVO;

public interface QuestionService {
	/* 문의사항 등록 */
	public void questionEnroll(QuestionVO question);
	
	/* 문의사항 리스트 */
	public List<QuestionVO> questionGetList(Criteria cri);
	
	/* 문의사항 총 개수 */
	public int questionGetTotal(Criteria cri);
	
	/* 문의사항 상세 페이지 */
	public QuestionVO questionGetDetail(int q_id);
	
	/* 문의사항 수정 */
	public int questionModify(QuestionVO vo);
	
	/* 문의사항 삭제 */
	public int questionDelete(int q_id);
	
	/* 문의사항 id, 제목 */
	public QuestionVO getQuestionIdName(int q_id);
}
