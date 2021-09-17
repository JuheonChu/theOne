<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">


<html>
<head>
<title>The One 로그인</title>
<%
	if ("loginFail".equals((String) request.getAttribute("loginFail"))) {
%>
<script>
	alert("잘못된 정보입니다!")
</script>
<%
	}
%>
<style>
.loginForm {
	text-align: center;
	line-height: normal;
	vertical-align: top;
	background-image:
		url("https://www.google.com/imgres?imgurl=https%3A%2F%2Fdatahack-prod.s3.ap-south-1.amazonaws.com%2Fteam_logo%2Flogo_qtHydxx.png&imgrefurl=https%3A%2F%2Fdatahack.analyticsvidhya.com%2Fteams%2Ftheone&tbnid=1Hfivb2Rsmw4NM&vet=12ahUKEwi468j1gKPsAhURgpQKHWlkBTMQMyhNegQIARBj..i&docid=0fZWwiXnoPcDJM&w=387&h=316&q=THEONE&ved=2ahUKEwi468j1gKPsAhURgpQKHWlkBTMQMyhNegQIARBj");
}
body{
	text-align:center;
}
img{
width:210px;
}
</style>
<script>
	
</script>
</head>
<body>
<%
	if(request.getAttribute("signupcomplete")!=null){
%>
	<script>alert("회원가입이 완료되었습니다!");</script>
<%		
	}
%>
	<a href="${pageContext.request.contextPath}/headquarter/"> 
		<img src="${pageContext.request.contextPath}/resources/images/The One -logo (1).png" />
	</a>
	<div class="loginForm">
		<form action="${pageContext.request.contextPath}/member/loginAction.do"
			name='frm' onsubmit="return confirm('로그인 하시겠습니까?')" method="post">
			
			ID: <input type="text" name="id" /><br />
			<br /> PW: <input type="password" name="password" /><br />
			<br /> <input type="button" class="btn btn-primary" value="회원가입"
				onclick="location.href='${pageContext.request.contextPath}/member/signup.do'" />
			<input type="submit" class="btn btn-success" value="로그인" /> <input
				type="button" class="btn btn-primary" value="ID 찾기"
				onclick="location.href ='${pageContext.request.contextPath}/member/idfind'" />
			<input type="button" class="btn btn-primary" value="PW 찾기"
				onclick="location.href ='${pageContext.request.contextPath}/member/pwfind'" />
			<div style="margin-top: 15px;">
				<a
					href="https://kauth.kakao.com/oauth/authorize?client_id=0071bab4e0ba935cefd3166f7c763591&redirect_uri=http://192.168.6.118:8080/member/kakaoLogin&response_type=code">
					<img
					src="${pageContext.request.contextPath}/resources/images/kakao_login_button.png"
					width="280" height="60" />
				</a>
			</div>
			<div id="naver_id_login" style="margin-top: 15px;">
				<a href="${url }"> <img
					src="${pageContext.request.contextPath}/resources/images/naver_login_button.png"
					width="280" height="60" />
				</a>
			</div>
		</form>

	</div>
</body>
</html>