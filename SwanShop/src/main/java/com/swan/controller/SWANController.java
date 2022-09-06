package com.swan.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.swan.mapper.AttachMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.Criteria;
import com.swan.model.PageDTO;
import com.swan.model.ReplyDTO;
import com.swan.model.SwanVO;
import com.swan.service.ReplyService;
import com.swan.service.SwanService;

@Controller
public class SWANController {

	private static final Logger logger = LoggerFactory.getLogger(SWANController.class);

	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private SwanService swanService;
	
	@Autowired
	private ReplyService replyService;
	
	/* 상품 검색 */
	@GetMapping(value = "/search")
	public String searchGoodsGET(Criteria cri, Model model) {
		
		/* 상품 리스트 데이터 */
		List<SwanVO> list = swanService.productsGetList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return "search";
		}
		
		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, swanService.productsGetTotal(cri)));
		
		String[] typeArr = cri.getType().split("");
		
		for(String s : typeArr) {
			if(s.equals("T") || s.equals("C")) {
				model.addAttribute("filter_info", swanService.getCateInfoList(cri));		
			}
		}
		
		return "search";
	}

	// 메인 페이지 이동
	@RequestMapping(value = "/swan", method = RequestMethod.GET)
	public void mainPageGET(Model model) {
	
		// 메인 페이지'에 노출시킬 정보가 담긴 List 객체를 반환받고 이 객체를 Model클래스의 addAttribute 메서드를 호출하여 뷰로 전달
		logger.info("메인 페이지 진입");
		model.addAttribute("ls", swanService.likeSelect());
		model.addAttribute("cate1", swanService.getCateCode1());
		model.addAttribute("cate2", swanService.getCateCode2());
		model.addAttribute("cate3", swanService.getCateCode3());
		model.addAttribute("cate4", swanService.getCateCode4());

	}

	// 이미지 데이터를 전달해주는 매핑 메서드 선언부를 추가
	// 이미지는 로그인을 하든 안 하든 모든 곳에서 접근이 가능해야 하기 때문에 SwanController.java 에 작성
	@GetMapping("/display") // url의 경로를 통해 변수와 변수 값을 부여할 수 있도록 GetMapping 어노테이션을 사용
	// ResponseEntity 객체를 통해 body에 byte [] 데이터를 보내야 하기 대문에 ResponseEntity<byte[]>를
	// 반환 타입으로 작성
	// 파라미터의 경우 '파일 경로' + '파일 이름'을 전달받아야 하기 때문에 String 타입의 fileName 변수를 파라미터로 부여
	public ResponseEntity<byte[]> getImage(String fileName) {
		// 기본 경로 문자열 데이터와 전달받은 '유동 경로' + '파일 이름'을 활용하여 File 객체를 생성해주고 File 타입의 참조 변수에 대입
		// "c:\\upload\\"을 작성한 이유는 특수 문자'\'을 인식할 수 있도록 이스케이프 문자를 사용
		File file = new File("c:\\upload\\" + fileName);

		// 뷰로 반환할 ResponseEntity 객체의 주소를 저장할 참조 변수를 선언하고 null로 초기화
		ResponseEntity<byte[]> result = null;

		// 대상 이미지 파일의 MIME TYPE을 얻기 위해 Files 클래스의 proveContentType() 메서드를 사용
		// IOException을 일으킬 가능성이 큰 메서드이기 때문에 try catch문을 작성
		try {

			// ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해서 HttpHeaders를 인스턴스화 한 후 참조 변수를 선언하여 대입
			HttpHeaders header = new HttpHeaders();

			// header의 'Content Type'에 대상 파일의 MIME TYPE을 부여해주는 코드를 추가
			header.add("Content-type", Files.probeContentType(file.toPath()));

			// 대상 이미지 파일, header 객체, 상태 코드를 인자 값으로 부여한 생성자를 통해 ResponseEntity 객체를 생성하여 앞서
			// 선언한 ResponseEntity 참조 변수에 대입
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int product_id) {
		logger.info("getAttachList.........." + product_id);

		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(product_id), HttpStatus.OK);
	}
	
	/* 상품 상세 */
	// @PathVarialbe: URL경로에 작성된 식별자 값이 추출되어 파라미터 변수 'product_id'로 대입되어 값을 사용할 수 있음.
	@GetMapping("/product_detail/{product_id}") // Spring에서 사용자가 전송한 식별자 값을 변수로 인식하도록 하기 위해 템플릿 변수({product_id})를 작성
	public String productsDetailGET(@PathVariable("product_id")int product_id, Model model) {
		
		logger.info("product_detail()..........");
		model.addAttribute("productsInfo", swanService.getProductsInfo(product_id));
		return "/product_detail";
	}
	
	/* 리뷰 쓰기 */
	@GetMapping("/replyEnroll/{member_id}")
	public String replyEnrollWindowGET(@PathVariable("member_id")String member_id, int product_id, Model model) {
		SwanVO swan = swanService.getProductIdName(product_id);
		model.addAttribute("productsInfo", swan);
		model.addAttribute("member_id", member_id);
		
		return "/replyEnroll";
	}
	
	/* 리뷰 수정 팝업창 */
	@GetMapping("/replyUpdate")
	/*
	 * 뷰로부터 reply_id, product_id, member_id를 전달받아야 하기 때문에 파라미터로 ReplyDTO타입의 변수를 선언
	 * 뷰로 데이터를 넘겨주기 위해 Mdoel 타입의 변수를 선언
	 * 팝업창에 어떠한 상품에 관한 수정인 지를 알 수 있도록 getProductIdName Service 메서드를 호출하여 반환받은 값을 Model 객체로 뷰로 보내줌.
	 * getUpdateReply Service 메서드를 호출해서 반환받은 리뷰 정보, 회원 아이디를 Model 객체를 통해 뷰로 보내줌.
	 * */
	public String replyUpdateWindowGET(ReplyDTO dto, Model model) {
		SwanVO swan = swanService.getProductIdName(dto.getProduct_id());
		model.addAttribute("productsInfo", swan);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReply_id()));
		model.addAttribute("member_id", dto.getMember_id());
		
		return "/replyUpdate";
	}
}
