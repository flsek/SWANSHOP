<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${path}/resources/css/cart/cart.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<!-- Boxicons CDN Link -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>OrderList</title>

<style>
/*
 section#content ul li { display:inline-block; margin:10px; }
 section#content div.goodsThumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; }
*/
section#content ul li {
	list-style-type: none;
	border: 5px solid #eee;
	padding: 10px 20px;
	margin-bottom: 20px;
}

section#content .orderList span {
	font-size: 20px;
	font-weight: bold;
	display: inline-block;
	width: 90px;
	margin-right: 10px;
}

body nav {
    position: fixed;
    top: 0;
    background-color: #fff;
    width: 100%;
    z-index: 200 !important;
}

</style>

</head>
<body>
	<jsp:include page="common/header.jsp" />
	<div style="width: 100%;
    padding: 0 85px;
    position: absolute;
    z-index: 100;
    top: 40px;">
		<div class="content_area">
			<div class="content_subject">
				<span>주문 목록</span>
			</div>
			<section id="content">

				<ul class="orderList">
					<c:forEach items="${orderList}" var="orderList">
						<li>
							<div>
								<p>
									<span>주문 번호</span><a href="/orderView?n=${orderList.order_id}">${orderList.order_id}</a>
								</p>
								<p>
									<span>수령인</span>${orderList.addressee}</p>
								<p>
									<span>주소</span>(${orderList.address}) ${orderList.address2}
								</p>
								<p>
									<span>주문 날짜</span>${orderList.order_date}</p>
								<p>
									<span>배송 상태</span>${orderList.order_state}</p>
								<p>
									<p><span>배송비</span><fmt:formatNumber pattern="###,###,###" value="${orderList.deliverycost}" /> 원</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</section>
		</div>
		</div>
</body>
</html>