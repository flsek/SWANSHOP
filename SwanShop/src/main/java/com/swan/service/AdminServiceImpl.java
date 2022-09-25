package com.swan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.swan.mapper.AdminMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.CateVO;
import com.swan.model.Criteria;
import com.swan.model.MemberVO;
import com.swan.model.OrderDTO;
import com.swan.model.QuestionVO;
import com.swan.model.SwanVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j // log 메서드를 사용하기 위해
public class AdminServiceImpl implements AdminService {

	// AdminMapper 인터페이스를 의존성 주입 해준 후, AdminService.java 에서 선언한 메서드를 오버라이딩 하여 구현
	@Autowired
	private AdminMapper adminMapper;

	// 상품 등록
	@Transactional
	@Override
	public void swanEnroll(SwanVO swan) {
		log.info("(service)swanEnroll........");

		adminMapper.swanEnroll(swan);

		// 이미지의 존재 여부를 확인하는 방법은 SwanVO의 객체에 imageList 참조 변수의 값을 확인하는 것
		if (swan.getImageList() == null || swan.getImageList().size() <= 0) {
			// 이미지가 없는 경우 Service 단계의 swanEnroll() 메서드가 실행이 종료되도록 구현부에는 return을 작성
			return;
		}

		// 이미지 등록에 필요로 한 product_id 값을 세팅 해주었기 때문에,
		// Mapper단계의 imageEnroll() 메서드를 호출하고 매개변수로 SwanVO의 imageList 요소를 매개변수로 부여해줌.
		// 이로써 for문으로 인해 imageList의 요소 수만큼 각각 product_id 값을 세팅해주고 imageEnroll() 메서드를
		// 호출하게 됨.
		swan.getImageList().forEach(attach -> {
			attach.setProduct_id(swan.getProduct_id());
			adminMapper.imageEnroll(attach);

		});

	}

	/* 카테고리 리스트 */
	@Override
	public List<CateVO> cateList() {
		log.info("(service)cateList........");
		return adminMapper.cateList();
	}

	/* 상품 리스트 */
	@Override
	public List<SwanVO> productsGetList(Criteria cri) {
		log.info("productsGetList()..........");

		return adminMapper.productsGetList(cri);
	}

	/* 상품 총 개수 */
	@Override
	public int productsGetTotal(Criteria cri) {
		log.info("goodsGetTotal().........");

		return adminMapper.productsGetTotal(cri);
	}

	/* 상품 조회 페이지 */
	@Override
	public SwanVO productsGetDetail(int product_id) {
		log.info("(service)productsGetDetail......." + product_id);
		return adminMapper.productsGetDetail(product_id);
	}

	/* 상품 정보 수정 */
	@Transactional // 두 개 이상의 쿼리를 요청하기 때문에 트랜잭션을 적용
	@Override
	public int productsModify(SwanVO vo) {
		int result = adminMapper.productsModify(vo);
		
		// 뷰로부터 상품 이미지 정보가 없는 경우는 상품 이미지 정보 수정 코드가 실행될 필요가 없기 때문에 상품 이미지 정보 존재 여부를 확인하는 코드 추가
		if (result == 1 && vo.getImageList() != null && vo.getImageList().size() > 0) {

			// 해당 상품의 이미지 정보가 모두 삭제되도록 deleteImageAll() 메서드를 호출
			adminMapper.deleteImageAll(vo.getProduct_id());
			
			// List 자료 형태로 전달받은 이미지 정보(SwanVO의 imageList)를 각 요소 순서대로 이미지 정보를 DB에 저장
			vo.getImageList().forEach(attach -> {
				
				// SwanVO에 있는 imageList의 각 요소로 있는 AttachImageVO 객체에 있는 product_id 변수에는 값이 할당이 되지 않았기 때문에, 해당 값을 세팅해주는 코드를 작성
				attach.setProduct_id(vo.getProduct_id());
				adminMapper.imageEnroll(attach);

			});

		}
		return result;
	}

	/* 상품 정보 삭제 */
	@Transactional // 두 개의 쿼리가 실행이 되기 때문에 트랜잭션 처리
	@Override
	public int productsDelete(int product_id) {
		log.info("productsDelete..........");
		// DB 데이터 삭제 (상품 정보, 이미지 정보)
		adminMapper.deleteImageAll(product_id);
		return adminMapper.productsDelete(product_id);
	}

	/* 지정 상품 이미지 정보 얻기 */
	@Override
	public List<AttachImageVO> getAttachInfo(int product_id) {
		log.info("getAttachInfo........");
		return adminMapper.getAttachInfo(product_id);
	}
	
	/* 주문 상품 리스트 */
	@Override
	public List<OrderDTO> getOrderList(Criteria cri) {
		return adminMapper.getOrderList(cri);
	}
	
	/* 주문 총 개수 */
	@Override
	public int getOrderTotal(Criteria cri) {
		return adminMapper.getOrderTotal(cri);
	}

	/* 공지사항 리스트 */
	@Override
	public List<QuestionVO> getQuestionList(Criteria cri) {
		return adminMapper.getQuestionList(cri);
	}

	/* 공지사항 총 개수 */
	@Override
	public int getQuestionTotal(Criteria cri) {
		return adminMapper.getQuestionTotal(cri);
	}

	/* 회원 리스트 */
	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
		return adminMapper.getMemberList(cri);
	}

	/* 총 회원 수 */
	@Override
	public int getMemberTotal(Criteria cri) {
		return adminMapper.getMemberTotal(cri);
	}
}
