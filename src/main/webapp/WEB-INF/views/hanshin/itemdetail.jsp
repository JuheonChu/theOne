<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="com.project.vo.ProductVO" %>
<%@ page import="com.project.vo.MemberVO" %>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>한신포차 상품 상세보기</title>
<link
	href="${pageContext.request.contextPath}/resources/css/hanshin/itemdetail.css"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plmi.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
</head>
<body>
<%
	ProductVO product = (ProductVO)request.getAttribute("product");
	DecimalFormat df = new DecimalFormat("###,###");
%>
<header class="header">
	<%@ include file="./header.jsp"%>
</header>
	<div id="container">
		<main id="contents" class="wrapper-sub">
			<div class="section goods-detail-top">
				<div id="thumbnail">
					<div class="wrapper-thumbnail-swiper">
						<div class="thumbnail-item" style="width: 600px;">
							<img src="${pageContext.request.contextPath}/resources/images/hanshin/<%=product.getImage() %>" width="500" height="500"
								alt="상품 상세 이미지">
						</div>
					</div>
				</div>
				<div class="goods-detail-info" id="goodsPurchase">
					<div class="detail-info-top">
						<div class="brand">
							<%=product.getBrand() %>
						</div>
						<h1 class="name"><%=product.getMenu() %></h1>
						<div class="price num">
							<div class="optn-change" style="" data-dp-code="C3_1000020518522">
								<div class="price-inner">
									<strong><%=df.format(product.getPrice()) %> 원</strong>
								</div>
							</div>
						</div>
					</div>
					<div class="float-box in" data-dp-code="C3_1000020518522">
						<p>
							상품정보<br> <br>
							<%=product.getDetailExplain() %></p>
					</div>
					<div class="float-box">
						<div class="item">배송정보</div>
						<div class="item right">
							시코르배송 2,500원
							<p class="desc">(30,000원 이상 구매시 무료배송 도서산간지역 4,500원)</p>
						</div>
					</div>
					<% if (!(member.getId().equals("none"))) {%>
					<form action="${pageContext.request.contextPath}/product/hanshin/addBasket?id=<%=member.getId() %>&pid=<%=product.getIdx() %>&franchisekey=<%=franchisekey %>&pid=<%=product.getIdx() %>" method="post">
						<div class="wrap-option">
							<div class="wrap-spinner" data-dp-code="C3_1000020518522">
								<div class="spinner-name">구매수량</div>
								<div class="spinner">
									<button type="button" class="sp-sub-minus"
										onclick="optnQtyMinus($(this));"
										style="width: 40px; height: 26px;">
										<b>-</b>
									</button>
									<input type="tel" class="num" value="1" name="count"
										id="btnQtyC3_1000020518522" data-max-qty="10" stoc-qty="3091">
									<button type="button" class="sp-sub-plus"
										onclick="optnQtyPlus($(this), '3091');"
										style="width: 40px; height: 26px;">
										<b>+</b>
									</button>
								</div>
								<div class="wrap-btn">
									<input type="submit" class="btn btn-color2" value="장바구니 담기"/>
									<input type="submit" class="btn btn-color1" value="구매"/> <%--이것도 장바구니로 감... --%><%--장바구니 말고 바로구매되게하고싶긴함... --%>
								</div>
							</div>
						</div>
					</form>
					<div>
						<a href="menu.jsp"><input type="submit" value="목록" class="btn btn-primary"
							style="width: 80px; font-size: 20px; margin-left: 390px; margin-top: 20px;"/></a>
					</div>
					<%} else { %>
					<form action="${pageContext.request.contextPath}/product/hanshin/nullBuy?
					id=<%=member.getId()%>&pid=<%=product.getIdx() %>&franchisekey=<%=franchisekey %>" method="post">
						<div class="wrap-option">
							<div class="wrap-spinner" data-dp-code="C3_1000020518522">
								<div class="spinner-name">구매수량</div>
								<div class="spinner">
									<button type="button" class="sp-sub-minus"
										onclick="optnQtyMinus($(this));"
										style="width: 40px; height: 26px;">
										<b>-</b>
									</button>
									<input type="tel" class="num" value="1" name="count"
										id="btnQtyC3_1000020518522" data-max-qty="10" stoc-qty="3091">
									<button type="button" class="sp-sub-plus"
										onclick="optnQtyPlus($(this), '3091');"
										style="width: 40px; height: 26px;">
										<b>+</b>
									</button>
								</div>
								<div class="wrap-btn">
									<input type="submit" class="btn btn-color2" value="장바구니 담기"/>
									<input type="submit" class="btn btn-color1" value="구매"/>
								</div>
							</div>
						</div>
					</form>
					<div>
						<a href="javascript:history.back();"><input type="button" value="목록" class="btn btn-primary"
							style="width: 80px; font-size: 20px; margin-left: 390px; margin-top: 20px;"/></a>
					</div>
					<%} %>
				</div>
			</div>
		</main>
	</div>
	<!-- footer -->
	<%-- <footer id="footer" class="footer">
		<%@ include file="./footer.jsp"%>
	</footer> --%>
</body>
</html>