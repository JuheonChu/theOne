<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "com.project.vo.*" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<% MemberVO franchisemember = (MemberVO)request.getAttribute("franchisemember");
   TempVO franchise = (TempVO)request.getAttribute("hq");
   String [] choosemenu = franchise.getSelectmenu().split("_");
  String password = (String)request.getAttribute("password");

	String detailAddr = "a";
	if(franchise.getDetailaddress()==null){
		detailAddr = "";
	}
   
  %>
<body>
<table class = "table" style = "font-size:10px;">
	<tr>
		<td>가맹점 계정</td>
		<td>가맹점 비밀번호</td>
		<th>브랜드</th>
		<th>가맹점</th><!-- location -->
		<th>점주</th>
		<th>점주 연락처</th>
		<th>점주님께서 선택하신 메뉴</th>
		<th>가맹점 주소</th>
		<th>가맹점 우편번호</th><!-- post code -->
		<th>가맹점 창업 승인날짜</th>
		<th>가맹점 사이트</th>
	</tr>
	
	<tr>
		<td><%=franchisemember.getId() %></td>
		<td>${password}</td>
		<td><%= franchise.getBrand() %></td>
		<td><%= franchise.getLocation() %></td>
		<td><%= franchise.getName() %></td>
		<td><%= franchise.getPhone() %>/<%=franchise.getEmail() %></td>
		<td>
			<%for(int i = 0; i < choosemenu.length;i++){
				%>
				<%=choosemenu[i]+ " " %>	
			<% }%>
		</td>
		<td><%= franchise.getAddress() + " " + detailAddr%></td>
		<td><%= franchise.getPostcode() %></td>
		<td><%= franchise.getDate()%></td>
		<td><%= franchise.getUrl()%></td>
	</tr>
</table>

<input type = "button" value = "뒤로가기" onclick = "javascript:history.go(-1);">
</body>
</html>