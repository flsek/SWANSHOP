<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
	<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link href="${path}/resources/css/reply.css"
	rel="stylesheet" />
</head>
<body>
<div class="wrapper_div">
		<div class="subject_div">
			리뷰 등록
		</div>

	<div class="input_wrap">			
			<div class="bookName_div">
				<h2>${productsInfo.product_title}</h2>
			</div>
			<div class="rating_div">
				<h4>평점</h4>
				<select name="rating">
					<option value="0.5">0.5</option>
					<option value="1.0">1.0</option>
					<option value="1.5">1.5</option>
					<option value="2.0">2.0</option>
					<option value="2.5">2.5</option>
					<option value="3.0">3.0</option>
					<option value="3.5">3.5</option>
					<option value="4.0">4.0</option>
				</select>
			</div>
			<div class="content_div">
				<h4>리뷰</h4>
				<textarea name="content"></textarea>
			</div>
		</div>
		<div class="btn_wrap">
			<a class="cancel_btn">취소</a><a class="enroll_btn">등록</a>
		</div>
	</div>
	<script>
	
	/* 취소 버튼 */
	$(".cancel_btn").on("click", function(e){
		window.close();
	});	
	
	/* 등록 버튼 */
	$(".enroll_btn").on("click", function(e){
		const product_id = '${productsInfo.product_id}';
		const member_id = '${member_id}';
		const rating = $("select").val();
		const content = $("textarea").val();

		const data = {
				product_id : product_id,
				member_id : member_id,
				rating : rating,
				content : content
		}
		
		/* ajax를 통해 리뷰 등록 요청하는 코드를 작성 */
		$.ajax({
			data : data,
			type : 'POST',
			url : '/reply/enroll',
			success : function(result){
				/* window.close() 코드가 실행되기 전에 부모 창(product_detail.jsp)의 리뷰을 최신화되도록 함.
					window.close() 메서드 윗 공간에 부모 창의 replyListInit() 함수를 호출해주는 코드를 작성.
				*/
				/* 리뷰 초기화 */
				$(opener.location).attr("href", "javascript:replyListInit();");
				
				window.close();
			}
			
		});
	});
	</script>
</body>
</html>