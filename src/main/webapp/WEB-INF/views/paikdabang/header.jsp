<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/paikdabang/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/paikdabang/chatpage.css"/>
<title>빽다방 헤더</title>
<script>
$(document).ready(function() {

	   // 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	   var floatPosition = parseInt($("#chaticon").css('top'));
	   // 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	   $(window).scroll(function() {
	      // 현재 스크롤 위치를 가져온다.
	      var scrollTop = $(window).scrollTop();
	      var newPosition = scrollTop + floatPosition + "px";
	      /* 애니메이션 없이 바로 따라감
	       $("#floatMenu").css('top', newPosition);
	       */

	      $("#chaticon").stop().animate({
	         "top" : newPosition
	      }, 800);

	      $("#main-container").stop().animate({
		         "top" : newPosition
		      }, 800);

	   }).scroll();


	  
	});
</script>

</head>

<%
	String franchiseid = null;
	String franchisekey = (String) session.getAttribute("franchisekey");
	MemberVO member = null;
	String selectmenu = null;
	String myfkKey = null;
	String mydefaultTier = null;
	String mymymymymenu = (String)session.getAttribute("superSonny");
	System.out.println("사장님이 선택한 메뉴: " + mymymymymenu);
try {
	franchiseid = (String) session.getAttribute("franchiseid");
	selectmenu = (String) request.getAttribute("menu");
	member = (MemberVO) session.getAttribute("loginMember");
	myfkKey = member.getFranchisekey();
	mydefaultTier = member.getTier();
} catch (Exception e) {
	franchiseid = "customer";
	member = new MemberVO();
	member.setIdx(0);
	member.setId("none");
	myfkKey = "a";
	mydefaultTier = "customer";
}


%>
<body>
<nav class="navbar" style="display: inline-flex; margin-bottom: 40px; padding: 25px 6px 0px;">
	<div class = "subNash">
		<a href = "${pageContext.request.contextPath}/product/dabang/gotoPaikDabang.do?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>&tier=<%=mydefaultTier %>" class="logo" style = "position: relative;  top: 30px;right:-20px;"> 
			<%--<img src="http://www.paikdabang.com/wp-content/themes/paikdabang/assets/images/logo.png" alt="빽다방" style="width: 149px;" /> --%>
			<img src = "${pageContext.request.contextPath}/resources/images/paikdabang/DABANG-logo (1).png" style="width: 149px;">
		</a>
		
		<div class="main-menu" style = "position: relative;right: -200px;top: -50px;z-index: 1;">
			<ul class="menu">
				<li style="list-style: none;">
					<a href="${pageContext.request.contextPath}/product/dabang/menu.do?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>">메뉴</a>
				
					<ul id = "sub-menuT" class = "sub-menuT" style="z-index: 1; display: inline-grid; list-style: none;">
						<li><a
							href="${pageContext.request.contextPath}/product/dabang/coffee?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>">커피</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/dabang/dessert?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>">아이스크림/디저트</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/dabang/beverage?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>">음료</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/dabang/drink?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>">빽스치노</a></li>
					</ul>
				
				</li>
			</ul>
		<%--	<ul class="menu">
				<li style="list-style: none;"><a href="">소식</a>

					<ul id = "sub-menuT" class= "sub-menuT" style="z-index: 1; display: inline-grid; list-style: none;">
						<li><a href="#">소식</a></li>
						<li><a href="${pageContext.request.contextPath}/util/findPerson.do">구인공고</a></li>
						<li><a href="#">우수 친절매장</a></li>
					</ul>
				</li>
			</ul> --%>
			
			
			<ul class="menu">
				<li style="list-style: none;">
					<a href="${pageContext.request.contextPath}/product/dabang/come/to/mystore?franchisekey=<%=franchisekey%>" style = "position: relative; right: 0px;   top: -4px;width:115px;">매장안내</a>
				</li>
			</ul>

			

			<%
				if (franchisekey.equals(myfkKey)) {
				//System.out.println("사장님 들어옴...");
			%>
			<ul class="menu">
				<li style="list-style: none;"><a style = "position: relative;right: 0px;top: -4px;width:115px;"
					href="${pageContext.request.contextPath}/product/dabang/resources/order?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>&tier=<%=member.getTier()%>">재고주문</a></li>
			</ul>
			
			<ul class="menu">
				<li style="list-style: none;">
					<a style = "position: relative;right: 0px;top: -4px;width:115px;" href="${pageContext.request.contextPath}/product/dabang/resources/chart?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>&tier=<%=member.getTier()%>">지점평가
						</a></li>
			</ul>
			
			
			<%
				} else if ("customer".equals(mydefaultTier)) {
			System.out.println("일반소비자");
			}
			%>
			<% if(member != null) {%>
			<ul class="menu">
				<li style="list-style: none;"><a style = "position: relative;right: 0px;top: -4px;width:114px;"
					href="${pageContext.request.contextPath}/product/dabang/basket?id=<%=member.getId()%>">장바구니</a></li>
			</ul>
			<%} else if(member == null) {%>
			<ul class="menu">
				<li style="list-style: none;"><a style = "position: relative;right: 0px;top: -4px;width:114px;"
					href="${pageContext.request.contextPath}/product/dabang/basket">장바구니</a></li>
			</ul>
			<%} %>
		</div>
</div>
	</nav>
	
	
	<a href = "javascript:void(window.open('${pageContext.request.contextPath}/headquarter/chatpage', '_blank','width=600, height=800'))"  id = "chaticon" class = "chaticon">
		<img src = "${pageContext.request.contextPath}/resources/images/paikdabang/live-chat_icon-icons.com_52831.png" style = "width:70px;"/>
	</a>
	
	
	
	
</body>
</html>