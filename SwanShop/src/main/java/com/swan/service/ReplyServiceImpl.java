package com.swan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swan.mapper.ReplyMapper;
import com.swan.model.Criteria;
import com.swan.model.PageDTO;
import com.swan.model.ReplyDTO;
import com.swan.model.ReplyPageDTO;
import com.swan.model.UpdateReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	/* 리뷰 등록 */
	@Override
	public int enrollReply(ReplyDTO dto) {
		int result = replyMapper.enrollReply(dto);
		
		setRating(dto.getProduct_id());
		
		return result;
	}

	/* 리뷰 존재 체크 */
	@Override
	public String checkReply(ReplyDTO dto) {
		Integer result = replyMapper.checkReply(dto);

		if (result == null) {
			return "0";
		} else {
			return "1";
		}
	}

	/* 리뷰 페이징 */
	@Override
	public ReplyPageDTO replyList(Criteria cri) {

		// '페이징 리뷰 정보'는 ReplyPageDTO 변수에 바로 대입
		ReplyPageDTO dto = new ReplyPageDTO();
		dto.setList(replyMapper.getReplyList(cri));

		// '페이지 총 개수'의 경우 PageDTO객체를 생성되는 데 사용된 후, PageDTO객체를 ReplyPageDTO의 변수에 대입
		dto.setPageInfo(new PageDTO(cri, replyMapper.getReplyTotal(cri.getProduct_id())));

		return dto;
	}

	/* 리뷰 수정 */
	@Override
	public int updateReply(ReplyDTO dto) {
		int result = replyMapper.updateReply(dto);
		
		setRating(dto.getProduct_id());
		
		return result;
	}

	/* 리뷰 한 개 정보(수정 페이지) */
	@Override
	public ReplyDTO getUpdateReply(int reply_id) {
		return replyMapper.getUpdateReply(reply_id);
	}

	/* 리뷰 삭제 */
	@Override
	public int deleteReply(ReplyDTO dto) {
		int result = replyMapper.deleteReply(dto.getReply_id());
		
		setRating(dto.getProduct_id());
		
		return result;
	}

	/*
	 * 리뷰 등록, 수정, 삭제 Service 메서드에 평균 평점을 반영해주는 코드를 추가해주어야 하는데, 3 가지 모두 동일한 코드를 사용할
	 * 것이기 때문에 단순히 메서드를 호출만 할 수 있도록, 메서드를 만듦
	 */
	public void setRating(int product_id) {
		/* 상품의 평점 평균값을 구하는 Mapper 메서드를 호출하여 반환받은 값을 새로 선언한 변수에 대입하는 코드를 작성 */
		Double ratingavg = replyMapper.getRatingAverage(product_id);
		
		/* 반환 받은 값이 null 일 경우 변수에 0이 저장되도록 if문을 사용해서 작성 */
		if(ratingavg == null) {
			ratingavg = 0.0;
		}
		
		/*평균값의 소수점 첫 째 자리까지 표시하기 위해 Math 클래스의 round 함수를 사용*/
		ratingavg = (double) (Math.round(ratingavg*10));
		ratingavg = ratingavg / 10;
		
		/* UpdateReplyDTO 객체를 인스턴스화 하여 product_id, ratingavg 값을 객체의 변수에 저장 */
		UpdateReplyDTO urd = new UpdateReplyDTO();
		urd.setProduct_id(product_id);
		urd.setRatingavg(ratingavg);
		
		/* 값이 세팅된 UpdateReplyDTO 객체를 인자로 하는 updateRating Mapper 메서드(테이블에 평균 평점 반영)를 호출 */
		replyMapper.updateRating(urd);	
	}
}
