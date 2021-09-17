
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.project.vo.ProductVO" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/paikdabang/itemlist.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<%
	List<ProductVO> list = (List<ProductVO>)session.getAttribute("coffeelist");
	DecimalFormat df = new DecimalFormat("###,###");
	List<ProductVO> bestProduct = (List<ProductVO>)session.getAttribute("bestproduts");
	//System.out.println(bestProduct.toString());
%>
<header class = "header">
	<%@ include file="./header.jsp"%>
</header>

<div class="sub_section menu_wrap">
	<div class="container">
		<div id="pattern" class="pattern">
			<div>
				<img src="${pageContext.request.contextPath}/resources/images/paikdabang/bestmenu.jpg" alt="Image Alt Text" style="height: 100px; width: 200px;">
				</h2>
				<hr style="border: solid  1px black; margin-bottom: -10px;"/>
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
			<hr style="border: solid  1px black; margin-top: -10px;"/>
			
			
			
			<div>
				<h2 style="margin:0 auto;">상품목록</h2>
			</div>
		    <ul class="list img-list">
		    	<%for(int i=0; i<list.size(); i++) { %>
		        <li>
		            <a href="${pageContext.request.contextPath}/product/dabang/itemdetail?idx=<%=list.get(i).getIdx()%>" class="inner">
		                <div class="li-img">
		                    <img src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=list.get(i).getImage() %>" alt="Image Alt Text"/>
		                </div>
		                <div class="li-text">
		                    <h4 class="li-head"><%=list.get(i).getMenu() %>(<%=list.get(i).getTemp() %>)</h4>
		                    <strong><%=df.format(list.get(i).getPrice()) %> 원</strong>
		                </div>
		            </a>
		        </li>
		      <% } %>
		    </ul>
		</div>
	</div>
</div>

<footer id = "footer" class = "footer">
	<%@ include file = "./footer.jsp" %>
</footer>
</body>
</html>
</body>
</html>