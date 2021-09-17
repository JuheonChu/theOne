<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.project.vo.CrawlingVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/personList.css" rel="stylesheet" type="text/css">

<title>빽다방 전체 상품</title>
</head>
<body>
<%
	List<CrawlingVO> list = (List<CrawlingVO>) request.getAttribute("personList");
	
%>
	<header class="header">
		<%@ include file="./header.jsp"%>
	</header>

	<div id="pattern" class="pattern">
		<div>
			<h2 style="margin: 0 auto;">TOP 인재</h2>
		</div>
		<ul class="list img-list">
			<%
				for (int i = 0; i < list.size(); i++) {
			%>
			<li><a href="<%=list.get(i).getLink() %>" class="inner">
					<div class="li-img">
					<img
						src="${pageContext.request.contextPath}/resources/images/person.png"
						alt="Image Alt Text" width="50" height="50"/>
					</div>
					<div class="li-text">
						<h4 class="li-head"><%=list.get(i).getName()%> <%=list.get(i).getAge() %></h4>
						<p><%=list.get(i).getCareer() %></p>
						<strong><%=list.get(i).getTitle()%></strong>
					</div>
			</a></li>
			<%
				}
			%>
		</ul>
	</div>
	<footer id="footer" class="footer">
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>