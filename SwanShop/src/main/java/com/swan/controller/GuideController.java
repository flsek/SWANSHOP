package com.swan.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/guide")
public class GuideController {

	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	
	// 가이드 페이지로 이동
	@RequestMapping(value="guide", method = RequestMethod.GET)
	public void guideGET() {
		logger.info("가이드 페이지 ~_~");
	}
	
}
