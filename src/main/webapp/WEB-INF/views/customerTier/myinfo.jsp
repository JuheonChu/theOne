<%@page import="com.project.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signUp.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/signUp.js"></script>
</head>
<body>
<%
	MemberVO memberinfo = (MemberVO)request.getAttribute("memberinfo"); 

	if(request.getAttribute("success") != null){
	%>
	<script>alert("정보수정이 완료되었습니다!!");</script>
	<%}%>
<header class = "header">
	<%@ include file="../header.jsp"%>
</header>

<div class="container">
	<fieldset>
		<legend>회원정보수정</legend>
			<form action="${pageContext.request.contextPath}/member/changeAction.do" method="post" id="signUpForm" enctype="multipart/form-data">
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" class="form-control" size="10" value="<%=memberinfo.getId()%>" readonly="<%=memberinfo.getId()%>"/>
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label>
				<input type="password" name="password" id="password" class="form-control" size="10" value="********"/> <br/>
				<div class="password regex"></div>
			</div>
			
			<div class="form-group">
				<label for="passwordCheck">비밀번호 확인</label>
				<input type="password" id="passwordCheck" class="form-control" size="10" value="********"/> <br/>
				<div class="passwordCheck regex"></div>
			</div>
			
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="email" name="email" id="email" class="form-control" size="10" value="<%=memberinfo.getEmail()%>"/> <br/>
			</div>
			<div class="email regex"></div>
			
			<div class="form-group">
				<label for="phone">전화번호</label>
				<input type="text" name="phone" id="phone" class="form-control" size="10" value="<%=memberinfo.getPhone()%>"/> <br/>
				<div class="phone regex"></div>
			</div>
			
			<div class="form-group">
				<label for="address">주소</label>
				<input type="text" id="postcode" placeholder="우편번호" name="postcode" class="form-control" size="5" style="width: 100px;" value="<%=memberinfo.getPostcode()%>">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br/>
				<input type="text" id="address" placeholder="주소" name="address" class="form-control" size="5" style="width: 350px;" value="<%=memberinfo.getAddress()%>"><br/>
				<input type="text" id="detailAddress" placeholder="상세주소" name="detailaddress" class="form-control" size="5" style="width: 350px;" value="<%=memberinfo.getDetailaddress()%>"><br/>
				
			</div>
			
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" name="name" id="name" class="form-control" size="10" value="<%=memberinfo.getName()%>"/> <br/>
			</div>
			
			<div class="form-group">
				<label for="id">이미지(선택)</label>
				<input type="file" name="multipart"/>
			</div>
			
			<input type="submit" class="btn btn-primary" value="수정"/>
			<input type="reset" value="다시입력" class="btn btn-warning" id="resignupbtn">
			<input type="button" value="취소" class="btn btn-danger" onclick="location.href='/headquarter'">
		</form>
	</fieldset>
</div>
</body>
</html>
