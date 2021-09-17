<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.project.vo.ProductVO" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/paikdabang/itemlist.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<%
String key = (String)request.getAttribute("franchisekey");
%>
<header class = "header">
	<%@ include file="./header.jsp"%>
</header>

<div class="sub_section menu_wrap">
	<div class="container" style="height: 400px">
		<h1> 주문이 정상적으로 완료 되었습니다.</h1><br/>
		<h2>후기도 작성 부탁드립니다.</h2><br/>
		<button onclick="window.open('/product/survey?franchisekey=<%= key %>','지점평가','width=430,height=500')">후기작성</button>
		<button onclick='location.href="gotoindex"'>계속쇼핑하기</button>
	</div>
</div>

<footer id = "footer" class = "footer">
	<%@ include file = "./footer.jsp" %>
</footer>
</body>
</html>