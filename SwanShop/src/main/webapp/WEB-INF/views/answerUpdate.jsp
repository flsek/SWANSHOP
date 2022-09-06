<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 수정</title>
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
				<h2>${questionInfo.q_title}</h2>
			</div>
			<div class="content_div">
				<h4>리뷰</h4>
				<textarea name="content">${answerInfo.content}</textarea>
			</div>
		</div>
		<div class="btn_wrap">
			<a class="cancel_btn">취소</a><a class="update_btn">수정</a>
		</div>
	</div>
	<script>
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
			const a_id = '${answerInfo.a_id}';
			const q_id = '${answerInfo.q_id}';
			const member_id = '${member_id}';
			const content = $("textarea").val();	
			
			const data = {
					a_id : a_id,
					q_id : q_id,
					member_id : member_id,
					content : content
			}
			
			/* 리뷰 수정을 서버에 요청 */
			$.ajax({
				data : data,
				type : 'POST',
				url : '/answer/update',
				success : function(result){
					$(opener.location).attr("href", "javascript:answerListInit();");
					window.close();
				}			
			});
		});
	</script>
</body>
</html>