<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.project.vo.MemberVO" %>
<%@ page import="com.project.vo.BoardVO" %>
<%@ page import="com.project.service.*" %>
<%@ page import="java.util.*" %>

<%@ page session="false" pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<style>

	img{
		width:33px;
		height:auto;
	}
</style>
</head>
<body>

<%
	if("succeed".equals((String)request.getAttribute("updateSucceed"))){
%>
		<script>alert("수정성공!")</script>
		<%
			}
			
			if("delete".equals((String)request.getAttribute("delete"))){
		%><script>alert("삭제되었습니다!")</script><%
			}
			
			if("login".equals((String)request.getAttribute("login"))){
		%><script>alert("로그인되었습니다!");</script><%
			}
		%>


<%
	int pagenum = ((Integer) request.getAttribute("page")).intValue();
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");
	int totalPage = (Integer) request.getAttribute("totalPage");
	
	
	BoardService service = (BoardService)request.getAttribute("service");
	
	
	
	List<BoardVO>boardList = (List<BoardVO>)request.getSession().getAttribute("boardList");
%>



	<table>
		<tr>
			<th>저자</th>
			<th>제목</th>
			<th>내용</th>
		</tr>

	
		<%
				for(int i = 0; i < boardList.size();i++){ 
						BoardVO board = boardList.get(i);
					//	System.out.println("작성자는? "+board.getWriter());
						String imgFileName = service.getImgName(board.getWriter(), board.getBno());// expected one result or null to be returned by selectOne()
						//but found 11
						//System.out.println("파일명빤딱이: " + imgFileName);		//""
		%> 	
				
		<tr>
				<%if(imgFileName == null){%>
				<td><%=board.getWriter() %></td>
			<% }else{%>
				<td><img src = "../resources/images/<%=imgFileName%>"/></td>
				<%} %>
			
			  <td>
			  	<div style = "text-align: center;">
                     <% if(board.getLevel()!=0){%>
                     	<% for(int a = 0; a <= board.getLevel()*2;a++){ %>
                        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     	<% } %>
                     <%} else {%>
                     <% }%>
                 <a href="./view.do?bno=<%=board.getBno()%>"><%=board.getTitle()%></a>
              	</div>
              </td> 
              
			<td><%=board.getContent() %></td>
			
		</tr>
		<%} %>
	

		<!-- 댓글 -->
		<tr>
		</tr>


		<!-- 페이징 -->
		<tr>
			<td>
				<%
					if (startPage > 1) {
				%> <a href="list.do?page=<%=1%>">[처음으로]</a> <%
 	}
 %> <%
 	if (pagenum > 10) {
 %> <a href="list.do?page=<%=pagenum - 10%>">[이전페이지]</a> <%
 	}
 %> <%
 	for (int a = startPage; a <= endPage; a++) {
 	if (a == pagenum) {//현재페이지에있고, 같은페이지 클릭할수없게끔
 %> [<%=a%>] <%
 	} else {
 %> <a href="list.do?page=<%=a%>">[<%=a%>]
			</a> <%
 	}
 }
 %> <%
 	if (totalPage - pagenum >= 10) {
 %> <a href="list.do?page=<%=pagenum + 10%>">[다음페이지]</a> <%
 	} else {
 %> <a href="list.do?page=<%=totalPage%>">[다음페이지]</a> <%
 	}
 %> <%
 	if (endPage < totalPage) {
 %> <a href="list.do?page=<%=totalPage%>">[끝]</a> <%
 	}
 %>

			</td>

		</tr>

	</table>
	<br />

	<input type="button" value="글쓰기" onclick="location.href='./write.do'" />
	<a href = "../member/logout.do">로그아웃</a>
</body>
</html>
