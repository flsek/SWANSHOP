<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
	<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link href="${path}/resources/css/product/productDetail.css"
	rel="stylesheet" />
<style>
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
    top: 150px;">
	<div class="main-wrapper">
		<div class="container">
			<div class="product-div">
				<div class="product-div-left">
					<div class="img-container"
						data-product_id="${productsInfo.imageList[0].product_id}"
						data-path="${productsInfo.imageList[0].uploadPath}"
						data-uuid="${productsInfo.imageList[0].uuid}"
						data-filename="${productsInfo.imageList[0].fileName}">
						<img alt="product image">
					</div>
				</div>
				<div class="product-div-right">
					<span class="product-name">${productsInfo.product_title}(평점: ${productsInfo.ratingavg})</span> <span
						class="product-price"><fmt:formatNumber
							value="${productsInfo.product_price}" pattern="#,### 원" /></span>
					<p class="product-description">				
						제품 수량: ${productsInfo.product_stock}
					</p>
					<div class="product-rating">
						주문 수량: <input type="text" class="quantity_input" value="1" style="width: 27px;"/> <span>
							<button class="plus_btn">+</button>
							<button class="minus_btn">-</button>
						</span>
					</div>
					<p class="product-description">${productsInfo.product_content}</p>
					<div class="btn-groups">
						<button type="button" class="add-cart-btn">
							<i class="fas fa-shopping-cart"></i>장바구니
						</button>
						<button type="button" class="buy-now-btn">
							<i class="fas fa-wallet"></i>구매하기
						</button>
					</div>
					<div class="subline" style="margin-top:15px;"></div>
					 <div class="subbox">
						 <p>배송 방법: 택배</p>
						 <p>택배비: 3,000 원 (30,000 원 이상 시 무료)</p>
						 <p>한진 택배</p>
					 </div>
				</div>
			</div>
			<c:if test="${member != null}">
				<div class="reply_button_wrap">
					<button><i class="fab fa-twitter"></i></button>
				</div>
			</c:if>
			<div class="reply_not_div"></div>
			<ul class="reply_content_ul">
