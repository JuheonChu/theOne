<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.StudyVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
border-collapse: collapse;
}

tr,td {
    border: 1px solid black;
    text-align:center;
}
</style>
</head>
<body>
<%
	ArrayList<StudyVO> list = (ArrayList<StudyVO>)request.getAttribute("menu");
%>
<table>
	<tr>
		<td>제목</td>
		<td><%=list.get(0).getTitle() %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=list.get(0).getContent()%></td>
	</tr>
	<tr>
		<td>날짜</td>
		<td><%=list.get(0).getDate() %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%=list.get(0).getHitcount()%></td>
	</tr>
	<tr>
		<td>파일명</td>
		<td><a href="download?filename=<%=list.get(0).getUrl()%>"><%=list.get(0).getUrl()%></a></td>
	</tr>
</table>
</body>
</html>