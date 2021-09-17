<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.project.vo.MemberVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha256-4+XzXVhsDmqanXGHaHvgh1gMQKX40OUvDEBTu8JcmNs="
	crossorigin="anonymous"></script>
<%if("fail".equals((String)request.getAttribute("updateFail"))){
	%>	<script>alert("수정할 권한이 없습니다!")</script><%	
}
%>
	

<script>
	$(function(){
		$(function(){
			})
	    
		var count=0;
	    $("#fileAdd").click(function(){
		    count++;
			var str="<div><input type='file' name='multiparts'/><div>";
			$("#fileUpload").append(str);
		});
	});
</script>

<style>

	img{
		width:33px;
	}
</style>
<% MemberVO member = (MemberVO)request.getSession().getAttribute("member");
	int bno = (Integer)request.getAttribute("bno");%>
<body>
	<form method = "post" action = "./updateAction.do" enctype="multipart/form-data">
		<%if(member.getFilename()==null) {%>
		저자: <input type="text" name="writer" value='<%=session.getAttribute("userid")%>' readonly="readonly"/>
		<%}else{ %>
		<input type = "hidden" name = "writer" value = '<%=session.getAttribute("userid")%>' readonly="readonly"/>
		저자 : <img src = "../resources/images/<%=member.getFilename() %>" alt = "<%=member.getId()%>">
		<%} %>
		
		
		제목: <input type = "text" name = "title">
		내용: <input type = "text" name = "content">
		파일1: <input type = "file" name = "multiparts"/><br/>
		
		<input type="button" value="추가" name="fileAdd" id="fileAdd">
		<input type = "hidden" value = "<%=bno %>" name = "bno">
		<div id="fileUpload" class="fileUpload">
				
		</div>
		
		
		<input type = "submit" value = "글쓰기">
	</form>
</body>
</html>