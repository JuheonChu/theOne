<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.OrderVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빽다방 장바구니</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
body {
	font-family: "Bauhaus ITC";
	color: black;
}
#title {
	text-decoration: none;
}
</style>

</head>

<body id="body">
<%
	String id = (String)request.getAttribute("id");
	ArrayList<OrderVO> list = (ArrayList<OrderVO>)request.getAttribute("basketList");
	DecimalFormat df = new DecimalFormat("###,###");
%>	
<header class="header">
			<%@ include file="./header.jsp"%>
</header>
	<div id="maindiv">
		<form action="${pageContext.request.contextPath}/product/dabang/buy?id=<%=id %>" method="post">
			<table class="list-table" style="border-spacing: 0px; margin:0 auto;">
				<tr class="list-tableth">
					<td width="50px;"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">
						<label><input type="checkbox" value="alldelete" checked="checked"></label>
					</td>
					<td width="200"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">이미지</td>
					<td width="300"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">상품 이름</td>
					<td width="120"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">판매가</td>
					<td width="180"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">수량</td>
					<td width="100"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">배송비</td>
					<td width="100"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">시간</td>
					<td width="100"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">합계</td>
					<td width="100"
						style="border-top: 4px solid orange; border-bottom: 2px solid orange;">취소</td>
				</tr>
				<tbody class="list-tabletd">
				<% for (int i=0; i<list.size(); i++) {
					int count = list.get(i).getCount();
					int sum = list.get(i).getPrice();
					int lastPrice =+ count * sum;
				%>
					<tr>
						<td width="10" style="border-bottom: 4px solid orange;"><label><input
								type="checkbox" value="<%=list.get(i).getOid()%>" checked="checked"></label></td>
						<td width="150" style="border-bottom: 4px solid orange;">
							<div class="bak_item">
								<div class="pro_img"></div>
								<div class="pro_nt"></div>
								<img src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=list.get(i).getImage() %>" width="150" height="150">
							</div>
						</td>
						<td width="150" style="border-bottom: 4px solid orange;"><%=list.get(i).getMenu() %>(<%=list.get(i).getTemp() %>)</td>
						<td width="150" style="border-bottom: 4px solid orange;"><%=df.format(sum) %></td>
						<td width="150" style="border-bottom: 4px solid orange;">
							<div>
								<input type="number" value="<%=count %>" name="count" size="2" min="0"
									max="100" class="proquantity">
								<!-- <span>
				          			<input type="button" class="img-button2" >
				          			<input type="button" class="img-button3" >
				          		</span> -->
							</div>
						</td>
						<td width="150" style="border-bottom: 4px solid orange;">2,500원</td>
						<td width="150" style="border-bottom: 4px solid orange;"><%=list.get(i).getTime().substring(0,10) %></td>
						<td width="150" style="border-bottom: 4px solid orange;"><%=df.format(sum * count) %> 원</td>
						<td width="50" style="border-bottom: 4px solid orange;">
							<a onclick="return confirm('<%=list.get(i).getMenu() %>을(를) 취소 하시겠습니까??')" href="${pageContext.request.contextPath}/product/dabang/deleteBasket?oid=<%=list.get(i).getOid()%>&id=<%=member.getId() %>" class="btn btn-lg btn-danger">취소</a>
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<br> <br> <br> 
			<%--<input type="reset" value="전체상품주문" class="longbt1" style="margin-left: 250px;"/> --%> 
			<input type="submit" value="선택상품주문" class="longbt2"/>
		</form>
	</div>
	<footer id="footer" class="footer">
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>
