<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css?family=Fredoka+One" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet">
	<meta charset="UTF-8">
	<title>errorPage</title>
	<link href="${path}/resources/css/home/error.css" rel="stylesheet"/>
</head>
<body>
	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>Error</h1>
			</div>
			<%-- <h2><%= request.getAttribute("msg") %></h2> --%>
			
			<!-- el로 표현하기-->
			<h2>${ msg }</h2>
			<a href="/swan">
				<span class="arrow"></span>
				SWAN으로 돌아가기
			</a>
		</div>
	</div>
</body>
</html>