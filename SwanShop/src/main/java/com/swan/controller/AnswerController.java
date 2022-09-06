package com.swan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swan.model.AnswerDTO;
import com.swan.model.AnswerPageDTO;
import com.swan.model.Criteria;
import com.swan.service.AnswerService;

//리뷰 요청 처리의 경우 뷰를 만들지 않고 http body에 바로 데이터를 담아 반환할 것이기 때문에 @RestController 추가
@RestController 
@RequestMapping("/answer") // AnswerController의 모든 매핑 메서드들이 선언하는 URL 앞에 "/answer"이 붙도록 함.
public class AnswerController {

	@Autowired
	private AnswerService answerService;
	
	/* 답변 등록 */
	@PostMapping("/enroll")
	// 답변 등록 관련 데이터를 모두 속성으로 가지고 있는 AnswerDTO를 파라미터로 지정
	public void enrollAnswerPOST(AnswerDTO dto) {
		answerService.enrollAnswer(dto);
	}
	
	/* 답변  리스트 */
	// 반환 타입으로 지정한 AnswerPageDTO가 JSON으로 변환되어 뷰에 전송되도록 @GetMapper 어노테이션의 produces 속성 값으로 JSON 지정 코드를 작성
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public AnswerPageDTO answerListPOST(Criteria cri) {
		return answerService.answerList(cri);
	}
	
	/* 답변 수정 */
	@PostMapping("/update")
	public void AnswerModifyPOST(AnswerDTO dto) {
		answerService.updateAnswer(dto);
	}
	
	/* 답변 삭제 */
	@PostMapping("/delete")
	public void AnswerDeletePOST(AnswerDTO dto) {
		answerService.deleteAnswer(dto);
	}
}
