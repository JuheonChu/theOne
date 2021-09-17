<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- , 또는 날자 패턴을 넣을수 있는 태그 -->
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project.vo.StudyVO" %>
<!DOCTYPE html>
<html>
<head>
<%
	ArrayList<StudyVO> list = (ArrayList<StudyVO>)request.getAttribute("list");
%>
<meta charset="UTF-8">
 <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterAdmin.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>Insert title here</title>
<style type="text/css">

table.table{
	width: 80%;
	margin: 200px auto;
}

td.w{
	border:1px solid gray; 
	height: 70px;
	text-align: center;
}
th{
	text-align: center;
}
</style>
 <script type="text/javascript">
	$(function() {
		$('.content').click(function() {
			var title = $(this).children('.title').text();
			location.href="studycontent?menu="+title;
		});
	});
  </script>
</head>
<body>

<div class="sub_header sub_bg05">
			<div>
				<p class="company">THEONE</p>
				<p class="sub_tit">관리자페이지</p>
				
			</div>
</div>


<nav role="navigation" style="display: flex;">
  <ul id="main-menu">
    <li><a href="#">더원관리</a>
    	<ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/theonechart.do" aria-label="subemnu">기간별 매출</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/theonescore.do" aria-label="subemnu">지점별 평점</a></li>
      </ul>
    </li>
    
    <li><a href="#">창업지원</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/adminLaunchApproval.do" aria-label="subemnu">창업신청 승인</a></li>
      </ul>
    </li>
    
    <!-- 비대면강좌 서비스 -->
    <li><a href="">교육자료</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/Study/studyflist" aria-label="subemnu">더원 교육자료</a></li>
        <li><a href="${pageContext.request.contextPath}/Study/list" aria-label="subemnu">신메뉴 교육자료</a></li>
      </ul>
    </li>
    <li><a href="#">재고관리</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise" aria-label="subemnu">주문현황</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/addmenu" aria-label="subemnu">메뉴 추가구성</a></li>
      </ul>
    </li>
  </ul>
</nav>
<div style="width: 100%">
<div style="float:left; width: 15%; height: 1500px; background-color: #edece8;" >
		<table class="table table-bordered" >
			<tr >
				<td class="w" style="padding-top: 26px;"><a style="display: block" class="active" href="studyflist">더원교육</a></td>
			</tr>
			<tr >
				<td class="w" style="padding-top: 26px;"><a style="display: block" href="list">신메뉴교육</a></td>
			</tr>
		</table>
	</div>
	<div style="width: 85%; display: inline-block; height:1500px; margin:0px; text-align:center; padding-top: 10px; background-color: cornsilk;">
		<h1 style="margin-top: 100px">게시판 리스트</h1>
	  <form class="navbar-form">
	    <div class="input-group">
	     <div class="form-group navbar-left">
	      <select name="key" class="form-control">
		       <!-- selected="select" or selected -->
		       <option value="t" ${(pageObject.key == "t")? " selected ":"" }>제목</option>
		       <option value="c" ${(pageObject.key == "c")? " selected ":"" }>내용</option>
		       <option value="w" ${(pageObject.key == "w")? " selected ":"" }>작성자</option>
		       <option value="tc" ${(pageObject.key == "tc")? " selected ":"" }>제목/내용</option>
		       <option value="tw" ${(pageObject.key == "tw")? " selected ":"" }>제목/작성자</option>
		       <option value="cw" ${(pageObject.key == "cw")? " selected ":"" }>내용/작성자</option>
		       <option value="all" ${(pageObject.key == "all")? " selected ":"" }>전체</option>
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
 	<table class="table table-bordered" style="width:900px; margin:0 auto;">
		<tr>
			<th>글 번호</th>
			<th>제 목</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<% if(list == null || list.equals("")) { %>
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		<% }  else {%>
			<% for(int i=0; i<list.size(); i++) { %>
				<tr class="content">
					<td><%=list.size()-i%></td>
					<td class="title"><%=list.get(i).getTitle() %></td>
					<td><%=list.get(i).getDate() %></td>
					<td><%=list.get(i).getHitcount() %></td>					
				 </tr>
			<% } %>
		<% } %>
		
		<c:if test="${pageObject.totalPage > 1}">
			<tr>
				<td colspan="5">
					<pageNav:pageNav listURI="list" pageObject="${pageObject}"/>
				</td>
			</tr>
		</c:if>
	</table>
	</div>
</div>
</body>
</html>