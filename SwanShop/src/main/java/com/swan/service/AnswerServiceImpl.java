package com.swan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.swan.mapper.AnswerMapper;
import com.swan.model.AnswerDTO;
import com.swan.model.AnswerPageDTO;
import com.swan.model.Criteria;
import com.swan.model.PageDTO;

@Controller
public class AnswerServiceImpl implements AnswerService{

	@Autowired
	private AnswerMapper answerMapper;
	
	/* 답변 등록 */
	@Override
	public int enrollAnswer(AnswerDTO dto) {
		int result = answerMapper.enrollAnswer(dto);
	
		return result;
	}

	/* 답변 수정 */
	@Override
	public int updateAnswer(AnswerDTO dto) {
		int result = answerMapper.updateAnswer(dto);
		
		return result;
	}

	/* 답변 수정 페이지 */
	@Override
	public AnswerDTO getUpdateAnswer(int a_id) {
		return answerMapper.getUpdateAnswer(a_id);
	}

	/* 답변 삭제 */
	@Override
	public int deleteAnswer(AnswerDTO dto) {
		int result = answerMapper.deleteAnswer(dto.getA_id());
		
		return result;	
	}

	/* 답변 리스트 */
	@Override
	public AnswerPageDTO answerList(Criteria cri) {
		
		AnswerPageDTO dto = new AnswerPageDTO();
		dto.setList(answerMapper.getAnswerList(cri));
		
		dto.setPageInfo(new PageDTO(cri, answerMapper.getAnswerTotal(cri.getQ_id())));
		
		return dto;
	}

}
