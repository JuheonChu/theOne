<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "com.project.vo.BoardVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	if("deactivateDeletion".equals((String)request.getAttribute("deactivateDeletion"))){
%><script>alert("삭제할 권한이없습니다!");</script><%
	}
%>


<%
	BoardVO board = (BoardVO)request.getAttribute("board");
	request.setAttribute("board", board);
	
	String[] fileArr = null;
	int size = 0;
	
	if(board.getFile()==null){//null check
		System.out.println("file");
	}else{
		fileArr = board.getFile().split("_");
		size = fileArr.length;
		System.out.println("첨부된 파일: " + fileArr.toString());
		System.out.println("첨부된 파일 수: " + size);
	}
	
%>
</head>
<body>
	<table>
            <tr>
                <th>작성자</th><td><%= board.getWriter() %></td>
                <th>게시글 번호</th><td><%= board.getBno()%></td>
            </tr>    
            <tr>
                <th>작성일</th><td><%=board.getDate() %></td>
                <th>조회수</th><td><%=board.getHitcount() %></td>
            </tr>    
            <tr>
                <th>제목</th>
                <td colspan="3"><%=board.getTitle() %></td>
            </tr>
	             
            	
            <tr>
                <th>내용</th>
                <td colspan="3"><pre><%=board.getContent() %></pre></td>
                        <!-- <pre> 문자열을 쓴 그대로 자유롭게 보여주는 선언자 -->
            </tr>    
            
            <tr>
            	<th>첨부파일</th>
            	<%
            		for(int i=0 ;i<size ;i++){
            				
            		%>
            		<td><a href=file/<%=fileArr[i] %> download name="file"><%=fileArr[i]%></a></td>
            		<% 
            			}
            		%>
            		
            </tr>
            
            
        </table><br/><br/><br/><br/>
        <input type = "hidden" id = "bno" value = "<%=board.getBno() %>">
        <input type = "button" value = "수정하기" onclick = "location.href='./update.do?bno=<%=board.getBno() %>'" id = "btnUpdate">
        <input type = "button" value = "삭제하기" onclick = "location.href='./delete.do?bno=<%=board.getBno()%>'" id = "btnDelete">
        <input type = "button" value = "답글달기" onclick = "location.href = './reply.do?bno=<%=board.getBno() %>'">
</body>
</html>