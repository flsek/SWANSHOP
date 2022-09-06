<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<link href="${path}/resources/css/home/header.css" rel="stylesheet"/>
	<title>header</title>
</head>
<body>
	<header>
		<!-- 메뉴바는 어느 페이지든 포함하고 있을 테니 여기서 contextPath 변수 값 만들기 -->
		<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
		<nav>
   			<div class="navbar">
     			<ul class="menu">
        			<li><a href="/swan">HOME</a></li>
        			<c:if test="${ member == null }">
        				<li><a href="/member/login">로그인</a></li>
        			</c:if>
        			<c:if test="${ member != null }">
        				<li><a href="/member/logout.me">로그아웃</a></li>
         				<li><a href="/member/mypage_info">마이페이지</a></li>
         				<li><a href="/cart/${ member.id }">
							<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-cart3" viewBox="0 0 22 22">
 								<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
 							</svg>
 						</a></li>
 						<li><a href="/orderList">주문목록</a></li>
 						<c:if test="${ member.admin_ck == 1 }">         
        					<li><a href="/admin/admin">관리자</a></li>
        				</c:if>
        			</c:if>
        			<li><a href="/question_list">문의사항</a></li>
        			<li><a href="/guide/guide">e-가이드 북</a></li>
      			</ul>
      		
	      		<div class="box">
	      			<form id="searchForm" action="/search" method="get">
	    				<input type="checkbox" id="check">
	    				<div class="search-box">
	    					<select name="type" class="sStyle">
	    						<option value="T" selected="selected" style="visibility: hidden;"/>
	    					</select>
	      					<input type="text" placeholder="Type here..." name="keyword">
	      					<label for="check" class="icon">
	        					<i class="fas fa-search"></i>
	      					</label>
	    				</div>
	      			</form>
  				</div>
   			</div>
   			<jsp:include page="../cate.jsp"/>
   		</nav>
	</header>
</body>
</html>