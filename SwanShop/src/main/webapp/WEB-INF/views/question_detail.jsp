<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>문의사항 상세보기</title>
<link href="${path}/resources/css/questions/questionDetail.css"
	rel="stylesheet" />
</head>
<body>
	<header>
		<jsp:include page="common/header.jsp" />
	</header>

	<div class="container">
		<div class="content">
			<div class="left-side">
				<div class="address details">
					<i class="fas fa-map-marker-alt"></i>
					<div class="topic">주소</div>
					<div class="text-one">서울특별시 성동구</div>
					<div class="text-two">행당로 (비밀~_~)</div>
				</div>
				<div class="phone details">
					<i class="fas fa-phone-alt"></i>
					<div class="topic">전화번호</div>
					<div class="text-one">010-1234-5678</div>
				</div>
				<div class="email details">
					<i class="fas fa-envelope"></i>
					<div class="topic">이메일</div>
					<div class="text-one">이메일@naver.com</div>
					<div class="text-two">이메일@naver.com</div>
				</div>
			</div>
			<div class="right-side">
				<div class="topic-text">문의사항</div>
				<br>
				<p>
					<b>글쓴이 :</b> ${ questionInfo.q_writer }
				</p>
				<input type="hidden" name="q_writer"
					value="${ questionInfo.q_writer }">
				<div class="input-box">
					<p>
						<b>제목:</b> ${ questionInfo.q_title }
					</p>
					<input type="hidden" value="${ questionInfo.q_title }"
						name="q_title">
				</div>
				<div class="input-box message-box">
					<p>${ questionInfo.q_content }</p>
					<input type="hidden" value="${ questionInfo.q_content }"
						name="q_content">
				</div>
				
				
				<c:if test="${ member.id eq questionInfo.q_writer }">
					<div class="button">
						<button class="send" type="button" id="modifyBtn">
							<i class="fas fa-edit"></i>
						</button>
						<button class="cancel" type="button" id="deleteBtn">
							<i class="fas fa-trash"></i>
						</button>
					</div>
				</c:if>
				<form id="moveForm" action="/question_list" method="get">
					<input type="hidden" name="pageNum" value="${cri.pageNum}">
					<input type="hidden" name="amount" value="${cri.amount}"> <input
						type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<c:if test="${ member.admin_ck == 1 }">
				<div class="reply_button_wrap">
					<button><i class="fab fa-twitter"></i></button>
				</div>
			</c:if>
			<div class="reply_not_div"></div>
			<ul class="reply_content_ul"></ul>
			</div>
		</div>
	</div>
		


	<script>
		/* 삭제 버튼 */
		$("#deleteBtn")
				.on(
						"click",
						function(e) {
							e.preventDefault();
							let moveForm = $("#moveForm");
							moveForm.find("input").remove();
							moveForm
									.append('<input type="hidden" name="q_id" value="${questionInfo.q_id}">');
							moveForm.attr("action", "/questionDelete");
							moveForm.attr("method", "post");
							moveForm.submit();
						});
		/* 수정 페이지 이동 */
		$("#modifyBtn")
				.on(
						"click",
						function(e) {
							e.preventDefault();
							let addInput = '<input type="hidden" name="q_id" value="${questionInfo.q_id}">';
							$("#moveForm").append(addInput);
							$("#moveForm").attr("action",
									"/question_update");
							$("#moveForm").submit();
						});
		
		/* 답변 쓰기 */
		$(".reply_button_wrap").on("click", function(e){
			
			e.preventDefault();	
			
			const member_id = '${member.id}';
			const q_id = '${questionInfo.q_id}';
			
			let popUrl = "/answerEnroll/"+ member_id + "?q_id=" + q_id;
			console.log(popUrl);
			let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
			
			window.open(popUrl,"답변 쓰기",popOption);
		});
		
		/* 답변 페이지 정보 */
		 const cri = {
			q_id : '${questionInfo.q_id}',
			pageNum : 1,
			amount : 10
		}
		
		 /* 답변 페이지 이동 버튼 동작 */
			$(document).on('click', '.pageMaker_btn a', function(e){
				
				/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
				e.preventDefault();
				
				/* 변수를 선언하고 회원이 클릭한 페이지 번호를 대입 */
				let page = $(this).attr("href");	
				
				/* 현재 페이지 정보를 저장하고 있는 cri 객체의 pageNum 프로퍼티 값을 사용자가 클릭한 번호 값으로 변경 해준 코드를 작성 */
				cri.pageNum = page;		
				
				answerListInit();
					
			 });
		
		 /* 답변 데이터 서버 요청 및 리뷰 동적 생성 메서드 */
		let answerListInit = function(){
			$.getJSON("/answer/list", cri , function(obj){					
				makeAnswerContent(obj);
					
			});	
		}
		
		/* 답변 수정 버튼 */
		 $(document).on('click', '.update_reply_btn', function(e){
			/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
			 e.preventDefault();
			 let a_id = $(this).attr("href");
			 /* 쿼리스트링 방식으로 서버에 데이터를 전송할 수 있도록 url 값을 작성 */
			 let popUrl = "/answerUpdate?a_id=" + a_id + "&q_id=" + '${questionInfo.q_id}' + "&member_id=" + '${member.id}';
			 
			 /* 리뷰 수정 팝업창에 관한 설정 값을 대입 */
			 let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"	
			 window.open(popUrl,"답변 수정",popOption);
		 }); 
		
		 /* 답변 삭제 버튼 */
		 $(document).on('click', '.delete_reply_btn', function(e){
			/* 접근 한 태그의 클릭 이벤트로 인해 발생하는 기본적인 동작을 막기 위해 preventDefault()를 호출 */
			 e.preventDefault();
			
			/* 삭제 버튼 태그의 href 속성에 저장해둔 a_id 값을 새로 변수를 선언하여 대입 */
			 let a_id = $(this).attr("href");
			
			/* ajax를 사용해서 리뷰 삭제를 서버에 요청 */
			 $.ajax({
					data : {
						a_id : a_id,
						q_id : '${questionInfo.q_id}'
					},
					url : '/answer/delete',
					type : 'POST',
					success : function(result){
						/* 서버가 요청을 정상적으로 처리했을 때 동작하는 succes속성 값 함수에 리뷰를 최신화하는 메서드인 replyListInit() 메서드를 호출하고 
						회원이 작성한 리뷰가 정상적으로 삭제되었음을 알 수 있는 경고창을 뛰우도록 코드를 작성 */
						answerListInit();
						alert('삭제가 완료되었습니다.');
					}
				});
				
		 });
		 
		/* 리뷰 리스트 출력 */
		const q_id = '${questionInfo.q_id}';	

		
		/* getJSON 메서드의 파라미터 
		- 첫 번째 파라미터 : 요청 URL

		- 두 번째 파라미터 : 서버에 전송할 데이터

		- 세 번째 파라미터 : 서버로부터 응답을 성공했을 때 동작할 코드
		
		 */
		$.getJSON("/answer/list", {q_id : q_id}, function(obj) {
			
			makeAnswerContent(obj);
			
		});
		
		/* 답변 동적 생성 메서드 */
		function makeAnswerContent(obj){
				/* 리뷰가 없는 경우
				list프로퍼티의 값에 아무 데이터가 없을 경우 댓글이 없는 경우이기 때문에 ". length"속성을 사용하여 데이터가 있는지 없는지를 판단
			*/
			if(obj.list.length === 0){
				$(".reply_not_div").html('<span> 등록된 답변이 없습니다.</span>');
				$(".reply_content_ul").html('');
				$(".pageMaker").html('');
			} else {
				$(".reply_not_div").html('');
				const list = obj.list;
				const pf = obj.pageInfo;
				const userId = '${member.id}';	
				
				/* list */
				let reply_list = '';
				
				/* 변수  list에 담긴 데이터들은 List<AnswerDTO>가 JSON형식으로 변한 것이기 때문에 
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
					reply_list += '<span class="date_span">'+ obj.a_create_date +'</span>';
					
					if(obj.member_id === userId){
						reply_list += '<a class="update_reply_btn" href="'+ obj.a_id +'">수정</a><a class="delete_reply_btn" href="'+ obj.a_id +'">삭제</a>';
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
