package com.swan.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Component // 해당 클래스가 스프링에서 인식을 할 수 있도록 함.
@Log4j
public class testBatch {
	
	// 추가한 메서드가 실행될 시간 설정을 하기 위해 해당 메서드의 선언부에 @Scheduled 어노테이션을 추가
	@Scheduled(cron = "0 * * * * *") // cron 표현식: 시간을 지정해주는 방식
	public void testMethod() throws Exception{
		log.warn("배치 실행 테스트................");
		log.warn("=============================");
	}
}
