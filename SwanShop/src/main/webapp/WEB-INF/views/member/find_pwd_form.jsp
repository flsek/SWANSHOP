<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${path}/resources/css/login/find.css" rel="stylesheet"/>	
<style type="text/css">
	
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<main>	
		<div class="container">
			<form id="findPwd_form" method="post">
				<div class="title">
					<a href="find_pwd_form">비밀번호 찾기</a>
				</div>
				<div class="input-box underline">
					<input type="text" name="id" placeholder="아이디를 입력하세요." class="id_input" required>
					<div class="underline"></div>
					<span class="final_id_ck" style="color: red;">아이디를 입력해주세요.</span>
				</div>
				<div class="input-box underline">
					<input type="text" name="email" placeholder="이메일을 입력하세요." class="mail_input" required>
					<div class="underline"></div>
					<span class="final_mail_ck" style="color: red;">이메일을 입력해주세요.</span>
				</div>
				<div class="input-box button">
					<input type="button" class="findPwd_button" value="비밀번호 찾기">
				</div>
			</form>
		</div>
	</main>
	<script>
	/* 유효성 검사 */
	var idCheck = false;		// 아이디
	var mailCheck = false;		// 이메일
	
	$(document).ready(function(){
		
		/* 아이디 찾기 버튼 */
		$(".findPwd_button").click(function(){
			/* 입력값 변수 */
			var id = $('.id_input').val();			// 아이디 입력란
			var mail = $('.mail_input').val();		// 이메일 입력란
			
			/* 아이디 유효성 검사 */
			if(id == ""){
				$(".final_id_ck").css('display', 'block');
				idCheck = false;
			} else {
				$('.final_id_ck').css('display', 'none');
				idCheck = true;
			}
			
		 	/* 이메일 유효성 검사 */
		 	if(mail == ""){
		 		$('.final_mail_ck').css('display', 'block');
		 		mailCheck = false;
		 	} else {
		 		$('.final_mail_ck').css('display', 'none');
		 		mailCheck = true;
		 	}
			
			/* 최종 유효성 검사 */
			if(idCheck&&mailCheck){
				$('#findPwd_form').attr("action", "../member/find_pwd");
				$('#findPwd_form').submit();
				
			}
		});
	});
	</script>
</body>
</html>