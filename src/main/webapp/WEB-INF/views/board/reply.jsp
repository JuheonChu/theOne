<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "com.project.vo.*" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
  <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% request.setCharacterEncoding("utf-8"); %>

<% response.setContentType("text/html; charset=utf-8"); %>


</head>

<script>
$(document).ready(function(){        
	
});


/** 게시판 - 답글 작성  */
function insertBoardReply(){

	event.preventDefault();
	var title = $("#title").val();
	var content = $("#content").val();

	if(title = ""){
		alert("제목을 입력하세요!");
		$("#title").focus();
		return ;
	}

	if(content = ""){
		alert("내용을 입력하세요");
		$("#content").focus();
		return;
	}

	
	var warn = confirm("게시글을 등록하시겠습니까?");//
	if(warn){
		$.ajax({    
            url        : 'http://localhost:8080/rest2/vo/reply',
            data    : $("#boardForm").serialize(),
            dataType: 'json',
            cache   : false,
            async   : true,
            contentType:"application/x-www-form-urlencoded; charset=utf-8", 
            type    : "post",    
            success : function(response) { 
            	 alert("게시글 답글 등록을 성공하였습니다.");   
            	 //alert(response.bno);
            	 //alert(response.title)             
            	 var ajaxName = decodeURIComponent(response.ajaxName);
                 goBoardList();         
                 title.val("");
                 content.val("");    
            },           
            error     : function(xhr, status, error) {
                		alert("에러!");
						alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						}
            
        });
    }else{
		alert("취소!");
	}
 }




 function goBoardList(){
	location.href=  "list.do";
 }

 
</script>
<style>
	img{
		width:33px;
	}
</style>
<%
	MemberVO member= (MemberVO)request.getSession().getAttribute("member");
  	BoardVO board = (BoardVO)request.getAttribute("board");
%>
<body>
	<form id = "boardForm" name = "boardForm" accept-charset="UTF-8">
		<input type = "hidden" name = "bno" value = "<%= board.getBno() %>"/>
		<input type = "hidden" name = "ref" value = "<%= board.getRef()%>" />
		<input type = "hidden" name = "step" value = "<%= board.getStep()%>"/>
		<input type = "hidden" name = "level" value = "<%= board.getLevel()%>"/>
		제목: <input type = "text" id = "title" name = "title" maxlength = "100" value = "Re:<%=board.getTitle()%>"/>
		내용: <textarea id = "content" name = "content"  value="Re:<%=board.getContent()%>" cols= "67" rows = "15"/></textarea>
		
		<%if(member.getFilename()==null){ %>
		저자: <input type = "text" name = "writer" value = '<%=session.getAttribute("userid")%>' readonly="readonly"/>
		<%}else{%>
		<input type = "hidden" name = "writer" value = '<%=session.getAttribute("userid")%>' readonly="readonly"/>
		저자 : <img src = "../resources/images/<%=member.getFilename() %>" alt = "<%=member.getId()%>">
		<%} %>
	</form>
	
	<div>
		<input type = "button" value = "뒤로가기" onclick = "history.go(-1)">
		<input type = "button" id = "comment" value = "등록하기" onclick = "javascript:insertBoardReply();">
	</div>
</body>
</html>