package com.swan.service;

import com.swan.model.Criteria;
import com.swan.model.ReplyDTO;
import com.swan.model.ReplyPageDTO;

public interface ReplyService {
	/* 리뷰 등록 */
	public int enrollReply(ReplyDTO dto);
	
	/* 리뷰 존재 체크 */
	public String checkReply(ReplyDTO dto);
	
	/* 리뷰 페이징 */
	public ReplyPageDTO replyList(Criteria cri);
	
	/* 리뷰 수정 */
	public int updateReply(ReplyDTO dto);
	
	/* 리뷰 한개 정보(수정 페이지) */
	public ReplyDTO getUpdateReply(int reply_id);
	
	/* 리뷰 삭제 */
	public int deleteReply(ReplyDTO dto);
	
}
