<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header class = "header">
		<%@ include file="../header.jsp"%>
	</header>
<section>

 <div id="main_content">
            <div id="message_box">
 				 <!-- 쪽지함 이동 버튼 영역 -->
                <ul class="top_buttons">
                    <li><a href="${pageContext.request.contextPath}/member/alarm.do?mode=receive">수신 쪽지함</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/alarm.do?mode=send">송신 쪽지함</a></li>
                </ul>
                           
 			 </div>
 
	</div>
 
</section>

	<footer class = "footer">
		<%@ include file="../footer.jsp"%>
	</footer>
</body>
</html>