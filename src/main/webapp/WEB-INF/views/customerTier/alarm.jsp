<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "com.project.vo.*" %>
<%@page import = "com.project.service.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>Insert title here</title>

<%
   TempService tempservice = (TempService)request.getAttribute("tempbusinessservice");
   List<Message> myInbox = (List<Message>)request.getAttribute("myInbox");
   List<Message> myOutbox = (List<Message>)request.getAttribute("myOutbox");
   
   System.out.println(myInbox);
   String mode = request.getParameter("mode");
 %>

</head>

<body>

 <header class = "header">
		<%@ include file="../header.jsp"%>
	</header>
<div>
 <%if(mode.equals("send")){
	
	 %>
	
	
<table class = "table">
		<tr>
			<th>발신자</th>
			<th>수신자</th>
			<th>수신중요도</th>
			<th>쪽지내용</th>
			<th>발신시간</th>
		</tr>
		
	<%for(int i = 0; i < myOutbox.size();i++){
		Message mySendMail = myOutbox.get(i);%>
		<tr>
			<td><%=mySendMail.getFromId() %></td>
			<td><%=mySendMail.getReceiver()%></td>
			<td><%=mySendMail.getTopic()%></td>
			<td><%=mySendMail.getMessagecontent()%></td>
			<td><%=mySendMail.getRegist_date()%></td>
		
		</tr>
		<%} %>
</table>
<%		
	}else if(mode.equals("receive")){
%>
<%--수신함 --%>

	<table class = "table">
		<tr>
			<th>발신자</th>
			<th>수신자</th>
			<th>수신중요도</th>
			<th>쪽지내용</th>
			<th>수신시간</th>
		</tr>
		
	<%for(int k =  myOutbox.size()-1; k >= 0 ;k--){ 
		Message myInboxMail = myInbox.get(k);
		int tempContractno = myInboxMail.getContractno();
     	TempVO temp = tempservice.findmyBusiness(tempContractno);%>
     	
		<tr>
			<td><%=myInboxMail.getFromId() %></td>
			<td><%=myInboxMail.getReceiver()%></td>
			<td><%=myInboxMail.getTopic()%></td>
			<%if(myInboxMail.getTopic().equals("필수") && "no".equals(temp.getMapservice())){
	      System.out.println("지도서비스 이용안합니다");%>
	         <td><a href = "${pageContext.request.contextPath}/headquarter/franchiseform.do?contractno=<%=myInboxMail.getContractno()%>"><%=myInboxMail.getMessagecontent()%></a></td>
	      <%}else if(myInboxMail.getTopic().equals("필수") && "yes".equals(temp.getMapservice())){//여기서부터시작...
	      System.out.println("지도서비스를 이용할 유저...");%>
	         <td><a href = "${pageContext.request.contextPath}/headquarter/franchisemapservice.do?contractno=<%=myInboxMail.getContractno()%>"><%=myInboxMail.getMessagecontent()%></a></td>
	      <%   }
	      
	      else if(myInboxMail.getTopic().equals("승인완료")){
	         %>
	         <td><a href = "${pageContext.request.contextPath}/headquarter/franchiseApproved.do?contractno=<%=myInboxMail.getContractno()%>"><%=myInboxMail.getMessagecontent()%></a></td> 
	         <%
	      }else if(myInboxMail.getTopic().equals("배송조회")){
	         %>
	         <td><a href = "${pageContext.request.contextPath}/headquarter/franchiseOrder.do?contractno=<%=myInboxMail.getContractno()%>&franchisekey=<%=temp.getFranchisekey()%>"><%=myInboxMail.getMessagecontent() %></a></td>
	         <%
	      }
	      else{ %>
	         <td><%=myInboxMail.getMessagecontent()%></td>
	      <%} %>
	         <td><%=myInboxMail.getRegist_date()%></td>
	      
	      </tr>
	      <%} %>
	</table>

<%	
	}
%>

</div>
</body>
</html>