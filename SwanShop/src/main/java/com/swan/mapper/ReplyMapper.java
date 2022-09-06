package com.swan.mapper;

import java.util.List;

import com.swan.model.Criteria;
import com.swan.model.ReplyDTO;
import com.swan.model.UpdateReplyDTO;

public interface ReplyMapper {
	/* 리뷰 등록 */
	public int enrollReply(ReplyDTO dto);
	
	/* 리뷰 존재 체크 */
	public Integer checkReply(ReplyDTO dto);
	
	/* 리뷰 페이징 */
	public List<ReplyDTO> getReplyList(Criteria cri);
	
	/* 리뷰 총 개수(페이징) */
	public int getReplyTotal(int product_id);
	
	/* 리뷰 수정 */
	public int updateReply(ReplyDTO dto);
	
	/* 리뷰 한 개 정보(수정 페이지) */
	public ReplyDTO getUpdateReply(int reply_id);
	
	/* 리뷰 삭제 */
	public int deleteReply(int reply_id);
	
	/* 평점 평균 구하기 */
	public Double getRatingAverage(int product_id);
	
	/* 평점 평균 반영하기 */
	public int updateRating(UpdateReplyDTO dto);
}
