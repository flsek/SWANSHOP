<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${path}/resources/css/mypage/mypage.css" rel="stylesheet"/>
	<title>내 정보 보기</title>
	<style type="text/css">
	/* 유효성 검사 문구 */
	.final_pw_ck{
	    display: none;
	}
	</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div class="container">
		<div class="topic">마이페이지</div>
		<div class="content">
			<input type="radio" name="slider" checked id="info"> 
			<input type="radio" name="slider" id="modify"> 
			<input type="radio" name="slider" id="pass"> 
			<input type="radio" name="slider" id="delete"> 
			<div class="list">
				<label for="info" class="info"> 
					<i class="fa fa-info-circle" aria-hidden="true"></i>
					<span class="title">내 정보 보기</span>
				</label> 
				<label for="modify" class="modify"> 
					<span class="icon">
						<i class="fa fa-pen" aria-hidden="true"></i>
					</span> 
					<span class="title">내 정보 수정</span>
				</label> 
				<label for="pass" class="pass"> 
					<span class="icon">
						<i class="fa fa-unlock-alt" aria-hidden="true"></i>
					</span> 
					<span class="title">비밀번호 변경</span>
				</label> 
				<label for="delete" class="delete"> 
					<span class="icon">
						<i class="fa fa-minus-circle" aria-hidden="true"></i>
					</span> 
					<span class="title">회원 탈퇴</span>
				</label> 
				
				<div class="slider"></div>
			</div>
			<div class="text-content2">
				<div class="info text">
					<div class="title">'${ member.name }'님의 상세 정보</div>
					<p>
						아이디 : ${ member.id }<br><br>
						이름 : ${ member.name }<br><br>
						성별 : <c:if test="${ member.gender eq 'M' }">
								남자								
							</c:if>
							<c:if test="${ member.gender eq 'F' }">
								여자							
							</c:if>
							<c:if test="${ member.gender eq 'N' }">
								선택X								
							</c:if><br><br>
						이메일 : ${ member.email }<br><br>
						전화번호 : ${ member.phone }<br><br>
						주소 : ${ member.address }<br><br>
						상세 주소 : ${ member.address2 }
					</p>
				</div>
				<script>
					/* 수정 성공 이벤트 */
					let modify_result = '${modify_result}'
					if(modify_result == 1){
						alert("회원 정보 수정 완료");
					}
					
					/* 비밀번호 변경 이벤트 */
					let updatePwd = '${updatePwd}'
					if(updatePwd == 1){
						alert("비밀번호 수정 완료");
					}
				</script>
				
				<div class="modify text">
					<div class="title">'${ member.name }'님의 정보 수정</div>
					<form method="post" action="/member/updateMember" class="visibility" id="modifyForm">
						<p>
							아이디 : ${ member.id }<input type="hidden" name="id" value="${ member.id }"><br>
							<br>이름 : <input type="text" name="name" value="${ member.name }"><br>
							<br><span class="gender-details">
								<c:if test="${ member.gender eq 'M'}">
						            <input type="radio" name="gender" id="dot-1" value="M" checked>
						            <input type="radio" name="gender" id="dot-2" value="F">
						            <input type="radio" name="gender" id="dot-3" value="N">
								</c:if>
								<c:if test="${ member.gender eq 'F'}">
						            <input type="radio" name="gender" id="dot-1" value="M">
						            <input type="radio" name="gender" id="dot-2" value="F" checked>
						            <input type="radio" name="gender" id="dot-3" value="N">
								</c:if>
								<c:if test="${ member.gender eq 'N'}">
						            <input type="radio" name="gender" id="dot-1" value="M">
						            <input type="radio" name="gender" id="dot-2" value="F">
						            <input type="radio" name="gender" id="dot-3" value="N"checked>
								</c:if>
			          			<span class="category">
					            	성별 :&nbsp;
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
			          			</span>
		        			</span><br>
							이메일 : <input type="email" name="email" value="${ member.email }"><br>
							<br>전화번호 : <input type="tel" name="phone" value="${ member.phone }"><br>
							<br>주소 : <input type="text" id="colFormLabelLg3" onclick="execPostCode();" name="address" value="${ member.address }"><br>
							<br>상세 주소 : <input type="text" name="address2" value="${ member.address2 }"><br><br>
						
						
							<input type="button" value="수정하기" class="btn" id="modifyBtn"> 
					</form>
				</div>
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
				   
				   /* 수정 버튼 */
				   $("#modifyBtn").on("click", function(e) {
						e.preventDefault();
						$("#modifyForm").submit();
					});
				   
				</script>
				<div class="pass text">
					<div class="title">비밀번호 변경</div>
					<form action="/member/updatePwd" method="post" id="updatePwdForm">						
						<p class="visibility underline">
							현재 비밀번호 : <input type="password" name="pwd"><br><br>
							새 비밀번호 : <input type="password" name="newPwd" id="newPwd"><br>
							<span id="warningPwd" style="color: red; font-size: 0.5rem;"></span><br>
							새 비밀번호 확인 : <input type="password" name="newPwd2" id="newPwdCheck"><br>
							<span id="warningCheckPwd" style="color: red; font-size: 0.5rem;"></span>
							<br><br>
							
							<i class="fa fa-unlock-alt" aria-hidden="true"></i>
							<input type="submit" value="변경하기" class="btn" id="updatePwd"> 
							
						</p>
					</form>
				</div>
				<script>
				 /* 비밀번호 변경 버튼 */
				   $("#updatePwd").on("click", function(e) {
					   if(newPwd.value.trim() !== newPwdCheck.value.trim()){
						   alert("비밀번호가 다릅니다. 다시 입력해주세요.");
				  			newPwd.value = ''
				  			newPwd.focus();
				  		}else if(newPwd.value.trim() === '' || newPwdCheck.value.trim() === ''){
				  			alert("비밀번호를 입력해주세요.")
				  		}else if(!pwdRegExp.test(checkNewPwd.value)){
				  			alert("영문, 숫자, 특수문자(~ ! @ # * 만 사용가능)를 포함한 8~16자에 맞게 입력해주세요.");
				  		}
				  		else{
						$("#updatePwdForm").submit();
						e.preventDefault();
					   }
					});
				 
				   	var newPwd = document.getElementById('newPwd');
				  	var checkNewPwd = document.getElementById('newPwdCheck');
				  	var warningPwd = document.getElementById('warningPwd');
				  	var warningCheckPwd = document.getElementById('warningCheckPwd');
				  	var pwdRegExp = /^[a-zA-Z0-9~!@#*]{8,16}$/;

				  	newPwd.onblur = function WriteNewPwd(){
				  		if(newPwd.value.trim() === ''){
				  			newPwd.focus();
				  			warningPwd.innerHTML = '새로운 비밀번호를 입력하세요.';
				  		}else{
				  			warningPwd.innerHTML = '';

				  			if(newPwd.value.trim() === checkNewPwd.value.trim()){
				  				warningCheckPwd.innerHTML = ''
				  			}else{
				  				warningCheckPwd.innerHTML = '새로운 비밀번호와 다릅니다.'
				  			}
				  		}
				  	}

				  	checkNewPwd.onfocus = function(){
				  		warningCheckPwd.innerHTML = '';

				  		if(newPwd.value.trim() === ''){
				  			this.blur();
				  			newPwd.focus();
				  			warningPwd.innerHTML = '새로운 비밀번호를 입력하세요.';
				  		}
				  	}

				  	checkNewPwd.onblur = function(){
				  		if(checkNewPwd.value.trim() === ''){
				  			warningCheckPwd.innerHTML = '새로운 비밀번호를 입력하세요.';
				  		}else{
				  			if(!pwdRegExp.test(checkNewPwd.value)){
				  				warningCheckPwd.innerHTML = '영문, 숫자, 특수문자(~ ! @ # * 만 사용가능)를 포함한 8~16자';
				  			}else{
								if(newPwd.value !== checkNewPwd.value){
				  					warningCheckPwd.innerHTML = '새로운 비밀번호와 다릅니다.';
				  				}else{
				  					warningCheckPwd.innerHTML = '';
				  				}
				  			}
				  		}
				  	}
				</script>
				
				<div class="delete text">
					<div class="title">회원 탈퇴</div>
					<form action="/member/deleteMember" method="post" class="visibility" id="deleteForm">
	                   	<p><span style="color: #99004d">SWAN</span> 웹사이트에서 회원님의 계정이 삭제됩니다.<br>탈퇴 시 개인정보 및 이용 정보가 삭제되며 복구할 수 없습니다.<br>본인의 비밀번호를 입력한 후 하단의 탈퇴하기를 눌러주세요.</p>
						<br>
                  		<div>
                     		<p>비밀번호 : <input type="password" id="pw" name="pwd" class="pwd"></p>
                     		<br>
                     		<span class="final_pw_ck" style="color: red; font-size: 12px;">비밀번호를 입력해주세요.</span>
                     		<br>
                     		<textarea readonly="readonly" rows="5" cols="70" style="width:350px;">시행 일자: 2022년 07월
제 1 조 목적
                        
이 약관은 주식회사 SWAN(이하 "회사")에서 제공하는 서비스에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.
                               
 제 2 조 약관의 게시와 효력, 개정
                        
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.
② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있습니다.
③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사 표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.
④ 회사는 서비스를 중단하거나 회원이 개인정보 제공 동의를 철회한 경우에는 신속하게 회원의 개인 정보를 파기합니다. 단, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련 법률에서 정하는 바에 따라 일정 정보는 보관할 수 있습니다.
⑤ 회사는 법률에 특별한 규정이 있는 경우를 제외하고는 회원의 별도 동의 없이 회원의 계정 정보를 포함한 일체의 개인 정보를 제3자에게 공개하거나 제공하지 아니합니다.</textarea>
                  	</div> 
                   		<input type="button" value="탈퇴하기" class="btn" id="deleteBtn">
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
	var pwdCheck = false;		// 비밀번호
	$(document).ready(function(){
	/* 탈퇴 버튼 */
	$("#deleteBtn").on("click", function(e) {
		var pwd = $('.pwd').val();			// 비밀번호 입력란
		
		/* 비밀번호 유효성 검사 */
		if(pwd == ""){
			$('.final_pw_ck').css('display', 'block');
			pwdCheck = false;
		} else {
			$('.final_pw_ck').css('display', 'none');
			pwdCheck = true;
		}
		
		/* 최종 유효성 검사 */
		if(pwdCheck){			
			$("#deleteForm").submit();
			alert("탈퇴가 완료되었습니다.");
		}
		
		});
	});
	</script>
</body>
</html>