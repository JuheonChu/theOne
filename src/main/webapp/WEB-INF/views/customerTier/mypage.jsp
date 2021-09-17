<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="com.project.vo.MemberVO" %>
<%@ page import="com.project.vo.OrderVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이 페이지</title>
<link href="css/main_header.css" rel="stylesheet" type="text/css">
<link href="css/main_footer.css" rel="stylesheet" type="text/css">
<link href="css/cs_center.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<style>
.myl>.my>#drop {
   margin: 0;
   padding: 0;
   display: block;
   opacity: 0;
   visibility: hidden;
}

.myl>.my4:hover #drop {
   opacity: 1;
   visibility: visible;
}
</style>

<script src="js/bxslider.js"></script>
</head>
<body>
<%
   MemberVO user = (MemberVO)request.getAttribute("memberinfo"); 
   List<OrderVO> list = (ArrayList<OrderVO>)request.getAttribute("buyBasket");
   DecimalFormat df = new DecimalFormat("###,###");
%>
<header class = "header">
   <%@ include file="../header.jsp"%>
</header>
   <main id="contents" class="wrapper-sub">
      <div id=""
         style="margin-left: 350px; margin-top: 400px; width: 850px; boader: 1px solid black; display: block;">
         <h2 style="margin-left: 50px; margin-top: -300px;">내정보</h2>
         <hr>
         <img src="http://placehold.it/600x600" alt="Image Alt Text"
            style="width: 160px; height: 160px; float: left;">
         <div style="width: 400px; margin-left: 150px;">
            <p
               style="margin-left: 55px; font-weight: 700; font-size: 35px; float: left;"><%=user.getId() %></p>
            <p
               style="margin-left: 15px; font-weight: 700; font-size: 35px; float: left;">
               <span>님</span>
            </p>
         </div>
         <div style="width: 300px; margin-left: 600px; text-align: left;">
            <p style="font-size: 18px;">이름: <%=user.getName() %></p>
            <p style="font-size: 18px;">전화번호: <%=user.getPhone() %></p>
            <p style="font-size: 18px;">이메일: <%=user.getEmail() %></p>
            <p style="font-size: 18px;">주소: <%=user.getAddress() %> <%=user.getDetailaddress() %></p>
         </div>
      </div>
   </main>
   <div
      style="width: 900px; margin-left: 400px; margin-top: 300px; width: 600px; display: block;">
      <h2 style="font-weight: 700; font-size: 35px;">기본정보</h2>
      <p style="margin-top: 20px;">
         회원의 정보를 수정합니다.
         <button
            style="float: right; width: 50px; hegiht: 40px; margin-right: -250px;">
            <a href="${pageContext.request.contextPath}/member/myinfo?userId=<%=user.getId()%>">수정</a>
         </button>
   </div>
   <div
      style="width: 600px; margin-left: 350px; margin-top: 100px; width: 600px; display: block;">
      <h2 style="font-weight: 700; font-size: 35px;">주문정보</h2>
      <div style="margin-top: 20px; width: 700px;">
         <div>
            <table style="width: 900px;">
            <% for (int i=0; i<list.size(); i++) { %>
               <tr>
                  <td
                     style="width: 150px; height: 100px; border-bottom: 1px solid black;"><img
                     src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=list.get(i).getImage() %>" alt="Image Alt Text"
                     style="width: 100px; height: 100px; margin-left: 0px; margin-top: 20px; margin-bottom: 20px;" />
                  </td>
                  <td style="width: 420px; border-bottom: 1px solid black;"><p
                        style="margin-left: 20px; font-size: 15px;">
                        <b><%=list.get(i).getMenu() %></b>
                     </p></td>
                  <td style="border-bottom: 1px solid black;"><p
                        style="margin-left: 20px; font-size: 15px;">
                        <b><%=list.get(i).getCount() %></b> 개
                     </p></td>
                  <td style="border-bottom: 1px solid black;"><p
                        style="margin-left: 20px; font-size: 15px;">
                        <b><%=df.format(list.get(i).getSumPrice()) %> 원 </b>
                     </p></td>
                  <td style="border-bottom: 1px solid black;"><p
                        style="margin-right: 10px;"><%=list.get(i).getTime().substring(0, 10) %></p>
                     <p style="margin-right: 10px;">배송완료</p> <a href="itemlist.jsp"><input
                        type="submit" value="재구매"
                        style="width: 70px; height: 30px; margin-top: -50px; background-color: dodgerblue; color: white;"></a></td>
               </tr>
               <%} %>
            </table>

         </div>
      </div>
   </div>
   <!-- footer -->
   <footer id="footer" class="footer">
      <%@ include file="../footer.jsp"%>
   </footer>
</body>
</html>