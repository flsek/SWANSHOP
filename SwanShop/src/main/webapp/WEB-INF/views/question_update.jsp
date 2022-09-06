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
	<title>문의사항 수정</title>
	<link href="${path}/resources/css/questions/questionDetail.css" rel="stylesheet"/>
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
				<form action="/question_update" method="post" id="modifyForm">
					<p><b>글쓴이 :</b> ${ questionInfo.q_writer }<input type="hidden" name="q_writer" value="${ questionInfo.q_writer }"></p>
					<div class="input-box">
						<p>
							<input type="text" placeholder="제목" value="${ questionInfo.q_title }" name="q_title">
						</p>
					</div>
					<div class="input-box message-box">
						<textarea rows="5" cols="15" placeholder="내용" name="q_content">${ questionInfo.q_content }</textarea>
					</div>
					<input type="hidden" name='q_id' value="${questionInfo.q_id}">
                    <input type="button" value="수정" id="modifyBtn">
				</form>
				<form id="moveForm" action="/question_list" method="get">
					<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
						type="hidden" name="amount" value="${cri.amount}"> <input
						type="hidden" name="keyword" value="${cri.keyword}"> <input
						type="hidden" name='q_id' value="${questionInfo.q_id}">
				</form>
			</div>
		</div>
	</div>
	<script>
	/* 수정 버튼 */
	$("#modifyBtn").on("click", function(e) {
		e.preventDefault();
		$("#modifyForm").submit();
	});
	</script>
</body>
</html>