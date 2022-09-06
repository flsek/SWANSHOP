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
			답변 등록
		</div>

	<div class="input_wrap">			
			<div class="bookName_div">
				<h2>"${questionInfo.q_title}"</h2>
			</div>
			
			<div class="content_div">
				<h4>답변 작성</h4>
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
		const q_id = '${questionInfo.q_id}';
		const member_id = '${member_id}';
		const content = $("textarea").val();

		const data = {
				q_id : q_id,
				member_id : member_id,
				content : content
		}
		
		/* ajax를 통해 리뷰 등록 요청하는 코드를 작성 */
		$.ajax({
			data : data,
			type : 'POST',
			url : '/answer/enroll',
			success : function(result){
				/* window.close() 코드가 실행되기 전에 부모 창(question_detail.jsp)의 리뷰을 최신화되도록 함.
					window.close() 메서드 윗 공간에 부모 창의 answerListInit() 함수를 호출해주는 코드를 작성.
				*/
				/* 리뷰 초기화 */
				$(opener.location).attr("href", "javascript:answerListInit();");
				
				window.close();
			}
			
		});
	});
	</script>
</body>
</html>