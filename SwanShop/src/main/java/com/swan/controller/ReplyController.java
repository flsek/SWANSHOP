package com.swan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swan.model.Criteria;
import com.swan.model.ReplyDTO;
import com.swan.model.ReplyPageDTO;
import com.swan.service.ReplyService;

//리뷰 요청 처리의 경우 뷰를 만들지 않고 http body에 바로 데이터를 담아 반환할 것이기 때문에 @RestController 추가
@RestController 
@RequestMapping("/reply") // ReplyController의 모든 매핑 메서드들이 선언하는 URL 앞에 "/reply"가 붙도록 @RequestMapping 추가
public class ReplyController {
	
	@Autowired // ReplyService 객체를 의존성 주입
	private ReplyService replyService;
	
	/* 리뷰 등록 */
	@PostMapping("/enroll")
	// 리뷰 등록 관련 데이터를 모두 속성으로 가지고 있는 ReplyDTO를 파라미터로 지정
	public void enrollReplyPOST(ReplyDTO dto) {
		replyService.enrollReply(dto);
	}
	
	/* 리뷰 체크 */
	/* member_id, product_id 파라미터 */
	/* 존재 : 1 / 존재x : 0 */
	@PostMapping("/check")
	public String replyCheckPOST(ReplyDTO dto) {
		return replyService.checkReply(dto);
	}
	
	/* 리뷰 페이징 */
	// 반환 타입으로 지정한 ReplyPageDTO가 JSON으로 변환되어 뷰에 전송되도록 @GetMapper 어노테이션의 produces 속성 값으로 JSON 지정 코드를 작성
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ReplyPageDTO replyListPOST(Criteria cri) {
		return replyService.replyList(cri);
	}
	
	/* 리뷰 수정 */
	@PostMapping("/update")
	public void replyModifyPOST(ReplyDTO dto) {
		replyService.updateReply(dto);
	}
	
	/* 리뷰 삭제 */
	@PostMapping("/delete")
	public void replyDeletePOST(ReplyDTO dto) {
		replyService.deleteReply(dto);
	}
}
