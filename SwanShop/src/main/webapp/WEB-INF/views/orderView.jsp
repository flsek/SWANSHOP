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
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<meta charset="UTF-8">
<!-- Boxicons CDN Link -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>OrderView</title>

<style>
/*
 section#content div.goodsThumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; }
*/
 section#content ul li { display:inline-block}
.orderInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
 .orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:90px; }
 
 .orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; }
 .orderView li::after { content:""; display:block; clear:both; }
 
 .thumb { float:left; width:200px; }
 .thumb img { width:200px; height:200px; }
 .gdsInfo { float:right; width:calc(100% - 220px); line-height:2; }
 .gdsInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }
</style>

</head>
<body>
	<jsp:include page="common/header.jsp" />
	<main>
		<div class="content_area">
			<div class="content_subject">
				<span>주문 목록</span>
			</div>
			<section id="content">

				<div class="orderInfo">
					<c:forEach items="${orderView}" var="orderView" varStatus="status">

						<c:if test="${status.first}">
							<p>
								<span>수령인</span>${orderView.addressee}</p>
							<p>
								<span>주소</span>(${orderView.address}) ${orderView.address2}
							</p>
							
						</c:if>
					</c:forEach>
				</div>

				<ul class="orderView">
					<c:forEach items="${orderView}" var="orderView">
						<li>
							<div class="thumb image_wrap"
							data-product_id="${orderView.imageList[0].product_id}"
							data-path="${orderView.imageList[0].uploadPath}"
							data-uuid="${orderView.imageList[0].uuid}"
							data-filename="${orderView.imageList[0].fileName}">
								<img>
							</div>
							<div class="gdsInfo">
								<p>
									<span>상품명</span>${orderView.product_title}<br /> <span>개당 가격</span>
									<fmt:formatNumber pattern="###,###,###"
										value="${orderView.product_price}" />
									원<br /> <span>구입 수량</span>${orderView.product_count} 개<br /> <span>최종
										가격</span>
									<fmt:formatNumber pattern="###,###,###"
										value="${orderView.product_price * orderView.product_count}" />
									원
								</p>
							</div>
						<!-- <input type="button" id="check2" value="환불"> -->
						</li>
					</c:forEach>
				</ul>
			</section>
		</div>
	</main>
	<script>
		$(document).ready(function(){
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
		
		/* $("#check2").click(function(e){
			$.ajax({
					url: "/cancel",
					type:"POST",
					datatype:"json",
					contentType : 'application/x-www-form-urlencoded; charset = utf-8',
					data : {
						"merchant_uid": '${ order_id }', // 예: ORD20180131-0000011
						//"cancle_request_amount" : 2000, //환불금액
						//"reason": "테스트 결제 환불", //환불사유
						//"refund_holder": "홍길동", //[가상계좌 환불시 필수입력] 환불 가상계좌 예금주
						//"refund_bank":"88", //[가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex Kg이니시스의 경우 신한은행 88)
						//"refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
					}
				}).done(function(result){ //환불 성공	
					alert("환불 성공 : " + result);
				}).fail(function(error){ // 환불 실패시 로직
					alert("환불 실패: " + error);
				});//ajax
			
		}); //check2 클릭 */
		
	});	
	</script>
</body>
</html>