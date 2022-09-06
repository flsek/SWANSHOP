package com.swan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swan.mapper.QuestionMapper;
import com.swan.model.Criteria;
import com.swan.model.QuestionVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QuestionServiceImpl implements QuestionService{
	
	@Autowired
	private QuestionMapper questionMapper;
	
	/* 문의사항 등록 */
	@Override
	public void questionEnroll(QuestionVO question) {
		
		log.info("(service)questionEnroll........");
		
		questionMapper.questionEnroll(question);
	}

	/* 문의사항 리스트 */
	@Override
	public List<QuestionVO> questionGetList(Criteria cri) {
		log.info("questionGetList()..........");
		List<QuestionVO> list = questionMapper.questionGetList(cri);
		return list;
	}

	/* 문의사항 총 개수 */
	@Override
	public int questionGetTotal(Criteria cri) {
		log.info("questionGetTotal().........");

		return questionMapper.questionGetTotal(cri);
	}

	/* 문의사항 상세 페이지 */
	@Override
	public QuestionVO questionGetDetail(int q_id) {
		log.info("(service)questionGetDetail......." + q_id);
		
		int result = questionMapper.addReadCount(q_id);
		QuestionVO question = null;
		if(result > 0) {
			question = questionMapper.questionGetDetail(q_id);
		}
		
		return question;
	}

	/* 문의사항 수정 */
	@Override
	public int questionModify(QuestionVO vo) {
		int result = questionMapper.questionModify(vo);
		return result;
	}

	/* 문의사항 삭제 */
	@Override
	public int questionDelete(int q_id) {
		log.info("questionDelete..........");
		return questionMapper.questionDelete(q_id);
	}

	/* 문의사항 id, 제목 */
	@Override
	public QuestionVO getQuestionIdName(int q_id) {
		return questionMapper.getQuestionIdName(q_id);
	}

}
