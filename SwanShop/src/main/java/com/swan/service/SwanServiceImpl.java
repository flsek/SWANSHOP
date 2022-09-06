package com.swan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swan.mapper.AdminMapper;
import com.swan.mapper.AttachMapper;
import com.swan.mapper.SwanMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.CateFilterDTO;
import com.swan.model.CateVO;
import com.swan.model.Criteria;
import com.swan.model.SelectDTO;
import com.swan.model.SwanVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SwanServiceImpl implements SwanService {
	@Autowired
	private SwanMapper swanMapper;

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private AdminMapper adminMapper;

	/* 상품 리스트 */
	@Override
	public List<SwanVO> productsGetList(Criteria cri) {
		log.info("productsGetList()..........");
		
		List<SwanVO> list = swanMapper.productsGetList(cri);

		list.forEach(swan -> {

			int product_id = swan.getProduct_id();

			List<AttachImageVO> imageList = attachMapper.getAttachList(product_id);

			swan.setImageList(imageList);

		});

		return list;
	}

	/* 상품 총 개수 */
	@Override
	public int productsGetTotal(Criteria cri) {
		log.info("goodsGetTotal().........");

		return swanMapper.productsGetTotal(cri);
	}

	/* 상품 정보 */
	@Override
	public SwanVO getProductsInfo(int product_id) {
		SwanVO productsInfo = swanMapper.getGoodsInfo(product_id);
		productsInfo.setImageList(adminMapper.getAttachInfo(product_id));

		return productsInfo;
	}

	/* 상품 id, 이름 */
	@Override
	public SwanVO getProductIdName(int product_id) {
		return swanMapper.getProductIdName(product_id);
	}

	/* 평점 순 상품 정보 */
	@Override
	public List<SelectDTO> likeSelect() {
		// 메인 페이지에 노출시킬 상품 정보를 반환해주는 likeSelect Mapper 메서드를 호출해주고 반환받은 객체를 변수에 저장
		List<SelectDTO> list = swanMapper.likeSelect();

		// 반환받은 List 객체에 담긴 각 SelectDTO 객체에 해당 이미지 정보를 추가해주는 코드
		list.forEach(dto -> {

			int product_id = dto.getProduct_id();

			List<AttachImageVO> imageList = attachMapper.getAttachList(product_id);

			dto.setImageList(imageList);

		});
		
		// 이미지 정보가 담긴 List 객체를 반환
		return list;
	}

	/* 생리대 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode1() {
		// TODO Auto-generated method stub
		return swanMapper.getCateCode1();
	}

	@Override
	public List<CateVO> getCateCode2() {
		return swanMapper.getCateCode2();
	}

	@Override
	public List<CateVO> getCateCode3() {
		return swanMapper.getCateCode3();
	}

	@Override
	public List<CateVO> getCateCode4() {
		return swanMapper.getCateCode4();
	}

	@Override
	public List<CateFilterDTO> getCateInfoList(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

}
