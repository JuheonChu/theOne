<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.project.vo.ProductVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/hanshin/menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/hanshin/itemlist.css" rel="stylesheet" type="text/css">

<title>한신포차 전체 상품</title>
<script src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
<style type="text/css">
hr{
width: 800px;
}
</style>
</head>
<body>
	
	<header class="header">
		<%@ include file="./header.jsp"%>
	</header>
	
	<%
	//String mymenu = (String)request.getAttribute("selectmenu");
	
//	if (mymenu == null) {
//		System.out.println("mymenu가 null입니다.");
//	}
//	else {
//		System.out.println("mymenu >> " + mymenu); //값들어옴...
//	}

	List<ProductVO> list = (List<ProductVO>)session.getAttribute("menulist");
	InventoryService inventory = (InventoryService)request.getAttribute("inventoryService");
	String menu = (String) request.getAttribute("menu");
	List<ProductVO> bestProduct = (List<ProductVO>)session.getAttribute("bestproduts");

	DecimalFormat df = new DecimalFormat("###,###");
	%>

	<!-- http://paikdabang.com/wp-content/images/bg-menu.jpg -->

	<div id="pattern" class="pattern" style = "margin-top:121px;">
		<div>
				<img src="${pageContext.request.contextPath}/resources/images/paikdabang/bestmenu.jpg" alt="Image Alt Text" style="height: 100px; width: 200px;">
				</h2>
				<hr style="border: solid  1px black; width:1000px; margin-bottom: -5px;"/>
				<ul class="list img-list" style="margin-top: -8px;">
				<%if(bestProduct!=null) {%>
				<%for(int i=0; i<bestProduct.size(); i++) { 
					System.out.println(bestProduct.get(i).toString() );
				 if(i==3){%>
				 <li>
				 <%}else{%>
				<li style="border-right: 2px solid;">
					 <%} %>
		                <div class="li-img">
		                    <img src="${pageContext.request.contextPath}/resources/images/hanshin/<%=bestProduct.get(i).getImage() %>" alt="Image Alt Text"/>
		                </div>
		                <div class="li-text">
		                    <h4 class="li-head"><%=bestProduct.get(i).getMenu() %></h4>
		                    <strong><%=df.format(bestProduct.get(i).getPrice()) %> 원</strong>
		                </div>
				</li>
				 <% } 
				 }%>
				</ul>
			</div>
			<hr style="border: solid  1px black; width:1000px; margin-top: -5px;"/>
		<div>
			<h2 style="margin: 0 auto;">상품목록</h2>
		</div>
		<ul class="list img-list">
			<%
            for (int i = 0; i < list.size(); i++) {
         %>
         <li>
            <% if (inventory.getSoldOutInt(list.get(i).getIdx(), franchisekey) > 0){ %>
            <div  class="inner">
               <div id = "li-img" class="li-img">
                  <a href="${pageContext.request.contextPath}/product/hanshin/itemdetail?idx=<%=list.get(i).getIdx()%>">
                     <img src="${pageContext.request.contextPath}/resources/images/hanshin/<%=list.get(i).getImage() %>" alt="Image Alt Text" />
                  </a>
               </div>
               <div class="li-text">
                  <h4 class="li-head"><%=list.get(i).getMenu()%></h4>
                  <strong><%=df.format(list.get(i).getPrice())%>원</strong>
               </div>
            </div>
            <% } else {%>
            <div  class="inner">
               <div id = "li-img" class="li-img">
                  <img src="${pageContext.request.contextPath}/resources/images/Sold_Out.png" alt="Image Alt Text" />
               </div>
               <div class="li-text">
                  <h4 class="li-head"><%=list.get(i).getMenu()%></h4>
                  <strong><%=df.format(list.get(i).getPrice())%>원</strong>
               </div>
            </div>
            <% } %>
         </li>
         <%
            }
         %>
		</ul>
	</div>
	<footer id="footer" class="footer">
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>