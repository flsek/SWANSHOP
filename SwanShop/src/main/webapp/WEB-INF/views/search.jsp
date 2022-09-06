<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>	
	<meta charset="UTF-8">
	<!-- Boxicons CDN Link -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${path}/resources/css/search.css" rel="stylesheet"/>
<title>Search</title>
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
    top: 200px;">
		<div class="content_area">
					<c:if test="${listcheck != 'empty' }">
					<div class="list_search_result">
					<table class="type_list">
						<colgroup>
							<col width="250px">
							<col width="700px">
							<col width="150px">
							<col width="150px">
						</colgroup>
						<tbody id="searchList">
						<c:forEach items="${list}" var="list">
							<!-- single product -->
							<tr>
									<td class="image">
										<div class="image_wrap" data-product_id="${list.imageList[0].product_id}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
											<img>
										</div>										
									</td>
									<td class="detail">
										<div class="category">
											[${list.kind_name}]
										</div>
										<div class="title">
											<a href="/product_detail/${list.product_id}">
												${list.product_title}
											</a>
										</div>
									</td>
									<td class="info">
										<div class="rating">
											평점: ${list.ratingavg}
										</div>
									</td>
									<td class="price">
										<div class="sell_price">
											<strong>
												<fmt:formatNumber value="${list.product_price}" pattern="#,### 원" />
											</strong>
										</div>
									</td>
								</tr>
						</c:forEach>
				</tbody>
					</table>
					</div>
					</c:if>
				
	<form id="moveForm" action="/search" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		<input type="hidden" name="type" value="G">
	</form>
	<!-- 상품 리스트 X -->
	<c:if test="${listCheck == 'empty'}">
		<div class="table_empty">검색된 상품이 없습니다.</div>
	</c:if>
	</div>
	</div>
	<script>
		const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
		if(selectedType != ""){
			$("select[name='type']").val(selectedType).attr("selected", "selected");	
		}
		$(document)
				.ready(
						function() {

							/* 이미지 삽입 */
							$(".image_wrap")
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

													const fileCallPath = encodeURIComponent(uploadPath
															+ "/s_"
															+ uuid
															+ "_" + fileName);

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
	</script>
</body>
</html>