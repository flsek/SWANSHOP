<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
	<meta charset="UTF-8">
	<title>e-가이드북</title>
	<link href="${path}/resources/css/guidebook/guidebook.css" rel="stylesheet"/>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp" />
	</header>
	<main>
	
	<div class="gidebook-section">
		<div>
			<h2 class="gidebook-main-title">e-가이드북</h2>
			<p class="gidebook-title-ment">평소 헷갈렸던 지식들, 잘못된 상태로 퍼져 있는 정보들을
				바로잡아드립니다.</p>
			<ul style="list-style: none;">
				<li class="menu">
					<p style="margin-top: 15px;" class="gidebook-title">생리? 월경?</p>
					<ul class="hide">
						<p class="gidebook-content">생리는 ‘생리적인 현상’에서 따온 말로 배설을 떠올리게 한다.
							하지만 월경은 더러운 피도 아니고 배설과 같은 선상에 있는 현상이 아니기 때문에 부끄러운 생리현상이 아닌 월경이라고
							부르는 것이 바람직하다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">월경컵이란?</p>
					<ul class="hide">
						<p class="gidebook-content">컵 모양의 실리콘 재질의 생리컵을 질 안에 삽입하여 생리혈을
							받아내는 형태이다. 실리콘이나 고무로 만들어진 종 모양의 삽입형 생리대로 지속적으로 쓸 수 있다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">월경컵은 일회용이 아니어서 비위생적이다?</p>
					<ul class="hide">
						<p class="gidebook-content">월경컵은 질 속에 직접 손을 넣어 착용하거나 제거해야 하고,
							장기적으로 사용하므로 비위생적이라고 생각할 수 있다. 그러나 질 내부는 약산성을 유지하고 월경컵은 의료용 실리콘으로
							만들어 관리만 잘 해준다면 세균이 서식하기 어렵다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">월경컵은 질 내부를 막아서 통풍이 안 된다?</p>
					<ul class="hide">
						<p class="gidebook-content">질 내부는 내장 기관이고, 내장기관은 원래부터 통풍이 거의
							되지 않으며, 통풍을 해 줄 필요도 없는 공간이다. 그래서 통풍은 외음부에만 잘 해주면 된다. 오히려 외음부에
							생리혈이 묻지 않으므로, 일회용 생리대를 사용할 때보다 통풍이 더 잘 된다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">질은 여성청결제를 사용해 자주 씻어야 한다?</p>
					<ul class="hide">
						<p class="gidebook-content">질에서 분비되는 점액질의 분비물은 자정 작용 시스템의 일부로
							포궁 경부에 침입하는 세균을 막아내고, 이미 제 역할을 다 한 세균과 조직을 밖으로 배출하는 역할을 한다. 이처럼 질
							내부에서는 나름의 정교한 자정 시스템이 운영되고 있기 때문에 여성 청결제의 과도한 사용은 화학 물질과 환경호르몬의
							영향으로 질 건강을 위협할 수도 있기 때문에 남용보다는 깨끗한 물로 자주 씻고, 여성 청결제는 분비물이 많은 경우
							가끔 이용만 하는 정도가 좋다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">여성 청결제 vs 질 세정제</p>
					<ul class="hide">
						<p class="gidebook-content">여성 청결제는 외음부에 사용하는 세정제이며, 질 세정제는 질
							내부를 세정하는 세정제이다. 질 세정제의 경우 시중에서 구하기보다는 약국이나 병원 처방을 통해 사용하는 것이
							안전한다.</p>
					</ul>
				</li>
				<li class="menu">
					<p class="gidebook-title">월경컵의 권장 사용 나이가 있나요?</p>
					<ul class="hide">
						<p class="gidebook-content">초경이 시작되는 시기는 급격한 신체적 성장이 동반되는 시기로
							신체의 각 기관이 성장 중이라고 보아야한다. 더욱이 성장의 속도는 개인차가 있으므로 어느 시점에서 성장이 완료되었다고
							판단하기도 쉽지 않다. 특히나 체내에 삽입하여 사용하는 월경컵의 경우 불편함과 부담감이 클 뿐만 아니라 무리한 월경
							컵 사용으로 질 내막에 손상을 초래할 위험도 존재하기 때문에 이제 막 초경이 시작된 경우라면 면 생리대가 더
							안전하다.</p>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	</main>
	<script>
		$(document).ready(function() {
			$(".menu>p").click(function() {
				$(this).next("ul").toggleClass("hide");
			});
		});
	</script>
</body>
</html>