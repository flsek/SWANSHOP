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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<title>Admin</title>
<link href="${path}/resources/css/admin_css.css" rel="stylesheet" />
<link href="${path}/resources/css/orderList.css" rel="stylesheet" />
</head>
<body>
	<div class="sidebar">
		<div class="logo-details">
			<i class='bx bxl-c-plus-plus'></i> <span class="logo_name">SWAN</span>
		</div>
		<ul class="nav-links">
			<li><a href="/swan"> <i class='bx bx-grid-alt'></i> <span
					class="links_name">HOME</span>
			</a></li>
			<li><a href="/admin/admin" class="active"> <i
					class='bx bx-box'></i> <span class="links_name">상품 관리</span>
			</a></li>
			<li><a href="/admin/orderList"> <i class='bx bx-list-ul'></i>
					<span class="links_name">주문 관리</span>
			</a></li>
			<li><a href="/admin/adminMember"> <i
					class='bx bx-pie-chart-alt-2'></i> <span class="links_name">회원
						관리</span>
			</a></li>
			<li><a href="/admin/adminQuestion"> <i
					class='bx bx-coin-stack'></i> <span class="links_name">문의사항
						관리</span>
			</a></li>
			<li class="log_out"><a href="/member/logout.me"> <i
					class='bx bx-log-out'></i> <span class="links_name">로그아웃</span>
			</a></li>
		</ul>
	</div>
	<section class="home-section">
		<nav>
			<div class="sidebar-button">
				<i class='bx bx-menu sidebarBtn'></i> <span class="dashboard">상품
					관리</span>
			</div>
		</nav>

		<div class="home-content">
			<table class="order_table">
				<colgroup>
					<col width="10%">
					<col width="20%">
					<col width="40%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<td class="th_column_1">번호</td>
						<td class="th_column_2">카테고리 명</td>
						<td class="th_column_3">상품 명</td>
						<td class="th_column_4">상품 수량</td>
					</tr>
				</thead>
				<c:if test="${listcheck != 'empty' }">
					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.product_id}" /></td>
							<td><c:out value="${list.kind_name}" /></td>
							<td><a class="move"
								href='<c:out value="${list.product_id}"/>'> <c:out
										value="${list.product_title}" />

							</a></td>
							<td><c:out value="${list.product_stock}" /></td>
						</tr>


					</c:forEach>
				</c:if>
			</table>
			<form id="moveForm" action="/admin/admin" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			</form>
			<!-- 검색 영역 -->
			<div class="search_wrap">
				<form id="searchForm" action="/admin/admin" method="get">
					<div class="search_input">
						<input type="text" name="keyword"
							value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
						<input type="hidden" name="pageNum"
							value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
						<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
						<button class='btn search_btn'><i class="fas fa-search"></i></button>
					</div>
				</form>
			</div>
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
			<div class="button">
				<a href="/admin/insertProduct">상품 등록</a>
			</div>
		</div>
	</section>
	<script>
		$(document).ready(function() {
			/* 등록 성공 이벤트 */
			let eResult = '<c:out value="${enroll_result}"/>';
				
			checkResult(eResult);

			function checkResult(result) {

				if (result === '') {
					return;
				}

				alert("상품'" + eResult + "'을 등록하였습니다.");

			}
			
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
		

		let searchForm = $('#searchForm');
		let moveForm = $('#moveForm');

		/* 검색 버튼 동작 */
		$("#searchForm button").on("click", function(e) {

			e.preventDefault();

			/* 검색 키워드 유효성 검사 */
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하십시오");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");

			searchForm.submit();

		});

		/* 페이지 이동 버튼 */
		$(".pageMaker_btn a").on("click", function(e) {

			e.preventDefault();

			moveForm.find("input[name='pageNum']").val($(this).attr("href"));

			moveForm.submit();

		});

		/* 상품 조회 페이지 */
		$(".move")
				.on(
						"click",
						function(e) {

							e.preventDefault();

							moveForm
									.append("<input type='hidden' name='product_id' value='"
											+ $(this).attr("href") + "'>");
							moveForm.attr("action", "/admin/product_detail");
							moveForm.submit();

						});
	</script>



	<script>
		let sidebar = document.querySelector(".sidebar");
		let sidebarBtn = document.querySelector(".sidebarBtn");
		sidebarBtn.onclick = function() {
			sidebar.classList.toggle("active");
			if (sidebar.classList.contains("active")) {
				sidebarBtn.classList.replace("bx-menu", "bx-menu-alt-right");
			} else
				sidebarBtn.classList.replace("bx-menu-alt-right", "bx-menu");
		}
	</script>

</body>
</html>