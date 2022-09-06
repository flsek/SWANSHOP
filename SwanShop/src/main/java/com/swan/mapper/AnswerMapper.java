package com.swan.mapper;

import java.util.List;

import com.swan.model.AnswerDTO;
import com.swan.model.Criteria;

public interface AnswerMapper {
	/* 답변 등록 */
	public int enrollAnswer(AnswerDTO dto);
	
	/* 답변 수정 */
	public int updateAnswer(AnswerDTO dto);
	
	/* 답변 수정 페이지 */
	public AnswerDTO getUpdateAnswer(int a_id);
	
	/* 답변 삭제 */
	public int deleteAnswer(int a_id);

	/* 답변 페이징 */
	public List<AnswerDTO> getAnswerList(Criteria cri);
	
	/* 답변 총 개수 */
	public int getAnswerTotal(int q_id);
}
