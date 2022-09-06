<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>문의사항 작성</title>
	<link href="${path}/resources/css/questions/questionForm.css" rel="stylesheet"/>
</head>
<body>
		<jsp:include page="common/header.jsp"/>
		<div class="container">
			<div class="content">
				<div class="left-side">
					<div class="address details">
						<i class="fas fa-map-marker-alt"></i>
						<div class="topic">주소</div>
						<div class="text-one">서울특별시 성동구</div>
						<div class="text-two">행당로 (비밀~_~)</div>
					</div>
					<div class="phone details">
						<i class="fas fa-phone-alt"></i>
						<div class="topic">전화번호</div>
						<div class="text-one">010-9438-1306</div>
					</div>
					<div class="email details">
						<i class="fas fa-envelope"></i>
						<div class="topic">이메일</div>
						<div class="text-one">muchpretty99@gmail.com</div>
						<div class="text-two">muchpretty99@naver.com</div>
					</div>
				</div>
				<div class="right-side">
					<div class="topic-text">문의사항</div>
					<br>
					<form id="question_form" method="post">
						<p>글쓴이 : ${ member.id }</p><input type="hidden" name="q_writer" readonly value="${ member.id }">
						<div class="input-box">
							<input type="text" placeholder="제목" name="q_title">
						</div>
						<div class="input-box message-box">
							<textarea rows="5" cols="15" placeholder="내용" name="q_content"></textarea>
						</div>
						<input type="button" value="작성완료" class="questionEnroll_btn">
					</form>
				</div>
			</div>
		</div>
		<script>
			/* 문의사항 등록 버튼 */
			$(document).ready(function(){
				$(".questionEnroll_btn").click(function(){
					$("#question_form").attr("action", "/questionEnroll");
					$('#question_form').submit();
				});
			});
		</script>
</body>
</html>