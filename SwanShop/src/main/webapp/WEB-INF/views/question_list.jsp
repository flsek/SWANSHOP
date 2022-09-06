<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>문의사항 목록</title>
	<link href="${path}/resources/css/questions/questionList.css" rel="stylesheet"/>
</head>
<body>
	<jsp:include page="common/header.jsp"/>
	<div id="mainWrapper">
		<!-- 게시판 제목 -->
		<h1>문의 사항</h1>
		<ul>
			<!-- 게시판 목록  -->
			<li>
				<ul id="ulTable">
					<li>
						<ul>
							<li>No</li>
							<li>제목</li>
							<li>작성일</li>
							<li>작성자</li>
							<li>조회수</li>
						</ul>
					</li>
					<!-- 게시물이 출력될 영역 -->
					<li>
					<c:if test="${listcheck != 'empty' }">
							<c:forEach var="q" items="${ list }">
							<ul class="contentUl">
									<li><c:out value="${ q.q_id }"/></li>
									<li><a class="move" href='<c:out value="${q.q_id}"/>'><c:out value="${ q.q_title }"/></a></li>
									<li><c:out value="${ q.q_modify_date }"/></li>
									<li><c:out value="${ q.q_writer }"/></li>
									<li><c:out value="${ q.q_count }"/></li>
							</ul>
							</c:forEach>
						</c:if>
						<c:if test="${listCheck == 'empty'}">
							<div>검색된 문의사항이 없습니다.</div>
						</c:if>
					</li>
					<li>
					</li>
				</ul>
			</li>
			</ul>
			
			<!-- 게시판 페이징 영역 -->
			<form id="moveForm" action="/question_list" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			</form>
			<!-- 페이지 이름 인터페이스 영역 -->
			<div class="pageMaker_wrap">
				<ul class="pageMaker">

					<!-- 이전 버튼 -->
					<c:if test="${pageMaker.prev }">
						<li class="pageMaker_btn prev"><a
							href="${pageMaker.pageStart -1}">이전</a></li>
					</c:if>

					<!-- 페이지 번호 -->
					<c:forEach begin="${pageMaker.pageStart }"
						end="${pageMaker.pageEnd }" var="num">
						<li
							class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${pageMaker.next}">
						<li class="pageMaker_btn next"><a
							href="${pageMaker.pageEnd + 1 }">다음</a></li>
					</c:if>
				</ul>
			</div>
			
			<!-- 검색 영역 -->
			<div class="search_wrap">
				<form id="searchForm2" action="/question_list" method="get">
					<div class="search_input">
						<input type="text" name="keyword"
							value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
						<input type="hidden" name="pageNum"
							value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
						<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
						<button class='btn search_btn'><i class="fas fa-search"></i></button>
					</div>
				</form>
						<div class="button">
							<a href="/questionEnroll">작성하기</a>
						</div>
			</div>
			
		</div>
	<script>
	
	$(document).ready(function() {

		/* 수정 성공 이벤트 */
		let modify_result = '${modify_result}';
		
		if(modify_result == 1){
			alert("수정 완료");
		}

		/* 삭제 결과 경고창 */
		let delete_result = '${delete_result}';
		
		if(delete_result == 1){
			alert("삭제 완료");
		}
	});
		let searchForm2 = $('#searchForm2');
		let moveForm = $('#moveForm');
	
		/* 검색 버튼 동작 */
		$("#searchForm2 button").on("click", function(e) {
	
			e.preventDefault();
	
			searchForm2.find("input[name='pageNum']").val("1");
	
			searchForm2.submit();
	
		});
	
		/* 페이지 이동 버튼 */
		$(".pageMaker_btn a").on("click", function(e) {

			e.preventDefault();

			moveForm.find("input[name='pageNum']").val($(this).attr("href"));

			moveForm.submit();

		});
	
		/* 문의사항 조회 페이지 */
		
		$(".move").on(
				"click",
				function(e) {

					e.preventDefault();

					moveForm.append("<input type='hidden' name='q_id' value='"
							+ $(this).attr("href") + "'>");
					moveForm.attr("action", "/question_detail");
					moveForm.submit();

				});
	</script>
</body>
</html>