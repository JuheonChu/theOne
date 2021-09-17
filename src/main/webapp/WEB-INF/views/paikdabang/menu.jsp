<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.project.vo.ProductVO"%>
<%@ page import="com.project.service.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/paikdabang/menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/paikdabang/itemlist.css" rel="stylesheet" type="text/css">

<title>빽다방 전체 상품</title>
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
		String mymenu = (String) request.getAttribute("selectmenu");
	InventoryService inventory = (InventoryService)request.getAttribute("inventoryService");
	try{
		System.out.println(inventory + "들어왔어요~~");
		System.out.println("menu franchiseKey 는????" + franchisekey);
	}catch(Exception e){
		System.out.println("null 서비스입니다...");
	}
	List<ProductVO> list = (List<ProductVO>)request.getAttribute("menulist");

	System.out.println(list.toString());
	List<ProductVO> coffeelist = (List<ProductVO>) request.getAttribute("coffeelist");
	List<ProductVO> beveragelist = (List<ProductVO>) request.getAttribute("beveragelist");
	List<ProductVO> dessertlist = (List<ProductVO>) request.getAttribute("dessertlist");
	List<ProductVO> drinklist = (List<ProductVO>) request.getAttribute("drinklist");
	List<ProductVO> bestProduct = (List<ProductVO>)session.getAttribute("bestproduts");
	String menu = (String) request.getAttribute("menu");

	DecimalFormat df = new DecimalFormat("###,###");
	%>
	
	

	<!-- http://paikdabang.com/wp-content/images/bg-menu.jpg -->

	<div id="pattern" class="pattern">
	<div>
				<img src="${pageContext.request.contextPath}/resources/images/paikdabang/bestmenu.jpg" alt="Image Alt Text" style="height: 100px; width: 200px;">
				</h2>
				<hr style="border: solid  1px black; margin-bottom: -5px;"/>
				<ul class="list img-list">
				<%if(bestProduct!=null) {%>
				<%for(int i=0; i<bestProduct.size(); i++) { 
					System.out.println(bestProduct.get(i).toString() );
				 if(i==3){%>
				 <li>
				 <%}else{%>
				<li style="border-right: 2px solid;">
					 <%} %>
					 <a href="${pageContext.request.contextPath}/product/dabang/itemdetail?idx=<%=bestProduct.get(i).getIdx()%>" class="inner">
		                <div class="li-img">
		                    <img src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=bestProduct.get(i).getImage() %>" alt="Image Alt Text"/>
		                </div>
		                <div class="li-text">
		                    <h4 class="li-head"><%=bestProduct.get(i).getMenu() %>(<%=bestProduct.get(i).getTemp() %>)</h4>
		                    <strong><%=df.format(bestProduct.get(i).getPrice()) %> 원</strong>
		                </div>
		            </a>
				</li>
				 <% } 
				 }%>
				</ul>
			</div>
			<hr style="border: solid  1px black; margin-top: -5px;"/>
		<div>
			<h2 style="margin: 0 auto;">상품목록</h2>
		</div>
		<ul class="list img-list">
        <%
            for (int i = 0; i < list.size(); i++) { //list==> not null
            	ProductVO pdtPdt=  list.get(i);
            	System.out.println(pdtPdt.getIdx() + " , "); //13번===> O 14번====> NULL
            			
            	int tempSoldOut = (Integer)inventory.getSoldOutInt(pdtPdt.getIdx(), franchisekey);
            	//System.out.println("Tempsoldout :   >>>>" + tempSoldOut);
         %>
         <li>
            <% if (tempSoldOut > 0){ %>
            <a href="${pageContext.request.contextPath}/product/dabang/itemdetail?idx=<%=list.get(i).getIdx()%>" class="inner">
               <div class="li-img">
                     <img  src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=list.get(i).getImage() %>"
                     alt="Image Alt Text" />
               </div>
               <div class="li-text">
                  <h4 class="li-head"><%=list.get(i).getMenu()%>(<%=list.get(i).getTemp()%>)
                  </h4>
                  <strong><%=df.format(list.get(i).getPrice())%> 원</strong>
               </div>
            </a>
            <%} else { %>
               <div class="li-img">
                     <img
                     src="${pageContext.request.contextPath}/resources/images/Sold_Out.png"
                     alt="Image Alt Text" />
               </div>
               <div class="li-text">
                  <h4 class="li-head"><%=list.get(i).getMenu()%>(<%=list.get(i).getTemp()%>)
                  </h4>
                  <strong><%=df.format(list.get(i).getPrice())%> 원</strong>
               </div>
            <%} %>
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