<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="false"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
 
<!-- Boxicons CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>SWAN</title>
<link href="${path}/resources/css/home/homeCss.css" rel="stylesheet" />
<style>
	body nav {
    position: fixed;
    top: 0;
    background-color: #fff;
    width: 100%;
    z-index: 200 !important;}
</style>
</head>
<body>
	<div class="content">
		<div class="text-content">
			<div class="text">당신의 열정을 응원합니다.</div>
			<div class="name">SWAN</div>
			<div class="job">
				<div class="job">
					<span>당신을 위해 준비된</span>
					<div class="typing-text">
						<span class="one">편안한 </span> <span class="two">쇼핑 공간</span>
					</div>
				</div>
			</div>
		</div>
		<div class="girl">
			<img src="${path}/resources/images/girl.jpg" alt="">
		</div>
	</div>

	 <div class="container">
	 <h1>SWAN 베스트 인기 상품 8개</h1>
        <div class="images">
	        <c:forEach items="${ls}" var="ls">
	            <div class="image-box image_wrap"
	            	data-product_id="${ls.imageList[0].product_id}"
										data-path="${ls.imageList[0].uploadPath}"
										data-uuid="${ls.imageList[0].uuid}"
										data-filename="${ls.imageList[0].fileName}">
	                
	                <a href="/product_detail/${ls.product_id}"><img></a>
	                <h6>${ls.product_title}</h6><p>평점: ${ls.ratingavg}</p>
	            </div>
	         </c:forEach>
            
        </div>
    </div>

	<%-- <div class="container">
		<div class="col-12 d-flex justify-content-between">
			<div>
				<b>평점 순 </b>인기 상품
			</div>
		</div>
		<hr />
	</div>
	<div class="container">
		<div class="row">
			<div class="album">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-3">
					<c:forEach items="${ls}" var="ls">
						<div class="col">
							<div class="card border-0">
								<div class="image_wrap"
									data-product_id="${ls.imageList[0].product_id}"
									data-path="${ls.imageList[0].uploadPath}"
									data-uuid="${ls.imageList[0].uuid}"
									data-filename="${ls.imageList[0].fileName}">
									<img class="img-fluid" alt="Responsive image">
								</div>
								<div class="card-body px-0">
									<p class="card-text">
										<a class="text-dark text-decoration-none" href="/">${ls.product_title}</a>
									</p>
									<div class="d-flex justify-content-between align-items-center">
										<small class="text-muted">${ls.ratingavg}</small>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div> --%>
	<script>
	/* 이미지 삽입 */
	$(".image_wrap").each(function(i, obj){
		
		const pobj = $(obj);
		
		if(pobj.data("product_id")){
			const uploadPath = pobj.data("path");
			const uuid = pobj.data("uuid");
			const fileName = pobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		} else {
			$(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
		}
		
	});	
	</script>
</body>
</html>
