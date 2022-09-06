<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="${path}/resources/css/login/signup.css" rel="stylesheet"/>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<main>	
		<div class="container">
			<div class="title">
				<a href="/swan">SWAN</a>
			</div>
			<div class="content">
				<form id="join_form" method="post">
					<div class="user-details">
						<div class="input-box">
							<span class="details">아이디</span>
							<input type="text" name="id" id="userId" placeholder="&nbsp;6~16자 영문, 숫자" class="id_input" required>
							<span class="id_input_re_1 ">사용 가능한 아이디입니다.</span>
							<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
							<span class="final_id_ck" style="color: red;">아이디를 입력해주세요.</span>
						</div>
						<div class="input-box">
							<span class="details">이름</span> 
							<input type="text" name="name" required class="user_input">
							<span class="final_name_ck" style="color: red;">이름을 입력해주세요.</span>
						</div>
						
						<div class="input-box mail_wrap">
							<span class="details mail_name">이메일</span>
							<input type="text" name="email" class="mail_input" placeholder="이메일 입력" required style="width: 70%;">
							<div class="mail_check_button" style="float: right;">
								<span>인증번호 전송</span>
							</div>
							<span class="final_mail_ck" style="color: red;">이메일을 입력해주세요.</span>
							<span class="mail_input_box_warn"></span>
						</div>
							<div class="input-box mail_check_input_box" id="mail_check_input_box_false">
								<span class="details">인증번호 확인</span>
								<input class="mail_check_input" disabled="disabled" placeholder="인증번호 입력">
								<div class="clearfix"></div>
								<span id="mail_check_input_box_warn"></span>
							</div>
						
						<div class="input-box">
							<span class="details">전화번호</span> 
							<input type="tel" name="phone" placeholder="&nbsp;Phone" required class="phone_input">
							<span class="final_phone_ck" style="color: red;">전화번호를 입력해주세요.</span>
						</div>
						<div class="input-box">
							<span class="details">비밀번호</span>
							<input type="password" name="pwd" placeholder="&nbsp;영문, 숫자, 특수문자 8~16자" class="pwd" id="password_1" required style="width: 47%; margin-right: 4%;">
							<input type="password" name="pwd2" placeholder="&nbsp;비밀번호 재확인" class="pwd" id="password_2" required style="width: 47%;">
							<span id="alert-success" style="display: none; color : green;">비밀번호가 일치합니다.</span>
                			<span id="alert-danger" style="display: none; color: red;">비밀번호가 일치하지 않습니다.</span>
                			<span class="final_pw_ck" style="color: red;">비밀번호를 입력해주세요.</span>
						</div>

						<div class="input-box">
							<span class="details">주소</span>
							<input id="colFormLabelLg3" onclick="execPostCode();" name="address" placeholder="주소를 입력하세요." required class="address_input1">
							<span class="final_addr_ck" style="color: red;">주소를 입력해주세요.</span>
						</div>
						<div class="input-box">
							<span class="details">상세 주소</span>
							<input required name="address2" class="address_input2" placeholder="상세 주소를 입력하세요.">
						</div>
					</div>
					<div class="gender-details">
			            <input type="radio" name="gender" id="dot-1" value="M">
			            <input type="radio" name="gender" id="dot-2" value="F">
			            <input type="radio" name="gender" id="dot-3" value="N">
			            <span class="gender-title">성별</span>
          				<div class="category">
				            <label for="dot-1">
				            	<span class="dot one"></span>
				            	<span class="gender">남자</span>
				          </label>
				          <label for="dot-2">
				            	<span class="dot two"></span>
				            	<span class="gender">여자</span>
				          </label>
				          <label for="dot-3">
				            	<span class="dot three"></span>
				            	<span class="gender">선택X</span>
				           </label>
          				</div>
        			</div>
					<div class="button">
						<input type="button" value="회원가입" class="join_button">
					</div>
				</form>
			</div>
		</div>
	</main>
	<script>	
	var idCheck = false;			// 아이디
	var nameCheck = false;			// 이름
	var phoneCheck = false;			// 전화번호
	var mailCheck = false;			// 이메일
	var mailnumCheck = false;		// 이메일 인증번호 확인
	var pwdCheck = false;
	var addressCheck1 = false 		// 주소
	
		$(document).ready(function(){
			//회원가입 버튼(회원가입 기능 작동)
			$(".join_button").click(function(){
				
				/* 입력값 변수 */
				var id = $('.id_input').val();				// 아이디 입력란
				var name = $('.user_input').val();			// 이름 입력란
				var phone = $('.phone_input').val();		// 전화번호 입력란
				var mail = $('.mail_input').val();			// 이메일 입력란
				var address1 = $('.address_input1').val();		// 주소 입력란
				var pwd = $('.pwd').val();			// 비밀번호 입력란
				
				/* 아이디 유효성 검사 */
				if(id == ""){
					$(".final_id_ck").css('display', 'block');
					idCheck = false;
				} else {
					$('.final_id_ck').css('display', 'none');
					idCheck = true;
				}
				
				/* 이름 유효성 검사 */
				if(name == ""){
					$(".final_name_ck").css('display', 'block');
					nameCheck = false;
				} else {
					$('.final_name_ck').css('display', 'block');
					nameCheck = true;
				}
				
				/* 비밀번호 유효성 검사 */
				if(pwd == ""){
					$('.final_pw_ck').css('display', 'block');
					pwdCheck = false;
				} else {
					$('.final_pw_ck').css('display', 'none');
					pwdCheck = true;
				}
				
				/* 이메일 유효성 검사 */
				if(mail == ""){
					$('.final_mail_ck').css('display','block');
					mailCheck = false;
				}else{
					$('.final_mail_ck').css('display', 'none');
					mailCheck = true;
				}
				
				/* 전화번호 유효성 검사 */
				if(phone == ""){
					$('.final_phone_ck').css('display','block');
					phoneCheck = false;
				}else{
					$('.final_phone_ck').css('display', 'none');
					phoneCheck = true;
				}
				
				/* 주소 유효성 검사 */
				if(address1 == ""){
					$('.final_addr_ck').css('display','block');
					addressCheck1 = false;
				}else{
					$('.final_addr_ck').css('display', 'none');
					addressCheck1 = true;
				}
				
				/* 최종 유효성 검사 */
				if(idCheck&&nameCheck&&mailCheck&&pwdCheck&&phoneCheck&&addressCheck1){					
					$("#join_form").attr("action", "/member/join");
					$("#join_form").submit();
				}
				
			});
		});
	
	var code = "";                //이메일전송 인증번호 저장위한 코드
	
	/* 인증번호 이메일 전송 */
	$(".mail_check_button").click(function(){
		var email = $(".mail_input").val();        // 입력한 이메일
		var checkBox = $(".mail_check_input");        // 인증번호 입력란
	    var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
		$.ajax({
	        
	        type:"GET",
	        url:"mailCheck?email=" + email,
	        success:function(data){
	        	// console.log("data : " + data);
	        	checkBox.attr("disabled",false);
	        	boxWrap.attr("id", "mail_check_input_box_true");
	        	code = data;
	        }
	                
	    });
	});
	/* 인증번호 비교 */
	$(".mail_check_input").blur(function(){
		var inputCode = $(".mail_check_input").val();        // 입력코드    
	    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과
	    if(inputCode == code){                            // 일치할 경우
	        checkResult.html("인증번호가 일치합니다.");
	        checkResult.attr("class", "correct");        
	    } else {                                            // 일치하지 않을 경우
	        checkResult.html("인증번호를 다시 확인해주세요.");
	        checkResult.attr("class", "incorrect");
	    }
	});
	
	<!-- id 중복 검사 -->
		//아이디 중복검사
		$('.id_input').on("propertychange change keyup paste input", function(){
	/* 		console.log("keyup 테스트");	 */
		 	var id = $('.id_input').val();			// .id_input에 입력되는 값
			var data = {id : id};							// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
			
			$.ajax({
				type : "post",
				url : "/member/memberIdChk",
				data : data,
				success : function(result){
					 //console.log("성공 여부" + result);
					if(result != 'fail'){
						$('.id_input_re_1').css("display","inline-block");
						$('.id_input_re_2').css("display", "none");				
					} else {
						$('.id_input_re_2').css("display","inline-block");
						$('.id_input_re_1').css("display", "none");				
					} 
				}// success 종료
			}); // ajax 종료
	
		});// function 종료
		
		 
		/* 비밀번호 확인 일치 유효성 검사 */
		$('.pwd').focusout(function () {     
			var pwd1 = $('#password_1').val();
		    var pwd2 = $('#password_2').val();
		    if ( pwd1 != '' && pwd2 == '' ) {
	            null;
	        } else if (pwd1 != "" || pwd2 != "") {
	            if (pwd1 == pwd2) {
	                $("#alert-success").css('display', 'inline-block');
	                $("#alert-danger").css('display', 'none');
	            } else {
	                $("#alert-success").css('display', 'none');
	                $("#alert-danger").css('display', 'inline-block');
	            }
	        }
	    });
	</script>

	<!-- 주소 API 가져오기 -->
	<script src=http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false></script>
	<script>   
	   function execPostCode() {
	      daum.postcode.load(function() {
	         new daum.Postcode({
	            oncomplete : function(data) {
	               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	               
	               // 각 주소의 노출 규칙에 따라 주소를 조합
	               // 내려오는 변수가 값이 없을 땐 공백('')값을 가지므로, 이를 참고
	               var addr = ''; // 주소 변수
	               
	               // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴
	               if(data.userSelectedType == 'R'){
	                  // 사용자가 도로명 주소를 선택했을 경우
	                  addr = data.roadAddress;
	               } else {
	                  // 사용자가 지번 주소를 선택했을 경우
	                  addr = data.jibunAddress;
	               }
	               
	               // 주소 정보를 해당 필드에 넣음.
	               document.getElementById('colFormLabelLg3').value = addr;
	               
	               // 커서를 주소 필드로 이동
	               document.getElementById("colFormLabelLg3").focus();
	               
	            }
	         }).open();
	
	      });
	   }
	</script>

	</body>
</html>