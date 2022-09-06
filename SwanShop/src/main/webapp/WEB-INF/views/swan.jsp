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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>SWAN</title>
</head>
<body>
	<header>		
		<jsp:include page="common/header.jsp"/>
	</header>
	<main>
		<jsp:include page="common/home.jsp"/>
	</main>

	<script>
		$(document).ready(function(){
			/* 탈퇴 완료 경고창 */
			let delete_result = '${delete_result}';
			
			if(delete_result == 1){
				alert("탈퇴 완료");
			}
		});
	</script>
	
</body>
</html>