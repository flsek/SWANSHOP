package com.swan.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swan.model.AttachImageVO;
import com.swan.model.Criteria;
import com.swan.model.MemberManageDTO;
import com.swan.model.MemberVO;
import com.swan.model.OrderCancelDTO;
import com.swan.model.OrderDTO;
import com.swan.model.PageDTO;
import com.swan.model.QuestionVO;
import com.swan.model.SwanVO;
import com.swan.service.AdminService;
import com.swan.service.MemberService;
import com.swan.service.OrderService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private AdminService adminService;

	/* 관리자 메인 페이지 이동 */
	@RequestMapping(value = "admin", method = RequestMethod.GET)
	public void adminMainGET(Criteria cri, Model model) throws Exception {
		logger.info("관리자 페이지이자 여긴 상품 목록보기");

		/* 상품 리스트 데이터 */
		List list = adminService.productsGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}

		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.productsGetTotal(cri)));
	}

	/* 상품 등록 페이지 접속 */
	@RequestMapping(value = "insertProduct", method = RequestMethod.GET)
	public void productsEnrollGET(Model model) throws Exception {

		logger.info("상품 등록 페이지 접속");

		// 사용할 Jackson-databind의 메서드는 static 메서드가 아니기 때문에 바로 사용할 수는 없음.
		// 따라서 ObjectMapper클래스를 인스턴스화 하여 사용함.
		ObjectMapper objm = new ObjectMapper();

		List list = adminService.cateList();

		// writeValueAsString(): Java 객체를 String타입의 JSON형식 데이터로 변환
		String cateList = objm.writeValueAsString(list);

		// 뷰(view)로 데이터를 넘겨주기 위해서 url 매핑 메서드의 파라미터에 Model를 부여
		// addAttribute()를 사용하여 "cateList"속성에 String타입의 'cateList' 변수의 값을 저장
		model.addAttribute("cateList", cateList);

		logger.info("변경 전.........." + list);
		logger.info("변경 후.........." + cateList);
	}

	/* 상품 등록 */
	@Transactional
	@PostMapping("/insertProduct")
	public String productsEnrollPOST(SwanVO swan, RedirectAttributes rttr) {

		logger.info("productsEnrollPOST......" + swan);

		adminService.swanEnroll(swan);

		rttr.addFlashAttribute("enroll_result", swan.getProduct_title());

		return "redirect:/admin/admin";
	}

	/*
	 * 
	 * 1. 이미지 파일 저장
	 * 
	 * 2. 썸네일 이미지 파일 생성 및 저장
	 * 
	 * 3. 각 이미지 정보 List 객체에 저장
	 * 
	 * 4. ResponseEntity를 통해서 뷰(view)로 http 상태 코드가 200이고 http Body에 이미지 정보가 담긴 List
	 * 객체를 전송
	 * 
	 */

	/* 첨부 파일 업로드 */
	/*
	 * 한글인 경우 업로드는 정상적으로 수행을 하겠지만 뷰로 반환되는 이미지 정보의 파일 이름(fileName) 데이터가 깨져 있을 수가 있음.
	 * 이를 방지하기 위해선 서버에서 뷰로 반환하는 데이터가 UTF8로 인코딩 되어야 함. RequestMapping 어노테이션에 produce
	 * 속성을 추가하여 전송되는 JSON데이터가 UTF8인코딩이 된 채로 전송되도록 속성값을 부여해주어야 함. RequestMapping
	 * 어노테이션의 produces 속성: 서버에서 뷰로 전송되는 Response의 Content-type을 제어 할 수 있는 속성
	 */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		logger.info("uploadAjaxActionPOST..........");

		// 파일 유형을 체크하는 코드는 업로드를 수행하는 코드가 실행이 되기 전에 실행이 되어야 함.
		/* 이미지 파일 체크 */
		// 전달받은 모든 파일(uploadfile)의 유형을 체크해야 하기 때문에 for문 사용
		for (MultipartFile multipartFile : uploadFile) {
			// 전달받은 파일(uploadfile)을 File 객체로 만들어주고 File 참조 변수에 대입
			File checkfile = new File(multipartFile.getOriginalFilename());
			// MIME TYPE을 저장할 String 타입의 type 변수를 선언하고 null로 초기화
			String type = null;

			// probeContetype() 메서드의 경우 IOException 예외를 일으 킬 가능성이 크므로 try/catch 문을 사용
			try {
				// Files의 probeContetype() 메서드를 호출하여 반환하는 MIME TYPE 데이터를 type 변수에 대입
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}

			// MIME TYPE이 image가 아닌 경우 구현부가 실행이 되는 if문
			if (!type.startsWith("image")) {
				// image가 아니라는 것이기 때문에 메서드 끝!
				List<AttachImageVO> list = null;
				// 상태 코드가 400인 ResponseEntity 객체를 인스턴스화 하여 이를 반환해주는 코드
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		} // for

		String uploadFolder = "C:\\upload";

		// 날짜 경로 폴더
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// 오늘의 날짜 데이터를 얻기 위해서 Date 클래스 타입의 변수를 선언 및 초기화
		Date date = new Date();

		// 오늘의 날짜 데이터 값을 가지고 있는 date 변수를 "yyyy-MM-dd" 형식의 문자열로 변환을 해주기 위해서
		// SimpleDateFormat의 format 메서드를 호출
		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		/* 폴더 생성(File 객체 사용) */
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {
			// 여러개의 폴더를 생성해야 하기 때문에 mkdirs() 메서드를 사용
			uploadPath.mkdirs();
		}

		/* 이미저 정보 담는 객체 */
		List<AttachImageVO> list = new ArrayList();

		// 향상된 for
		for (MultipartFile multipartFile : uploadFile) {

			/* 이미지 정보 객체 */
			AttachImageVO vo = new AttachImageVO();

			/* 파일 이름 */ // 뷰로부터 전달받은 파일 이름을 그대로 사용할 것
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			/* uuid 적용 파일 이름 */
			// 파일에 고유한 이름을 가지도록 하기 위해서 기존 파일 이름에 UUID가 포함되도록 함.
			// UUID(범용 고유 식별자): 국제기구에서 표준으로 정한 식별자(일련번호)
			// 주의: UUID.randomUUID()를 통해 생성된 '식별자'는 UUID 타입의 데이터 이기 때문에 toString() 메서드를 사용하여
			// String 타입으로 변경
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName;

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			try {
				// transferTo() 경우 IOException와 IllegalStateException을 일으킬 가능성이 있기 때문에 try
				// catch문
				multipartFile.transferTo(saveFile);

				/* 방법1 */
				// 썸네일 생성(ImageIO)
				// 저장될 썸네일 이미지의 경우 기존 원본 파일이름("uuid_원본파일이름")에서 앞에 "s_"를 붙여 줌
				/*
				 * File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				 * 
				 * // ImageIO의 read() 메서드를 호출하여 BufferedImage 타입으로 변경 해준 뒤 BufferedImage 타입의 참조
				 * 변수를 선언하여 해당 변수에 대입 BufferedImage bo_image = ImageIO.read(saveFile);
				 * 
				 * 비율 // 원본 이미지 비율을 위에서 지정한 값 비율로 줄이기 위해선, 원본 이미지 높이 넓이를 위에서 지정한 비율값으로 나누어주면 됨
				 * double ratio = 3;
				 * 
				 * 넓이, 높이 // 썸네일 이미지가 가져야 할 넓이와 높이를 얻었기 때문에 해당 값들이 필요로한 파라미터에 인자로 부여 int width =
				 * (int) (bo_image.getWidth() / ratio); int height = (int) (bo_image.getHeight()
				 * / ratio);
				 * 
				 * BufferedImage bt_image = new BufferedImage(width, height,
				 * BufferedImage.TYPE_3BYTE_BGR);
				 * 
				 * // 썸네일 BufferedImage 객체에 그림을 그리기 위해 Grahpic2D 객체를 생성 Graphics2D graphic =
				 * bt_image.createGraphics();
				 * 
				 * // drawImage() 메서드를 호출하여 원본 이미지(원본 BuffedImage)를 썸네일 BufferedImage에 지정한 크기로
				 * 변경 graphic.drawImage(bo_image, 0, 0, width, height, null);
				 * 
				 * // ImageIO의 write 메서드를 호출하여 파일로 저장 ImageIO.write(bt_image, "jpg",
				 * thumbnailFile);
				 */

				/* 방법 2 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				BufferedImage bo_image = ImageIO.read(saveFile);

				// 비율
				double ratio = 3;

				// 넓이, 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);

				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);

			} catch (Exception e) {
				e.printStackTrace();
			}
			// 이미지 정보가 저장된 AttachImageVO객체를 List의 요소로 추가
			list.add(vo);
		} // for

		// ResponseEntity 참조 변수를 선언하고 생성자로 초기화
		// 위에서 작성한 생성자를 통해서 Http의 바디에 추가될 데이터는 List <AttachImageVO>이고 상태 코드가 OK(200)인
		// ReseponseEntity 객체가 생성
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);

		// 생성한 ResponseEntity 객체를 반환
		return result;
	}

	/* 이미지 파일 삭제 */
	// 이미지 파일 삭제를 수행하는 url 매핑 메서드는 AdminController.java 에 작성, 이미지 파일 삭제를 수행하는 사람은
	// 관리자만이 할 수 있도록 하기 위함
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("deleteFile........" + fileName);

		// File 타입의 참조 변수를 선언하고 null로 초기화
		File file = null;

		// 앞으로 작성할 메서드들이 URLDecoder.decode(), File.delete()가 있는데 두 개 모두 예외를 발생시킬 가능성이 큰
		// 메서드임.
		// 따라서 try-catch문을 먼저 작성
		try {
			// 두 개의 메서드가 일으킬 수 있는 예외들이 각각 다르지만 현재 기능 구현이 목표이기 때문에 모든 예외를 처리해주는 Exception을
			// catch의 파라미터로 부여

			/* 썸네일 파일 삭제 */
			// 삭제할 파일을 대상으로 하는 File 클래스를 인스턴스화 하여 앞서 선언한 file 참조 변수가 참조하도록 함
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			// delete() 메서들를 호출하여 대상 파일을 삭제하도록 코드를 작성
			file.delete();

			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");

			logger.info("originFileName : " + originFileName);

			file = new File(originFileName);

			// 썸네일 이미지 삭제와 동일하게 원본 파일 이미지를 삭제하도록 delete() 메서드를 호출
			file.delete();
		} catch (Exception e) {

			e.printStackTrace();

			// 예외가 발생했다는 의미는 이미지 파일 삭제 요청을 정상적으로 처리하지 못하였다는 의미이기 때문에 실패하였다는 것을 알리도록 return문을
			// catch 구현부에 작성
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

		} // catch
			// try문이 예외가 발생하지 않은 것은 정상적으로 삭제 작업을 수행했다는 것이기 때문에 성공 상태 코드와 함께 성공과 관련된 문자열을 뷰로
			// 전송
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	// 수정 페이지로 이동할 수 있는 URL 매핑 메서드를 추가
	// 추가해야 할 수정 페이지 메서드는 '상품 조회 페이지 이동 메서드(product_detail)'와 완전히 동일
	/* 상품 조회 페이지 */
	@GetMapping({ "/product_detail", "/product_update" })
	public void productsGetInfoGET(int product_id, Criteria cri, Model model) throws JsonProcessingException{

		logger.info("productsGetInfo()........." + product_id);

		ObjectMapper mapper = new ObjectMapper();
		
		/* 카테고리 리스트 데이터 */
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));
		
		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);

		/* 조회 페이지 정보 */
		model.addAttribute("productsInfo", adminService.productsGetDetail(product_id));

	}

	/* 상품 정보 수정 */
	@PostMapping("/product_update")
	public String productsModifyPOST(SwanVO vo, RedirectAttributes rttr) {

		logger.info("productsModifyPOST.........." + vo);

		int result = adminService.productsModify(vo);

		// 해당 메서드가 작업을 정상적으로 수행했음을 알리는 메시지를 admin.jsp로 전송하는 코드
		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/admin";

	}

	/* 상품 정보 삭제 */
	@PostMapping("/productsDelete")
	public String productsDeletePOST(int product_id, RedirectAttributes rttr) {

		logger.info("productsDeletePOST..........");

		// 이미지 정보를 반환해주는 service 메서드를 호출하고 반환받은 값을 List 타입의 fileList 변수에 저장
		List<AttachImageVO> fileList = adminService.getAttachInfo(product_id);

		// 이미지가 없다면 굳이 서버 파일 삭제 코드들이 실행이 될 필요가 없음
		if (fileList != null) {

			List<Path> pathList = new ArrayList();

			fileList.forEach(vo -> {

				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);

				// 섬네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);

			});

			pathList.forEach(path -> {
				path.toFile().delete();
			});

		}

		int result = adminService.productsDelete(product_id);

		// 삭제를 수행하는 Service 메서드를 수행 후 반환받는 데이터를 '상품 목록' 페이지에 전송
		rttr.addFlashAttribute("delete_result", result);

		// 메서드 수행 후 리다이렉트 방식으로 '상품 목록' 페이지로 이동
		return "redirect:/admin/admin";

	}

	/* 주문 현황 페이지 */
	@GetMapping("/orderList")
	public String orderListGET(Criteria cri, Model model) {

		List<OrderDTO> list = adminService.getOrderList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", new PageDTO(cri, adminService.getOrderTotal(cri)));
		} else {
			model.addAttribute("listCheck", "empty");
		}

		return "/admin/orderList";
	}
	
	/* 주문 삭제 */
	@PostMapping("/orderCancle")
	public String orderCanclePOST(OrderCancelDTO dto) {
		// 주문 취소 Service 메서드를 호출
		orderService.orderCancle(dto);
		
		// 리턴으로는 리다이렉트 방식으로 '주문 현황' 페이지를 반환
		// 사용자가 머물고 있었던 페이지에 이동할 수 있도록 쿼리 파라미터를 부여
		return "redirect:/admin/orderList?keyword=" + dto.getKeyword() + "&amount=" + dto.getAmount() + "&pageNum=" + dto.getPageNum();
	}

	/* 문의사항 관리 페이지 접속 */
	@RequestMapping(value = "adminQuestion", method = RequestMethod.GET)
	public String questionListGET(Criteria cri, Model model) {
		List<QuestionVO> list = adminService.getQuestionList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", new PageDTO(cri, adminService.getQuestionTotal(cri)));
		} else {
			model.addAttribute("listCheck", "empty");
		}
		return "/admin/adminQuestion";
	}
	
	/* 회원 관리 페이지 접속 */
	@RequestMapping(value = "/adminMember", method = RequestMethod.GET)
	public String memberListGET(Criteria cri, Model model) {
		List<MemberVO> list = adminService.getMemberList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", new PageDTO(cri, adminService.getMemberTotal(cri)));
		} else {
			model.addAttribute("listCheck", "empty");
		}
		return "admin/adminMember";
	}
	
	/* 관리자 회원 탈퇴 */
	@PostMapping("/deleteMember")
	public String memberDeletePOST(MemberManageDTO dto) {
		// 회원 탈퇴 Service 메서드 호출
		memberService.deleteMemberAdmin(dto);
		logger.info("탈퇴됐냐");
		return "redirect:/admin/adminMember?keyword=" + dto.getKeyword() + "&amount=" + dto.getAmount() + "&pageNum=" + dto.getPageNum();
	}
	
	/* 관리자 회원 복구 */
	@PostMapping("/updateMember")
	public String memberUpdatePOST(MemberManageDTO dto) {
		// 회원 탈퇴 Service 메서드 호출
		memberService.updateMemberAdmin(dto);	
		return "redirect:/admin/adminMember?keyword=" + dto.getKeyword() + "&amount=" + dto.getAmount() + "&pageNum=" + dto.getPageNum();
	}
	

}
