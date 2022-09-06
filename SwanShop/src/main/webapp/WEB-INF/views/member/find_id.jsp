<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${path}/resources/css/login/find.css" rel="stylesheet"/>	
<style type="text/css">
	.title {
	font-size: 30px;
	font-weight: 600;
	margin: 20px 0 10px 0;
	position: relative;
}

main{
	height: 500px;
}

p{
	font-size: 20px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<main>
		<div class="container">
			<div class="title">
				<a href="#">아이디 찾기 검색 결과</a>
			</div>
			<div class="input-box underline">
				<p>고객님의 아이디는 <b>"${ id }"</b>입니다.</p>
				<div class="underline"></div>
			</div>
		</div>
	</main>
</body>
</html>