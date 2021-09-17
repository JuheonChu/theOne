<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "com.project.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한신포차</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<%
	TempVO mymymymymymyown = (TempVO)session.getAttribute("mymymymymymyown"); 
	String myAddr = mymymymymymyown.getAddress();
	if(mymymymymymyown.getDetailaddress()!=null){
		myAddr += " " + mymymymymymyown.getDetailaddress();
	}
%>
<body>



	<div class="footer_wrap">
		<div class="footer">
			<h1 class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/hanshin/logo.png"/>
			</h1>
			<div style = "position:relative; bottom:-0px;">
				<p>
					<span class="txt">(주)더원코리아</span><span class="bar">|</span><span
						class="txt">사업자등록번호 <%=mymymymymymyown.getPhone() %></span><span class="bar">|</span><span
						class="txt">대표이사 <%=mymymymymymyown.getName() %></span> <br>
					<span class="txt">주소: <%=myAddr%></span><span
						class="bar">|</span><span class="txt">팩스: 02-511-3864</span> <br>
					<span class="txt">본사 대표전화 및 가맹상담전화 : 02-313-0819</span><span
						class="bar">|</span><span class="txt">한신포차 가맹상담전화k:
						 02-313-0819</span><span class="bar">|</span><span class="txt">고객센터:
						1544-0302</span>
				</p>
				<p>COPYRIGHTⓒ 2017 THEBORN KOREA INC. ALL RIGHTS RESERVED</p>
			</div>
		</div>
	</div>

</body>
</html>