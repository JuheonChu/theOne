<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.util.*" %>
<%@page import = "com.project.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>매장 찾기</title>
<style>
	table{
		border-collapse: collapse;
	}
	
	td{
		border:1px solid black;
	}
</style>
</head>
<%  List<TempVO> storelist = (List<TempVO>)request.getAttribute("storelist");
	MemberVO member = null;
	String tier = null;
	
	try{
		member = (MemberVO)session.getAttribute("loginMember");
		tier = member.getTier();
	}catch(Exception e){
		member = null;
		tier = "customer";
	}
	%>
<body>

<!--  이부분에서 검색을 구현할거임... -->
<div class="container">
	<div>
	  <form class="navbar-form">
	    <div class="input-group">
	     <div class="form-group navbar-left">
	      <select name="key" class="form-control">
		       <!-- selected="select" or selected -->
		       <option value="all" ${(pageObject.key == "all")? " selected ":"" }>전체</option>
		       <option value="brand" ${(pageObject.key == "brand")? " selected ":"" }>브랜드</option>
		       <option value="location" ${(pageObject.key == "location")? " selected ":"" }>지역</option>
		       <option value="name" ${(pageObject.key == "name")? " selected ":"" }>이름</option>
		       <option value="address" ${(pageObject.key == "address")? " selected ":"" }>주소</option>
	     </select>
	      <input type="text" class="form-control" placeholder="Search" name="word" value="${pageObject.word }">
	     </div>
	     <div class="input-group-btn">
	       <button class="btn btn-default" type="submit">
	         <i class="glyphicon glyphicon-search"></i>
	       </button>
	     </div>
	   </div>
	 </form>
	</div>
		
	<table class = "table">
		<tr>
			<th>브랜드</th>
			<th>지역</th>
			<th>매장명</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>작성 시간</th>
			<th>바로가기</th>
		</tr>
	<%for(int i = 0; i < storelist.size();i++){
		TempVO hq = storelist.get(i);%>
		<tr>
			<td><%=hq.getBrand() %></td>
			<td><%= hq.getLocation() %></td>
			<td><%=hq.getBrand() + "  " + hq.getLocation() %></td>
			<td><%= hq.getAddress() %></td>
			<td><%= hq.getPhone() %></td>
			<td><%=hq.getDate().substring(0,11) %></td>
			<td><a href= "<%=hq.getUrl()%>?franchisekey=<%=hq.getFranchisekey()%>&selectmenu=<%=hq.getSelectmenu()%>&tier=<%=tier%>">바로가기</a></td>
		</tr>
		
		<c:if test="${pageObject.totalPage > 1}">
				<tr>
					<td colspan="5">
						<pageNav:pageNav listURI="list" pageObject="${pageObject}"/>
					</td>
				</tr>
			</c:if>
	<%} %>
	</table>
</div>
</body>
</html>