<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
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
			리뷰 수정
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
				<textarea name="content">${replyInfo.content}</textarea>
			</div>
		</div>
		<div class="btn_wrap">
			<a class="cancel_btn">취소</a><a class="update_btn">수정</a>
		</div>
	</div>
	<script>
		/* 회원 평점 데이터(rating) */
		$(document).ready(function(){
			/* 변수를 선언하여 Controller로부터 전달받은 rating 값을 대입 */
			let rating = '${replyInfo.rating}';
			
			/*  if문을 작성해서 변수 rating에 담긴 값과 동일할 때 해당 <option> 태그에 "selected"속성이 추가되도록 코드를 작성 */
			$("option").each(function(i, obj){
				if(rating === $(obj).val()){
					$(obj).attr("selected", "selected");
				}
			});
		});
		
		/* 취소 버튼 */
		$(".cancel_btn").on("click", function(e){
			window.close();
		});
		
		/* 수정 버튼 */
		$(".update_btn").on("click", function(e){
			
			/* content, rating의 경우 팝업창의 태그에 작성된 값을 가져오도록 코드가 적성되어 있는데, 
			이 값들은 '수정' 버튼이 클릭했을 때 값들을 가져오기 때문에 회원이 수정한 값이 대입 됨.
			변수를 선언한 값들을 프로퍼티로 가지는 객체를 선언해주고 객체의 주소를 새로 선언한 변수에 대입
			*/
			const reply_id = '${replyInfo.reply_id}';
			const product_id = '${replyInfo.product_id}';
			const member_id = '${member_id}';
			const rating = $("select").val();
			const content = $("textarea").val();	
			
			const data = {
					reply_id : reply_id,
					product_id : product_id,
					member_id : member_id,
					rating : rating,
					content : content
			}
			
			/* 리뷰 수정을 서버에 요청 */
			$.ajax({
				data : data,
				type : 'POST',
				url : '/reply/update',
				success : function(result){
					$(opener.location).attr("href", "javascript:replyListInit();");
					window.close();
				}			
			});
		});
	</script>
</body>
</html>