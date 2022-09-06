package com.swan.service;

import java.util.List;

import com.swan.model.AttachImageVO;

// 첨부파일(이미지)과 관련된 처리를 하는 메서드를 따로 관리
public interface AttachService {
	/* 이미지 데이터 반환 */
	public List<AttachImageVO> getAttachList(int product_id);
}
