<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link href="${path}/resources/css/home/header.css" rel="stylesheet" />
<title>cate</title>
</head>
<body>
	<div class="navi_bar_area">
		<div class="dropdown">
			<button class="dropbtn">
				생리대 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown-content">
				<a href="/search?type=C&kind_id=100001">대형</a> <a
					href="/search?type=C&kind_id=100002">중형</a> <a
					href="/search?type=C&kind_id=100003">오버나이트</a> <a
					href="/search?type=C&kind_id=100004">팬티라이너</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">
				월경컵 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown-content">
				<a href="/search?type=C&kind_id=200001">루나컵</a> <a
					href="/search?type=C&kind_id=200002">티읕컵</a> <a
					href="/search?type=C&kind_id=200003">비움컵</a> <a
					href="/search?type=C&kind_id=200004">페미사이클</a> <a
					href="/search?type=C&kind_id=200005">링클컵</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">
				Y존 케어 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown-content">
				<a href="/search?type=C&kind_id=300001">여성 청결제</a> <a
					href="/search?type=C&kind_id=300002">이너퍼퓸</a> <a
					href="/search?type=C&kind_id=300003">Y존 세럼</a> <a
					href="/search?type=C&kind_id=300004">Y존 에센스</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">
				콘돔 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown-content">
				<a href="/search?type=C&kind_id=400001">초박형</a>
				<a href="/search?type=C&kind_id=400002">사정지연</a> <a
					href="/search?type=C&kind_id=400003">도트형</a> <a
					href="/search?type=C&kind_id=400004">굴곡형</a> <a
					href="/search?type=C&kind_id=400005">무꼭지</a> <a
					href="/search?type=C&kind_id=400006">발열</a>
			</div>
		</div>
	</div>
</body>
</html>