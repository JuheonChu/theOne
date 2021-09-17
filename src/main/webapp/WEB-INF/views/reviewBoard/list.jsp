<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- , 또는 날자 패턴을 넣을수 있는 태그 -->
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project.vo.ReviewBoardVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <style>
  	.dataRow:hover {
  		background: #eee;
  		cursor: pointer;
  	}
  </style>
  <script type="text/javascript">
	$(function() {
		// 쓰기 메세지 처리
		<c:if test="${writeAction == 'write success'}">
			alert("작성하신 글이 등록 되었습니다.")
		</c:if>
		<c:if test="${deleteAction == 'delete success'}">
			alert("글 삭제가 되었습니다.")
		</c:if>
		$(".dataRow").click(function() {
			var no = $(this).find(".no").text();
			location = "view?no=" + no + "&inc=1";
		});
	});
  </script>
</head>

<body>
<%try{ %>
	<header id = "header" class="header">
		<%@ include file="../header.jsp"%>
	</header>
<%}catch(Exception e){e.printStackTrace();} %>
<%
	ArrayList<ReviewBoardVO> list = (ArrayList<ReviewBoardVO>)request.getAttribute("list");
%>
<div class="container">
	<h1>게시판 리스트</h1>
	 <div>
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
	</div>
	
	<table class="table">
		<tr>
			<th>글 번호</th>
			<th>제 목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
		<% if(list == null || list.equals("")) { %>
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		<% }  else {%>
			<% for(int i=0; i<list.size(); i++) { %>
				<tr class="dataRow">
						<td class="no"><%=list.get(i).getNo() %></td>
					<%if(list.get(i).getFileName() == null) {%>
						<td><% for(int j=0;j<list.get(i).getIndent(); j++){ %>		
           				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              	<% } if(list.get(i).getIndent()!=0){ %>
						<img src="${pageContext.request.contextPath}/resources/images/review/comment.png"/>
				<% } %>
				<%=list.get(i).getTitle() %></td>
					<%} else {%>
						<td><% for(int j=0;j<list.get(i).getIndent();j++){ %>		
              				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <% } if(list.get(i).getIndent()!=0){ %>
						<img src="${pageContext.request.contextPath}/resources/images/review/comment.png"/>
				<% } %><img src="${pageContext.request.contextPath}/resources/images/review/<%=list.get(i).getFileName() %>" height="60"/> <%=list.get(i).getTitle() %></td>
					<%} %>
					<td><%=list.get(i).getWriter() %></td>
					<td><%=list.get(i).getWriteDate() %></td>
					<td><%=list.get(i).getHit() %></td>
				</tr>
			<% } %>
		<% } %>
		
		<tr>
			<td colspan="5">
				<a href="write" class="btn btn-default">글 쓰기</a>
			</td>
		</tr>
		
		<c:if test="${pageObject.totalPage > 1}">
			<tr>
				<td colspan="5">
					<pageNav:pageNav listURI="list" pageObject="${pageObject}"/>
				</td>
			</tr>
		</c:if>
	</table>
</div>
<%try{ %>
	<footer id = "footer" class="footer">
		<%@ include file="../footer.jsp"%>
	</footer>
<%}catch(Exception e){e.printStackTrace();} %>
</body>
</html>