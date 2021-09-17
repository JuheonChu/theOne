<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.*" %>
<%@ page import="com.project.service.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한신포차</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/hanshin/header.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatpage.css"/>
	<!-- Link Swiper's CSS -->
	<link rel="stylesheet" href="https://swiperjs.com/package/swiper-bundle.min.css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	
</head>
<script>
function chatPage(){
	location.href = 'http://192.168.6.118:8080/headquarter/chatpage'
}

$(function(){

	
	
<%--	$("#chaticon").click(function(){

		$("#main-container").removeAttr('style');--%>

		
	<%--	$("#main-container").fadeIn(); --%>
<%--	}); --%>

<%--	$(".close").click(function(){
		$("#main-container").fadeOut();
	});--%>
	
});
</script>
<%
//	TempService tempservice = (TempService)request.getAttribute("tempserviceABC");
	String franchiseid = null;
	String franchisekey = (String) session.getAttribute("franchisekey");
	MemberVO member = null;
	String selectmenu = null;
	String myfkKey = null;
	String mydefaultTier = null;
//	TempVO myown = null;
	String mymymymymenu = (String)session.getAttribute("mymymymymenu");
	
try {
	franchiseid = (String) session.getAttribute("franchiseid");
	selectmenu = (String) request.getAttribute("menu");
	member = (MemberVO) session.getAttribute("loginMember");
	myfkKey = member.getFranchisekey();
	mydefaultTier = member.getTier();
//	myown = (TempVO)session.getAttribute("myownNN");
	
//	System.out.println("myown: " + myown.toString());
///	System.out.println("myown.selectmenu(): " + myown.getSelectmenu());
//	System.out.println("myown.contractNo(): " + myown.getContractno());
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

	<!-- Header -->
	<header>
		<div class="header">
			<div class="header_content">
				<h1>
					<a href="${pageContext.request.contextPath}/product/hanshin/gotoHanshin.do?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>&tier=<%=mydefaultTier%>">
						<img src="${pageContext.request.contextPath}/resources/images/hanshin/logo.png"/>
					</a>
				</h1>
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/menu?selectmenu=<%=mymymymymenu%>">메뉴</a>
					</li>
				
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/come/to/mystore?franchisekey=<%=franchisekey%>">매장 안내</a>
					</li>
				
			
				
				
				<%if(!member.getId().equals("none") && member.getId().equals(franchiseid)){ %> 
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/basket?id=<%=member.getId()%>">장바구니</a>
					</li>
				<% }else{%>	
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/basket?id=<%=member.getId()%>">장바구니</a>
					</li>
				<%} %>
					
					
					
				<%if(franchisekey.equals(myfkKey)){%>	
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/resources/order?selectmenu=<%=selectmenu%>&franchisekey=<%=franchisekey%>&tier=<%=member.getTier()%>">재고 관리</a>
					</li>
					
					<li>
						<a href="${pageContext.request.contextPath}/product/hanshin/resources/hanshinchart?selectmenu=<%=mymymymymenu%>&franchisekey=<%=franchisekey%>&tier=<%=member.getTier()%>"">지점평가</a>
					</li>
				<% }%>
				</ul>
				
				
				<a href = "javascript:void(window.open('${pageContext.request.contextPath}/headquarter/chatpage', '_blank','width=600, height=800'))" id = "chaticon" class = "chaticon">
					<img src = "${pageContext.request.contextPath}/resources/images/icons8-chat-64.png" alt = "채팅아이콘" onclick = ""/>
				</a>
				
				
				
			
				
				
			</div>
		</div>
	</header>
	
	<!-- Swiper JS -->
	<script src="https://swiperjs.com/package/swiper-bundle.min.js"></script>
	
	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper('.swiper-container', {

			autoplay: {
				delay: 3000,
			},

			loop:true,
			spaceBetween: 30,
			pagination: {
				el: '.swiper-pagination',
				clickable: true,
			},
		});
	</script>
	
	
</body>
</html>