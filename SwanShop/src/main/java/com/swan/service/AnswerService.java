package com.swan.service;

import com.swan.model.AnswerDTO;
import com.swan.model.AnswerPageDTO;
import com.swan.model.Criteria;

public interface AnswerService {
	/* 답변 등록 */
	public int enrollAnswer(AnswerDTO dto);
	
	/* 답변 수정 */
	public int updateAnswer(AnswerDTO dto);
	
	/* 답변 한개 정보(수정 페이지) */
	public AnswerDTO getUpdateAnswer(int a_id);
	
	/* 답변 삭제 */
	public int deleteAnswer(AnswerDTO dto);

	/* 답변 리스트 */
	public AnswerPageDTO answerList(Criteria cri);
}