<!-- 				<li>
					<div class="comment_wrap">
						<div class="reply_top">
							<span class="id_span">sjinjin7</span> <span class="date_span">2021-10-11</span>
							<span class="rating_span">평점 : <span
								class="rating_value_span">4</span>점
							</span> <a class="update_reply_btn">수정</a><a class="delete_reply_btn">삭제</a>
						</div>
						<div class="reply_bottom">
							<div class="reply_bottom_txt">사실 기대를 많이하고 읽기시작했는데 읽으면서 가가
								쓴것이 맞는지 의심들게합니다 문체도그렇고 간결하지 않네요 제가 기대가 크던 작았던간에 책장이 사실 안넘겨집니다.</div>
						</div>
					</div>
				</li> -->
			</ul>
			<div class="repy_pageInfo_div">
				<ul class="pageMaker">
						<!-- <li class="pageMaker_btn prev">
							<a>이전</a>
						</li>
						<li class="pageMaker_btn">
							<a>1</a>
						</li>
						<li class="pageMaker_btn">
							<a>2</a>
						</li>
						<li class="pageMaker_btn active">
							<a>3</a>
						</li>													
						<li class="pageMaker_btn next">
							<a>다음</a>
						</li> -->
					</ul>
			</div>
		</div>
		<!-- 주문 form -->
		<form action="/orders/${member.id}" method="get" class="order_form">
			<input type="hidden" name="orders[0].product_id" value="${productsInfo.product_id}"> 
			<input type="hidden" name="orders[0].product_count" value="">
		</form>
	</div>
	</div>
	<script>
	$(document)
	.ready(
			function() {

				/* 이미지 삽입 */
				$(".img-container")
						.each(
								function(i, obj) {

									const pobj = $(obj);

									if (pobj.data("product_id")) {
										const uploadPath = pobj
												.data("path");
										const uuid = pobj
												.data("uuid");
										const fileName = pobj
												.data("filename");

										const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);

										$(this)
												.find("img")
												.attr(
														'src',
														'/display?fileName='
																+ fileCallPath);

									} else {

										$(this)
												.find("img")
												.attr('src',
														'/resources/img/goodsNoImage.png');

									}

								});

			});
	
		// 수량 버튼 조작
		let quantity = $(".quantity_input").val();
		$(".plus_btn").on("click", function(){
			$(".quantity_input").val(++quantity);
		});
		$(".minus_btn").on("click", function(){
			if(quantity > 1){
				$(".quantity_input").val(--quantity);	
			}
		});
		
		// 서버로 전송할 데이터
		const form = {
				member_id : '${member.id}',
				product_id : '${productsInfo.product_id}',
				product_count : ''
		}
		
		// 장바구니 추가 버튼
		$(".add-cart-btn").on("click", function(e){
			form.product_count = $(".quantity_input").val();
			$.ajax({
				url: '/cart/add',
				type: 'POST',
				data: form,
				success: function(result){
					cartAlert(result);
				}
			})
		});
		
		function cartAlert(result){
			if(result == '0'){
				alert("장바구니에 추가를 하지 못하였습니다.");
			} else if(result == '1'){
				alert("장바구니에 추가되었습니다.");
			} else if(result == '2'){
				alert("장바구니에 이미 추가되어져 있습니다.");
			} else if(result == '5'){
				alert("로그인이 필요합니다.");	
			}
		}
		 
		/* 바로 구매 버튼 */
		$(".buy-now-btn").on("click", function(){
			let product_count = $(".quantity_input").val();
			$(".order_form").find("input[name='orders[0].product_count']").val(product_count);
			$(".order_form").submit();
		});
		
		/* 리뷰 쓰기 */
		$(".reply_button_wrap").on("click", function(e){
			
			e.preventDefault();	
			
			const member_id = '${member.id}';
			const product_id = '${productsInfo.product_id}';

			/* 리뷰 체크 */
			$.ajax({
				data : {
					product_id : product_id,
					member_id : member_id
				},
				url : '/reply/check',
				type : 'POST',
				success : function(result){
					if(result === '1'){
						alert("이미 등록된 리뷰가 존재합니다.")
					} else if(result === '0'){
						/* 리뷰 체크를 서버에 요청 후 댓글이 없다는 결과 값을 받았을 때 동작하도록 함. */
						let popUrl = "/replyEnroll/" + member_id + "?product_id=" + product_id;
						console.log(popUrl);
						let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
						
						window.open(popUrl,"리뷰 쓰기",popOption);							
					}
				}
			});
		});
		
		/* 리뷰 페이지 정보 */
		 const cri = {
			product_id : '${productsInfo.product_id}',
			pageNum : 1,
			amount : 10
		}
		
		 /* 리뷰 페이지 이동 버튼 동작 */
			$(document).on('click', '.pageMaker_btn a', function(e){
				
				/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
				e.preventDefault();
				
				/* 변수를 선언하고 회원이 클릭한 페이지 번호를 대입 */
				let page = $(this).attr("href");	
				
				/* 현재 페이지 정보를 저장하고 있는 cri 객체의 pageNum 프로퍼티 값을 사용자가 클릭한 번호 값으로 변경 해준 코드를 작성 */
				cri.pageNum = page;		
				
				replyListInit();
					
			 });
		
		 /* 리뷰 데이터 서버 요청 및 리뷰 동적 생성 메서드 */
		let replyListInit = function(){
			$.getJSON("/reply/list", cri , function(obj){
					
				makeReplyContent(obj);
					
			});	
		}
		
		/* 리뷰 수정 버튼 */
		 $(document).on('click', '.update_reply_btn', function(e){
			/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
			 e.preventDefault();
			 let reply_id = $(this).attr("href");
			 /* 쿼리스트링 방식으로 서버에 데이터를 전송할 수 있도록 url 값을 작성 */
			 let popUrl = "/replyUpdate?reply_id=" + reply_id + "&product_id=" + '${productsInfo.product_id}' + "&member_id=" + '${member.id}';
			 
			 /* 리뷰 수정 팝업창에 관한 설정 값을 대입 */
			 let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"	
			 window.open(popUrl,"리뷰 수정",popOption);
		 }); 
		
		 /* 리뷰 삭제 버튼 */
		 $(document).on('click', '.delete_reply_btn', function(e){
			/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
			 e.preventDefault();
			
			/* 삭제 버튼 태그의 href 속성에 저장해둔 reply_id 값을 새로 변수를 선언하여 대입 */
			 let reply_id = $(this).attr("href");
			
			/* ajax를 사용해서 리뷰 삭제를 서버에 요청 */
			 $.ajax({
					data : {
						reply_id : reply_id,
						product_id : '${productsInfo.product_id}'
					},
					url : '/reply/delete',
					type : 'POST',
					success : function(result){
						/* 서버가 요청을 정상적으로 처리했을 때 동작하는 succes속성 값 함수에 리뷰를 최신화하는 메서드인 replyListInit() 메서드를 호출하고 
						회원이 작성한 리뷰가 정상적으로 삭제되었음을 알 수 있는 경고창을 뛰우도록 코드를 작성 */
						replyListInit();
						alert('삭제가 완료되었습니다.');
					}
				});
				
		 });
		 
		/* 리뷰 리스트 출력 */
		const product_id = '${productsInfo.product_id}';	

		
		/* getJSON 메서드의 파라미터 
		- 첫 번째 파라미터 : 요청 URL

		- 두 번째 파라미터 : 서버에 전송할 데이터

		- 세 번째 파라미터 : 서버로부터 응답을 성공했을 때 동작할 코드
		
		 */
		$.getJSON("/reply/list", {product_id : product_id}, function(obj) {
			
			makeReplyContent(obj);
			
		});
		
		/* 리뷰 동적 생성 메서드 */
		function makeReplyContent(obj){
				/* 리뷰가 없는 경우
				list프로퍼티의 값에 아무 데이터가 없을 경우 댓글이 없는 경우이기 때문에 ". length"속성을 사용하여 데이터가 있는지 없는지를 판단
			*/
			if(obj.list.length === 0){
				$(".reply_not_div").html('<span> 리뷰가 없습니다.</span>');
				$(".reply_content_ul").html('');
				$(".pageMaker").html('');
			} else {
				$(".reply_not_div").html('');
				const list = obj.list;
				const pf = obj.pageInfo;
				const userId = '${member.id}';	
				
				/* list */
				let reply_list = '';
				
				/* 변수  list에 담긴 데이터들은 List<ReplyDTO>가 JSON형식으로 변한 것이기 때문에 
					Javascript 배열 객체가 들어 있음. 
					list에 담긴 배열 길이만큼 순환하여 동작하는 Jquery의 each 메서드를 작성	
				*/
				$(list).each(function(i,obj){
					reply_list += '<li>';
					reply_list += '<div class="comment_wrap">';
					reply_list += '<div class="reply_top">';
					/* 아이디 */
					reply_list += '<span class="id_span">'+ obj.member_id+'</span>';
					/* 날짜 */
					reply_list += '<span class="date_span">'+ obj.regdate +'</span>';
					/* 평점 */
					reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
					if(obj.member_id === userId){
						reply_list += '<a class="update_reply_btn" href="'+ obj.reply_id +'">수정</a><a class="delete_reply_btn" href="'+ obj.reply_id +'">삭제</a>';
					}
					reply_list += '</div>'; //<div class="reply_top">
					reply_list += '<div class="reply_bottom">';
					reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
					reply_list += '</div>';//<div class="reply_bottom">
					reply_list += '</div>';//<div class="comment_wrap">
					reply_list += '</li>';
				});
				
				$(".reply_content_ul").html(reply_list);
				
				/* 페이지 버튼 */
				let reply_pageMaker = '';
				
				/* prev */
				if(pf.prev){
					let prev_num = pf.pageStart -1;
					reply_pageMaker += '<li class="pageMaker_btn prev">';
					reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
					reply_pageMaker += '</li>';	
				}
				/* numbre btn */
				for(let i = pf.pageStart; i < pf.pageEnd+1; i++){
					reply_pageMaker += '<li class="pageMaker_btn ';
					if(pf.cri.pageNum === i){
						reply_pageMaker += 'active';
					}
					reply_pageMaker += '">';
					reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
					reply_pageMaker += '</li>';
				}
				/* next */
				if(pf.next){
					let next_num = pf.pageEnd +1;
					reply_pageMaker += '<li class="pageMaker_btn next">';
					reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
					reply_pageMaker += '</li>';	
				}
				
				console.log(reply_pageMaker);
				/* 페이지 버튼 태그 문자열이 저장된 reply_pageMaker를 ".pageMaker" <ul> 태그에 추가하는 코드를 작성 */
				$(".pageMaker").html(reply_pageMaker);	
			}
		}
	</script>
</body>
</html>