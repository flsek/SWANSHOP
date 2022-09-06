package com.swan.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swan.model.AnswerDTO;
import com.swan.model.Criteria;
import com.swan.model.PageDTO;
import com.swan.model.QuestionVO;
import com.swan.service.AnswerService;
import com.swan.service.MemberService;
import com.swan.service.QuestionService;

@Controller
public class QuestionController {
	
	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	
	@Autowired
	private QuestionService questionService;
	
	@Autowired
	private AnswerService answerService;

	
	/* 문의사항 페이지 이동 */
	@RequestMapping(value = "/question_list")
	public void questionGET(Criteria cri, Model model) {
		logger.info("문의사항 페이지 진입");
		
		/* 문의사항 리스트 데이터 */
		List<QuestionVO> list = questionService.questionGetList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		}
		
		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, questionService.questionGetTotal(cri)));
	}
	
	/* 문의사항 등록 화면으로 이동 */
	@RequestMapping(value="/questionEnroll", method = RequestMethod.GET)
	public void questionEnrollGET() {
		logger.info("문의사항 등록 페이지 진입");
	}

	/* 문의사항 등록 */
	@RequestMapping(value = "/questionEnroll", method = RequestMethod.POST)
	public String questionEnrollPOST(QuestionVO question, RedirectAttributes rttr) {

		logger.info("문의사항 등록 진입" + question);

		questionService.questionEnroll(question);

		rttr.addFlashAttribute("enroll_result", question.getQ_title());

		return "redirect:/question_list";
	}
	
	/* 문의사항 상세 화면 + 수정 화면으로 이동 */
	@GetMapping({"/question_detail", "/question_update"})
	public void questionGetInfo(int q_id, Criteria cri, Model model) {
		logger.info("questionGetInfo()............" + q_id);
		
		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);
		
		/* 조회 페이지 정보 */
		model.addAttribute("questionInfo", questionService.questionGetDetail(q_id));
	}
	
	/* 문의사항 수정 */
	@PostMapping("/question_update")
	public String questionModifyPOST(QuestionVO vo, RedirectAttributes rttr) {

		logger.info("questionModifyPOST.........." + vo);

		int result = questionService.questionModify(vo);

		// 해당 메서드가 작업을 정상적으로 수행했음을 알리는 메시지를 question_list.jsp로 전송하는 코드
		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/question_list";

	}
	
	/* 문의사항 삭제 */
	@PostMapping("/questionDelete")
	public String questionDeletePOST(int q_id, RedirectAttributes rttr) {

		logger.info("questionDeletePOST..........");

		int result = questionService.questionDelete(q_id);

		// 삭제를 수행하는 Service 메서드를 수행 후 반환받는 데이터를 '문의사항 목록' 페이지에 전송
		rttr.addFlashAttribute("delete_result", result);

		// 메서드 수행 후 리다이렉트 방식으로 '문의사항 목록' 페이지로 이동
		return "redirect:/question_list";

	}
	
	/* 답변 작성 */
	@GetMapping(value="/answerEnroll/{member_id}")
	public String answerEnrollGET(@PathVariable("member_id") String member_id, int q_id, Model model) {
		QuestionVO question = questionService.getQuestionIdName(q_id);
		model.addAttribute("questionInfo", question);
		model.addAttribute("member_id", member_id);
		
		return "/answerEnroll";
	}
	
	/* 답변 수정 */
	@GetMapping("/answerUpdate")
	/*
	 * 뷰로부터 a_id, q_id, member_id를 전달받아야 하기 때문에 파라미터로 AnswerDTO타입의 변수를 선언
	 * 뷰로 데이터를 넘겨주기 위해 Mdoel 타입의 변수를 선언
	 * 어떠한 상품에 관한 수정인 지를 알 수 있도록 getQuestionIdName Service 메서드를 호출하여 반환받은 값을 Model 객체로 뷰로 보내줌.
	 * getUpdateReply Service 메서드를 호출해서 반환받은 리뷰 정보, 회원 아이디를 Model 객체를 통해 뷰로 보내줌.
	 * */
	public String answerUpdateGET(AnswerDTO dto, Model model) {
		QuestionVO question = questionService.getQuestionIdName(dto.getQ_id());
		model.addAttribute("questionInfo", question);
		model.addAttribute("answerInfo", answerService.getUpdateAnswer(dto.getA_id()));
		model.addAttribute("member_id", dto.getMember_id());
		
		return "/answerUpdate";
	}
	
	
}
