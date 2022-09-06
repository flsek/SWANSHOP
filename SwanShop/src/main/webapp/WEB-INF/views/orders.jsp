<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link href="${path}/resources/css/order.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Order</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<jsp:include page="common/header.jsp" />
<main>
	<div class="content_area">
		<div class="content_subject"><span>주문하기</span></div>
		<div class="content_main">
			<!-- 회원 정보 -->
			<div class="member_info_div">
				<table class="table_text_align_center memberInfo_table">
					<tbody>
						<tr>
							<th style="width: 25%;">주문자</th>
							<td style="width: *">${memberInfo.id}| ${memberInfo.email}</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 배송지 정보 -->
			<div class="addressInfo_div">
				<div class="addressInfo_button_div">
					<button class="address_btn address_btn_1" onclick="showAdress('1')"
						style="background-color: #3c3838;">사용자 정보 주소록</button>
					<button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
				</div>
				<div class="addressInfo_input_div_wrap">
					<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
						<table>
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>이름</th>
									<td>${memberInfo.name}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>${memberInfo.address}
										<!-- 추후 JS코드를 통해 사용자가 '사용자 정보 주소록' 선택했을 때 가져올 데이터가 저장된  hidden 타입의 <input> 태그 -->
										<input class="selectAddress" value="T" type="hidden"> 
										<input class="addressee_input" value="${memberInfo.name}" type="hidden"> 
										<input class="address1_input" type="hidden" value="${memberInfo.address}"> 
										<input class="address2_input" type="hidden" value="${memberInfo.address2}">
									</td>
								</tr>
								<tr>
									<th>상세 주소</th>
									<td>${memberInfo.address2}
										<input class="selectAddress" value="T" type="hidden"> 
										<input class="addressee_input" value="${memberInfo.name}" type="hidden"> 
										<input class="address1_input" type="hidden" value="${memberInfo.address}"> 
										<input class="address2_input" type="hidden" value="${memberInfo.address2}">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="addressInfo_input_div addressInfo_input_div_2">
						<table>
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>이름</th>
									<td><input class="addressee_input"></td>
								</tr>
								<tr>
									<th>주소</th>
									<td>
										<input class="selectAddress" value="F" type="hidden">
										<input id="address1_input" readonly="readonly"> 
										<a onclick="execPostCode();">주소 찾기</a><br> 
									</td>
								</tr>
								<tr>
									<th>상세 주소</th>
									<td>
										<input class="selectAddress" value="F" type="hidden">
										<input class="address2_input" placeholder="상세 주소">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- 상품 정보 -->
			<div class="orderproducts_div">
				<!-- 상품 종류 -->
				<div class="products_kind_div">
					주문 상품 
					<span class="products_kind_div_kind"></span> 종 
					<span class="products_kind_div_count"></span> 개
				</div>
				<!-- 상품 테이블 -->
				<table class="products_subject_table">
					
					<tbody>
						<tr>
							<th>이미지</th>
							<th>상품 정보</th>
							<th>판매가</th>
						</tr>
					</tbody>
				</table>
				<table class="products_table">
					<colgroup>
						<col width="15%">
						<col width="45%">
						<col width="40%">
					</colgroup>
					<tbody>
						<c:forEach items="${orderList}" var="ol">
							<tr>
								<td>
								<div class="image_wrap" data-product_id="${ol.imageList[0].product_id}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
									<img>
								</div>
								</td>
								<td class="individual_productTitle_input">${ol.product_title}</td>
								<td class="products_table_price_td">
									<fmt:formatNumber value="${ol.product_price}" pattern="#,### 원" /> | 수량 ${ol.product_count}개
									<br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
									<input type="hidden" class="individual_salePrice_input" value="${ol.product_price}">
									<input type="hidden" class="individual_productCount_input" value="${ol.product_count}">
									<input type="hidden" class="individual_totalPrice_input" value="${ol.product_price * ol.product_count}">
									<input type="hidden" class="individual_productId_input" value="${ol.product_id}">
								</td>
							</tr>							
							</c:forEach>

					</tbody>
				</table>
			</div>


			<!-- 주문 종합 정보 -->
			<div class="total_info_div">
				<!-- 가격 종합 정보 -->
				<div class="total_info_price_div">
					<ul>
						<li><span class="price_span_label">상품 금액</span> 
						<span class="totalPrice_span"></span> 원</li>
						<li><span class="price_span_label">배송비</span> 
						<span class="delivery_price_span"></span> 원</li>
						<li class="price_total_li">
						<strong class="price_span_label total_price_label">최종 결제 금액</strong> 
						<strong class="strong_red"> 
						<span class="total_price_red finalTotalPrice_span"></span> 원
						</strong></li>
					</ul>
				</div>
				<!-- 버튼 영역 -->
				<div class="total_info_btn_div">
					<a class="order_btn">결제하기</a>
				</div>
			</div>

		</div>

		<!-- 주문 요청 form -->
		<form class="order_form" action="/orders" method="post">
			<!-- 주문자 회원번호 -->
			<input name="member_id" value="${memberInfo.id}" type="hidden">
			<!-- 주소록 & 받는이-->
			<input name="addressee" type="hidden"> 
			<input name="address" type="hidden"> 
			<input name="address2" type="hidden">

			<!-- 상품 정보 -->
		</form>

	</div>
	</main>
	<script>
	$(document).ready(function(){
		
		/* 주문 조합정보란 최신화 */
		setTotalInfo();
		
		var IMP = window.IMP;
        // var code = "imp93385135"; //가맹점 식별코드
        var code = "imp93385135";
        IMP.init(code);
		
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
				$(this).find("img").attr('src', '/resources/img/productsNoImage.png');
			}
			
		});		
		
		 /* 총 주문 정보 세팅(배송비, 총 가격, 물품 수, 종류) */
	      function setTotalInfo(){

	         let totalPrice = 0;            // 총 가격
	         let totalCount = 0;            // 총 개수
	         let totalKind = 0;            // 총 종류
	         let deliveryPrice = 0;         // 배송비
	         let finalTotalPrice = 0;       // 최종 가격(총 가격 + 배송비)
	         
	         $(".products_table_price_td").each(function(index, element){
	         // 총 가격
	         totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
	         // 총 개수
	         totalCount += parseInt($(element).find(".individual_productCount_input").val());
	         // 총 종류
	         totalKind += 1;
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
	      
	      /* 값 삽입 */
	      // 총 가격
	      $(".totalPrice_span").text(totalPrice.toLocaleString());
	      // 총 개수
	      $(".products_kind_div_count").text(totalCount);
	      // 총 종류
	      $(".products_kind_div_kind").text(totalKind);
	      // 배송비
	      $(".delivery_price_span").text(deliveryPrice.toLocaleString());   
	      // 최종 가격(총 가격 + 배송비)
	      $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());      
	      console.log(finalTotalPrice)
	   
	      }	
		
		
		var pay =  $(".finalTotalPrice_span").text().replace(",","");
        console.log(pay);
        
        var goods = $(".individual_productTitle_input").text();
        console.log(goods);
       
    
       
         
         // 결제요청
         $('.order_btn').click(function(e){
            
            /* 주소 정보 & 받는이*/
			$(".addressInfo_input_div").each(function(i, obj){
				if($(obj).find(".selectAddress").val() === 'T'){
					$("input[name='addressee']").val($(obj).find(".addressee_input").val());
					$("input[name='address']").val($(obj).find(".address1_input").val());
					$("input[name='address2']").val($(obj).find(".address2_input").val());
				}
			});
            
            let form_contents = '';
      		$(".products_table_price_td").each(function(index, element){
      			let product_id = $(element).find(".individual_productId_input").val();
      			let product_count = $(element).find(".individual_productCount_input").val();
      			let productId_input = "<input name='orders[" + index + "].product_id' type='hidden' value='" + product_id + "'>";
      			form_contents += productId_input;
      			let productCount_input = "<input name='orders[" + index + "].product_count' type='hidden' value='" + product_count + "'>";
      			form_contents += productCount_input;
      		});	

      	$(".order_form").append(form_contents);
      	
        IMP.request_pay({
           pg : 'kakaopay',    
           pay_method: 'card',
           merchant_uid: '${ memberInfo.id }' + new Date().getTime(),
           name: goods, //상품명
           amount: pay,
           buyer_email: '${ memberInfo.email }',
           buyer_tel :	 '${ memberInfo.phone }',
           buyer_name: '${ memberInfo.name }',
           buyer_addr: '${memberInfo.address}'
           
           }, function(rsp){
               if(rsp.success){
                  var msg = '결제가 완료되었습니다.' + " ";
                  msg += '고유ID : ' + rsp.imp_uid + " ";
                  msg += '상점 거래ID : ' + rsp.merchant_uid + " ";
                  msg += '결제 금액 : ' + rsp.paid_amount + " 원";
					
                  console.log("결제 성공 " + msg);
                  $.ajax({
                    url: '/orders',
                    type: 'POST',
                    data: form_contents,
                    contentType:'application/json;charset=utf-8',
                    dataType: 'json', //서버에서 보내줄 데이터 타입
                    success: function(res){
                       
                       if(res == 1){
                          console.log("추가 성공");
                          
                          location.href = "/swan"; 

                       } else {
                          console.log("Insert fail!");
                       
                          return false;
                       }
                    }, error:function(){
                       console.log("Insert ajax 통신 실패!");
                    }
                  });//ajax
                  
                  $(".order_form").submit();

               }
               else{
                  //결제 실패시
                  var msg = '결제에 실패했습니다.';
                  msg += '에러 : ' + rsp.error_msg
               }
               alert(msg);
            });
         });
		
	});
	
	/* 주소입력란 버튼 동작(숨김, 등장) */
	function showAdress(className){
		/* 컨텐츠 동작 */
			/* 모두 숨기기 */
			$(".addressInfo_input_div").css('display', 'none');
			/* 컨텐츠 보이기 */
			$(".addressInfo_input_div_" + className).css('display', 'block');		
		
		/* 버튼 색상 변경 */
			/* 모든 색상 동일 */
				$(".address_btn").css('backgroundColor', '#555');
			/* 지정 색상 변경 */
				$(".address_btn_"+className).css('backgroundColor', '#3c3838');	
		/* selectAddress T/F */
			/* 모든 selectAddress F만들기 */
				$(".addressInfo_input_div").each(function(i, obj){
					$(obj).find(".selectAddress").val("F");
				});
			/* 선택한 selectAdress T만들기 */
				$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");		
	}
	</script>
	
	<!-- 주소 API 가져오기 -->
	<script src=http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false></script>
	<script>   
	   function execPostCode() {
	      daum.postcode.load(function() {
	         new daum.Postcode({
	            oncomplete : function(data) {
	               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	               
	               // 각 주소의 노출 규칙에 따라 주소를 조합
	               // 내려오는 변수가 값이 없을 땐 공백('')값을 가지므로, 이를 참고
	               var addr = ''; // 주소 변수
	               
	               // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴
	               if(data.userSelectedType == 'R'){
	                  // 사용자가 도로명 주소를 선택했을 경우
	                  addr = data.roadAddress;
	               } else {
	                  // 사용자가 지번 주소를 선택했을 경우
	                  addr = data.jibunAddress;
	               }
	               
	               // 주소 정보를 해당 필드에 넣음.
	               document.getElementById('address1_input').value = addr;
	               
	               // 커서를 주소 필드로 이동
	               document.getElementById("address1_input").focus();
	               
	            }
	         }).open();
	
	      });
	   }
	   
	  
	   
	</script>
</body>
</html>