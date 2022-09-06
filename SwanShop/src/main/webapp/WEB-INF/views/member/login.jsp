<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${path}/resources/css/login/login.css" rel="stylesheet"/>	
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<main>	
		<div class="container">
			<form id="login_form" method="post">
				<div class="title">
					<a href="/swan">SWAN</a>
				</div>
				<div class="input-box underline">
					<input type="text" name="id" placeholder="아이디" required>
					<div class="underline"></div>
				</div>
				<div class="input-box">
					<input type="password" name="pwd" placeholder="비밀번호" required>
					<div class="underline"></div>
				</div>
				<c:if test = "${result == 0 }">
                	<div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
            	</c:if>
				<div class="input-box button">
					<input type="button" class="login_button" value="로그인">
				</div>
			</form>
			<div class="sign_up">
				<a href="find_pwd_form">비밀번호 찾기</a> | 
				<a href="find_id_form">아이디 찾기</a> |
				<a href="join">회원가입</a>
			</div>
		</div>
	</main>
	<script>
	    /* 로그인 버튼 클릭 메서드 */
	    $(".login_button").click(function(){   
	       // alert("로그인 버튼 작동");
	    	/* 로그인 메서드 서버 요청 */
	        $("#login_form").attr("action", "/member/login.me");
	        $("#login_form").submit();
	    });
	</script>
</body>
</html>