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
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<meta charset="UTF-8">
<!-- Boxicons CDN Link -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cart</title>
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<main>
<div class="content_area">		
	<div class="content_subject"><span>장바구니</span></div>
		<!-- 장바구니 리스트 -->
		<div class="content_middle_section"></div>
		<!-- 장바구니 가격 합계 -->
		<!-- cartInfo -->
		<div class="content_totalCount_section">
			<!-- 체크박스 전체 여부 -->
			<div class="all_check_input_div">
				<input type="checkbox" class="all_check_input input_size_20"
					checked="checked"><span class="all_chcek_span">전체 선택</span>
			</div>
			<table class="subject_table">
				<caption>표 제목 부분</caption>
				<tbody>
					<tr>
						<th class="td_width_1"></th>
						<th class="td_width_2"></th>
						<th class="td_width_3">상품명</th>
						<th class="td_width_4">가격</th>
						<th class="td_width_4">수량</th>
						<th class="td_width_4">합계</th>
						<th class="td_width_4">삭제</th>
					</tr>
				</tbody>
			</table>
			<table class="cart_table">
				<caption>표 내용 부분</caption>
				<tbody>
					<c:forEach items="${cartInfo}" var="ci">
						<tr>
							<td class="td_width_1 cart_info_td">
								<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
								<input type="hidden" class="individual_salePrice_input" value="${ci.product_price}"> 
								<input type="hidden"class="individual_productCount_input" value="${ci.product_count}"> 
								<input type="hidden" class="individual_totalPrice_input" value="${ci.product_price * ci.product_count}"> 
								<input type="hidden" class="individual_productId_input" value="${ci.product_id}">
							</td>
							<td class="td_width_2">
								<div class="image_wrap"
									data-product_id="${ci.imageList[0].product_id}"
									data-path="${ci.imageList[0].uploadPath}"
									data-uuid="${ci.imageList[0].uuid}"
									data-filename="${ci.imageList[0].fileName}">
									<img>
								</div>
							</td>
							<td class="td_width_3 table_text_align_center">${ci.product_title}</td>
							<td class="td_width_4 table_text_align_center"><fmt:formatNumber
									value="${ci.product_price}" pattern="#,### 원" /> <br></td>
							<td class="td_width_4 table_text_align_center">
								<div class="table_text_align_center quantity_div">
									<input type="text" value="${ci.product_count}"
										class="quantity_input">
									<button class="quantity_btn plus_btn">+</button>
									<button class="quantity_btn minus_btn">-</button>
								</div> 
								<a class="quantity_modify_btn" data-cart_id="${ ci.cart_id }">변경</a>
							</td>
							<td class="td_width_4 table_text_align_center">
								<fmt:formatNumber value="${ci.product_price * ci.product_count}" pattern="#,### 원" /></td>
							<td class="td_width_4 table_text_align_center delete_btn" data-cart_id="${ ci.cart_id }"><button><i class="fas fa-trash"></i></button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		<!-- 가격 종합 -->
		<div class="content_total_section">
			<div class="total_wrap">
				<table>
					<tr>
						<td>
							<table>
								<tr>
									<td>총 상품 가격</td>
									<td><span class="totalPrice_span"></span> 원</td>
								</tr>
								<tr>
									<td>배송비</td>
									<td><span class="delivery_price">3000</span> 원</td>
								</tr>
								<tr>
									<td>총 상품 수 </td>
									<td><span class="totalCount_span"></span>개</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<div class="boundary_div">구분선</div>
				<table>
					<tr>
						<td>
							<table>
								<tbody>
									<tr>
										<td><strong>총 결제 예상 금액 </strong></td>
										<td><span class="finalTotalPrice_span"></span> 원</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
		<!-- 구매 버튼 영역 -->
		<div class="content_btn_section">
			<a class="order_btn">주문하기</a>
		</div>
		<!-- 수량 조정 form -->
		<form action="/cart/update" method="post" class="quantity_update_form">
			<input type="hidden" name="cart_id" class="update_cartId"> <input
				type="hidden" name="product_count" class="update_productCount"> <input
				type="hidden" name="member_id" value="${member.id}">
		</form>

		<!-- 삭제 form -->
		<form action="/cart/delete" method="post" class="quantity_delete_form">
			<input type="hidden" name="cart_id" class="delete_cartId"> <input
				type="hidden" name="member_id" value="${member.id}">
		</form>
		<!-- 주문 form -->
		<form action="/orders/${member.id}" method="get" class="order_form">
		</form>
	</main>
	<script>
	$(document).ready(function(){
		
		/* 종합 정보 섹션 정보 삽입 */
		setTotalInfo();	
		
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
		
		
	});	
	
	/* 체크여부에따른 종합 정보 변화 */
	$(".individual_cart_checkbox").on("change", function(){
		/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
		setTotalInfo($(".cart_info_td"));
	});

	/* 체크박스 전체 선택 */
	$(".all_check_input").on("click", function(){
		/* 체크박스 체크/해제 */
		if($(".all_check_input").prop("checked")){
			$(".individual_cart_checkbox").attr("checked", true);
		} else{
			$(".individual_cart_checkbox").attr("checked", false);
		}
		
		/* 총 주문 정보 세팅(배송비, 총 가격, 물품 수, 종류) */
		setTotalInfo($(".cart_info_td"));	
		
	});
	
	/* 총 주문 정보 세팅(배송비, 총 가격, 물품 수, 종류) */
	function setTotalInfo(){
		
		let totalPrice = 0;				// 총 가격
		let totalCount = 0;				// 총 개수
		let totalKind = 0;				// 총 종류
		let deliveryPrice = 0;			// 배송비
		let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)
		
		$(".cart_info_td").each(function(index, element){
			
			if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
				// 총 가격
				totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
				// 총 개수
				totalCount += parseInt($(element).find(".individual_productCount_input").val());
				// 총 종류
				totalKind += 1;		
			}
		});
		
		
		/* 배송비 결정 */
		if(totalPrice >= 30000){
			deliveryPrice = 0;
		} else if(totalPrice == 0){
			deliveryPrice = 0;
		} else {
			deliveryPrice = 3000;	
		}
		
			finalTotalPrice = totalPrice + deliveryPrice;
		
		/* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
		
		// 총 가격
		$(".totalPrice_span").text(totalPrice.toLocaleString());
		// 총 개수
		$(".totalCount_span").text(totalCount);
		// 총 종류
		$(".totalKind_span").text(totalKind);
		// 배송비
		$(".delivery_price").text(deliveryPrice);	
		// 최종 가격(총 가격 + 배송비)
		$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());		
	}
	/* 수량버튼 */
	$(".plus_btn").on("click", function(){
		let quantity = $(this).parent("div").find("input").val();
		$(this).parent("div").find("input").val(++quantity);
	});
	$(".minus_btn").on("click", function(){
		let quantity = $(this).parent("div").find("input").val();
		if(quantity > 1){
			$(this).parent("div").find("input").val(--quantity);		
		}
	});
	/* 수량 수정 버튼 */
	$(".quantity_modify_btn").on("click", function(){
		let cart_id = $(this).data("cart_id");
		let product_count = $(this).parent("td").find("input").val();
		$(".update_cartId").val(cart_id);
		$(".update_productCount").val(product_count);
		$(".quantity_update_form").submit();
		
	});
	/* 장바구니 삭제 버튼 */
	$(".delete_btn").on("click", function(e){
		e.preventDefault();
		const cart_id = $(this).data("cart_id");
		$(".delete_cartId").val(cart_id);
		$(".quantity_delete_form").submit();
	});
		
	/* 주문 페이지 이동 */
	$(".order_btn").on("click", function(){
		let form_contents ='';
		let orderNumber = 0;
		$(".cart_info_td").each(function(index, element){
			
			if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
			
				let product_id = $(element).find(".individual_productId_input").val();
				let product_count = $(element).find(".individual_productCount_input").val();
				
				let productId_input = "<input name='orders[" + orderNumber + "].product_id' type='hidden' value='" + product_id + "'>";
				form_contents += productId_input;
				
				let productCount_input = "<input name='orders[" + orderNumber + "].product_count' type='hidden' value='" + product_count + "'>";
				form_contents += productCount_input;
				
				orderNumber += 1;

			}
		});
		
		$(".order_form").html(form_contents);
		$(".order_form").submit();
	});
	
	</script>
</body>
</html>