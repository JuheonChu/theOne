<%@page import="com.project.vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
body{
	text-align:center;
}
</style>
<body>


<%
	ArrayList<MemberVO> list = (ArrayList<MemberVO>)request.getAttribute("list");
	if(list.size()==0){
		%>
		<script>alert("해당 id가 존재하지않습니다!");</script>
		<%
	}
	for(int i=0;i<list.size();i++){
%>
	<p><%=list.get(i).getId() %></p><br/>
<% } %>
<input type = "button" onclick = "javascript:history.back();" value = "뒤로가기"/>
</body>
</html>