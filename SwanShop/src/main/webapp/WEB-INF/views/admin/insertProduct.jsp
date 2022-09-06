<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
	<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<title>Admin</title>
	<link href="${path}/resources/css/admin_css.css" rel="stylesheet"/>
	<link href="${path}/resources/css/adminProduct.css" rel="stylesheet"/>
	<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>
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
			<li><a href="/admin/admin"> <i class='bx bx-box'></i> <span
					class="links_name">상품 관리</span>
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
					등록</span>
			</div>
		</nav>
		<form action="/admin/insertProduct" method="post" id="enrollForm">
			<div class="home-content">
				<div class="recent-sales box">
					<div class="container">
						<div class="content">
							<div class="user-details">
								<div class="input-box">
									<span class="details">상품 명</span> <input type="text"
										placeholder="Product's name" name="product_title" required>
										<span class="ck_warn productName_warn">상품 명을 입력해주세요.</span>
								</div>
								<div class="input-box">
									<span class="details">상품 가격</span> <input type="text"
										placeholder="Product's price" name="product_price" required>
										<span class="ck_warn productPrice_warn">상품 가격을 입력해주세요.</span>
								</div>
								<div class="input-box">
									<span class="details">상품 재고</span> <input type="text"
										placeholder="Product's stock" name="product_stock" required>
										<span class="ck_warn productStock_warn">상품 재고를 입력해주세요.</span>
								</div>
							</div>
							<div class="input-box bit">
								<span class="details">상품 설명</span>
								<textarea placeholder="About Product" name="product_content"
									required></textarea>
									<span class="ck_warn productIntro_warn">상품 소개를 입력해주세요.</span>
							</div>
							<div>
								<input type="file" class="upload-name" value="첨부파일" id ="fileItem"
									placeholder="첨부파일" name="uploadFile" accept=".gif, .jpg, .png">
									<div id="uploadResult">
									<!-- 
										<div id="result_card">
											<div class="imgDeleteBtn">x</div>
											<img src="/display?fileName=test.png">
										</div>
										 -->																		
									</div>
							</div>
							<br>
							<div class="form_section">
                    			<div class="input-box bit">
                    				<span class="details">상품 카테고리</span>
                    			</div>
                    			<div class="form_section_content">
                    				<div class="cate_wrap">
                    					<span>대분류</span>
                    					<select class="cate1">
                    						<option selected value="none">선택</option>
                    					</select>
                    				</div>
                    				<div class="cate_wrap">
                    					<span>중분류</span>
                    					<select class="cate2" name="kind_id">
                    						<option selected value="none">선택</option>
                    					</select>
                    				</div>
                    				<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>                  				                    				
                    			</div>
                    		</div>
							<div class="button">
								<input type="button" value="취소" id="cancelBtn" />
								<input type="button" value="상품 등록" id="enrollBtn" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>

	<script>
		/* $(document).ready(function(){
			console.log('${cateList}');
		}); */
		
		let enrollForm = $("#enrollForm")

		/* 취소 버튼 */
		$("#cancelBtn").click(function() {

			location.href = "/admin/admin"

		});

		/* 상품 등록 버튼 */
		$("#enrollBtn").on("click", function(e) {
			e.preventDefault();
			
			/* 체크 변수 */
			let productNameCk = false;
			let cateCodeCk = false;
			let priceCk = false;
			let stockCk = false;
			let introCk = false;
			
			/* 체크 대상 변수 */
			let productName = $("input[name='product_title']").val();
			let cateCode = $("select[name='kind_id']").val();
			let productPrice = $("input[name='product_price']").val();
			let productStock = $("input[name='product_stock']").val();
			let productIntro = $(".bit p").html();
			
			if(productName){
				$(".productName_warn").css('display','none');
				productNameCk = true;
			} else {
				$(".productName_warn").css('display','block');
				productNameCk = false;
			}
			
			if(cateCode != 'none'){
				$(".cateCode_warn").css('display','none');
				cateCodeCk = true;
			} else {
				$(".cateCode_warn").css('display','block');
				cateCodeCk = false;
			}	
			
			if(productPrice != 0){
				$(".productPrice_warn").css('display','none');
				priceCk = true;
			} else {
				$(".productPrice_warn").css('display','block');
				priceCk = false;
			}	
			
			if(productStock != 0){
				$(".productStock_warn").css('display','none');
				stockCk = true;
			} else {
				$(".productStock_warn").css('display','block');
				stockCk = false;
			}		
			
			if(productIntro != '<br data-cke-filler="true">'){
				$(".productIntro_warn").css('display','none');
				introCk = true;
			} else {
				$(".productIntro_warn").css('display','block');
				introCk = false;
			}	
			
			if(productNameCk && cateCodeCk && priceCk && stockCk && introCk){
				//alert('통과');
				enrollForm.submit();
			} else {
				return false;
			}

		});
		
		/* 카테고리 */
		let cateList = JSON.parse('${cateList}');
		let cate1Array = new Array();
		let cate2Array = new Array();
		
		let cate1Obj = new Object();
		let cate2Obj = new Object();
		
		let cateSelect1 = $(".cate1");		
		let cateSelect2 = $(".cate2");
		
		/* 카테고리 배열 초기화 메서드 */
		function makeCateArray(obj,array,cateList, tier){
			for(let i = 0; i < cateList.length; i++){
				if(cateList[i].tier === tier){
					obj = new Object();
					
					obj.kind_name = cateList[i].kind_name;
					obj.kind_id = cateList[i].kind_id;
					obj.cateparent = cateList[i].cateparent;
					
					array.push(obj);				
					
				}
			}
		}	
		
		/* 배열 초기화 */
		makeCateArray(cate1Obj,cate1Array,cateList,1);
		makeCateArray(cate2Obj,cate2Array,cateList,2);
		
		
		$(document).ready(function(){
			console.log(cate1Array);
			console.log(cate2Array);
		});
		
		
		/* 대분류 <option> 태그 */
		for(let i = 0; i < cate1Array.length; i++){
			cateSelect1.append("<option value='"+cate1Array[i].kind_id+"'>" + cate1Array[i].kind_name + "</option>");
		}
		
		
		/* 중분류 <option> 태그 */
		/*
			대분류 선택 값 가져오기
			=> 중분류 <option> 태그 모두 지우기
			=> 중분류 기본 <option> 태그 추가
			=> 대분류 선택 값과 일치하는 'cateparent'값을 가진 중분류 <option> 태그 출력
		*/
		
		$(cateSelect1).on("change",function(){
			/* 대분류 선택 값을 가져오는 코드를 추가 */
			let selectVal1 = $(this).find("option:selected").val();	
			
			/* 중분류 <option> 태그를 지우고 기본적인 <option> 태그를 추가하는 코드 */
			cateSelect2.children().remove();
			
			/* 대분류 선택 값과 일치하는 'cateparent'값을 가진 중분류 <option> 태그를 출력하는 코드 */
			cateSelect2.append("<option value='none'>선택</option>");
			
			for(let i = 0; i < cate2Array.length; i++){
				if(selectVal1 === cate2Array[i].cateparent){
					cateSelect2.append("<option value='"+cate2Array[i].kind_id+"'>" + cate2Array[i].kind_name + "</option>");	
				}
			}// for
			
		});
		
		/* 이미지 업로드 */
		$("input[type='file']").on("change", function(e){
			// alert("동작");
			
			/* 이미지 존재시 삭제 */
			if($(".imgDeleteBtn").length > 0){
				deleteFile();
			}
			
			// 첨부 파일을 서버로 전송하기 위해선 FormData 객체를 사용
			// <form> 태그와 같은 역할을 해주는 FormData객체를 생성하여 첨부파일을 FormData에 저장을 하고 FormData 자체를 서버로 전송
			let formData = new FormData();
			
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];
			
			if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			}
			
			// 사용자가 선택한 파일을 FormData에 "uploadFile"이란 이름(key)으로 추가해주는 코드
			formData.append("uploadFile", fileObj);
			
			// 사용자가 여러 개의 파일을 선택할 수 있게 하는 코드
			/* for(let i = 0; i < fileList.length; i++){
				formData.append("uploadFile", fileList[i]);
			} */
			
			// alert("통과");

			console.log("fileList : " + fileList);
			console.log("fileObj : " + fileObj);
			
			// 첨부파일 서버 전송
			// 주의: processData, 와 contenttype 속성의 값을 'false'로 해주어야만 첨부파일이 서버로 전송됨.
			
			/*
				 url : 서버로 요청을 보낼 url

				processData : 서버로 전송할 데이터를 queryStirng 형태로 변환할지 여부

				contentType : 서버로 전송되는 데이터의 content-type

				data : 서버로 전송할 데이터

				type : 서보 요청 타입(GET, POST)

				dataType : 서버로부터 반환받을 데이터 타입
				
				!! 뷰에서는 해당 객체 데이터가 JSON 타입으로 전달받아야만 해당 데이터를 활용 !!
			 */
			$.ajax({
				url : '/admin/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result){
		    		console.log(result);
		    		showUploadImage(result);
		    	},
		    	error : function(result){
		    		alert("이미지 파일이 아닙니다.");
		    	}
			});

		});

		/* 파일 체크(JavaScript) */
		let regex = new RegExp("(.*?)\.(jpg|png|PNG|JPG)$");
		let maxSize = 1048576; //1MB	

		function fileCheck(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (!regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}

			return true;

		}
		
		/* 이미지 출력 */
		function showUploadImage(uploadResultArr){
			/* 전달받은 데이터 검증 */
			if(!uploadResultArr || uploadResultArr.length == 0){return}
			
			/*  id 속성 uploadResult인 <div> 태그 요소에 쉽게 접근하기 위해 변수를 선언 및 초기화 */
			let uploadResult = $("#uploadResult");
			
			/* 한 개의 이미지 파일만 처리를 하기 때문에 이미지의 데이터(filename, path, uuid)에 쉽게 접근할 수 있도록 변수 obj를 선언하여 서버로부터 전달받은 배열 데이터의 첫 번째 요소로 초기화 */
			let obj = uploadResultArr[0];
			
			let str = "";
			
			/* 이미지 출력을 요청하는 url 매핑 메서드("/display")에 전달해줄 파일의 경로와 이름을 포함하는 값을 저장하기 위한 변수(변경 전) */
//			let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
			// 이미지 출력 url을 테스트할 때 파라미터 값의 구분자로서 '/'을 사용해주어야 정상적으로 출력됨. (변경 전)
//			let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
	
			
			//  encodeURIComponent() 메서드는 '/'와 '\'문자 또한 인코딩을 하기 때문에 replace() 메서드를 사용 안 해도 해당 URI로 동작
			// replace 적용 => 동작 o
//			let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
			// replace 적용 x => 동작 o
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			
			str += "<div id='result_card'>";
			str += "<img src='/display?fileName=" + fileCallPath +"'>";
			str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
			str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
			str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
			str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
			str += "</div>";
			
			/* 태그 코드가 담긴 문자열 값(str)을 uploadResult 태그에 append() 명령 혹은 html() 메서드를 호출하여 추가 */
			uploadResult.append(str); 
			
			/*
				url : 파일 삭제를 수행하는 url을 작성함.
	  			data : 객체 초기자를 활용하여 fileName 속성명에 targetFile(이미지 파일 경로) 속성 값을 부여했음. 
	  			서버의 메서드 파라미터에 String fileName을 선언하였기 때문에 스프링에서 해당 데이터를 매핑.
				type : 서버 요청 방식. 'POST'를 지정.
	 			dataType : 전송하는 targetFile은 문자 데이터이기 때문에 'text'를 지정.
	 			success : 성공할 경우 실행되는 속성
	 			error : 요청이 실패 혹은 에러일 경우 실행되는 속성
			*/
			
			/* 이미지 삭제 버튼 동작 */
			$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
				
				deleteFile();
				
			});
			
			/* 파일 삭제 메서드 */
			function deleteFile(){
				
				let targetFile = $(".imgDeleteBtn").data("file");
				
				let targetDiv = $("#result_card");
				
				$.ajax({
					url: '/admin/deleteFile',
					data : {fileName : targetFile},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						console.log(result);
						targetDiv.remove();
						$("input[type='file']").val("");
					},
					error : function(result){
						console.log(result);
						alert("파일을 삭제하지 못하였습니다.");
					}
		       });
			}
		}
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
		};

		$("#file").on('change', function() {
			var fileName = $("#file").val();
			$(".upload-name").val(fileName);
		});
	</script>
</body>
</html>