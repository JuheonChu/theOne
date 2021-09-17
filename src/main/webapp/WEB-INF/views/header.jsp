<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.MemberVO"%>
<%@ page import="java.io.*"%>
<%@ page import="com.project.service.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">


<style>
.d-content:hover .row {
	display: block;
}

.d:hover .d-content {
	display: block;
	position: fixed;
}

.d-content .row {
	padding: 0px 0 0px;
	display: block;
}
</style>
<%
	MemberVO member = null;
	if (session.getAttribute("loginMember") != null) {
	   member = (MemberVO) session.getAttribute("loginMember");
	} else {
	   System.out.println("loginMember가 null입니다.");
	}
	
	String userid = null;
	if (session.getAttribute("userid") != null) {
	   userid = session.getAttribute("userid").toString();
	} else {
	   System.out.println("userid가 null입니다.");
	}
	
	if(request.getAttribute("register")!= null){
	   %>
	   <script>alert("해당 상품이 등록되었습니다!");</script>
	   <%
	}
	if(request.getAttribute("signupmember")!=null){
	   %>
	   <script>alert("등록되었습니다!");</script>
	   <%
	}
	if(request.getAttribute("franchiseSignup") != null){
	   %>
	   <script>alert("신청되었습니다!");</script>
	   <%
	}
	
	//MessageService messageservice = (MessageService)session.getAttribute("tempMessage");
	//ProductService productservice = (ProductService)request.getAttribute("productservice");
	//System.out.println(productservice.selectPdt(0).toString());
	//System.out.println(messageservice.toString());
	MessageService messageservice = (MessageService)session.getAttribute("tempMessage");
	int receivedMessages = messageservice.countMessages(userid);
	int needtoreadmessages = messageservice.mustreadMessages(userid);
%>
</head>
<body>
	<nav class="navbar">
		<a href="${pageContext.request.contextPath}/headquarter/" style="margin-right: 0px; margin-left: 10px; width: 150px; margin-top: -0px;">
			<img src="${pageContext.request.contextPath}/resources/images/The One -logo (1).png" alt="더원코리아" style="width: 105px;">
		</a>

		<div class="d">
			<button class="d-btn">THE ONE</button>
			<div class="d-content">
				<div class="row">
					<div class="column">
						<p>
							글로벌 외식기업<br /> ALLONE코리아에 대해 <br />알려드립니다!
						</p>
						<a href="" style="margin-left: 20px;"><img
							src="${pageContext.request.contextPath}/resources/images/footprint01.jpg"
							alt="발자취"><br />&nbsp;&nbsp;발자취</a> <a href=""
							style="margin-right: 15px;"><img
							src="${pageContext.request.contextPath}/resources/images/footprint02.jpg"
							alt="CEO 백종원" style="margin-left: 15px;"><br />&nbsp;&nbsp;CEO
							추주헌</a> <a href="" style="margin-right: 5px;"><img
							src="${pageContext.request.contextPath}/resources/images/footprint03.jpg"
							alt="글로벌 더본" style="margin-left: 15px;"></br>&nbsp;글로벌 더본</a> <a><img
							src="${pageContext.request.contextPath}/resources/images/brand_bg.jpg" /></a>

					</div>
				</div>
			</div>
		</div>


		<div class="d">
			<button class="d-btn">브랜드</button>
			<div class="d-content">
				<div class="row">
					<div class="column">
						<p>
							글로벌 외식기업<br /> 더본코리아에 대해 <br />알려드립니다!
						</p>
						<a href="" style="margin-left: 20px;"><img
							src="${pageContext.request.contextPath}/resources/images/brand01.jpg"
							alt="대표 브랜드"><br />대표 브랜드</a> <a href=""
							style="margin-right: 15px;"><img
							src="${pageContext.request.contextPath}/resources/images/brand02.jpg"
							alt="글로벌 브랜드" style="margin-left: 15px;"><br />글로벌 브랜드</a> <a
							href="" style="margin-right: 5px;"><img
							src="${pageContext.request.contextPath}/resources/images/brand03.jpg"
							alt="테스트 브랜드" style="margin-left: 15px;"></br>테스트 브랜드</a> <a><img
							src="${pageContext.request.contextPath}/resources/images/brand_bg.jpg" /></a>
					</div>
				</div>
			</div>
		</div>

		<div class="d">
			<button class="d-btn">매장찾기</button>
			<div class="d-content">
				<div class="row">
					<div class="column">
						<p>
							글로벌 외식기업<br /> ALL FOR ONE 코리아에 대해 <br />알려드립니다!
						</p>
						<a
							href="${pageContext.request.contextPath}/headquarter/gotostores.do"
							style="margin-left: 15px;"><img
							src="${pageContext.request.contextPath}/resources/images/store01.jpg"
							alt="국내매장"><br />국내매장</a> <a href=""
							style="margin-right: 5px;"><img
							src="${pageContext.request.contextPath}/resources/images/store02.jpg"
							alt="해외매장"><br />해외매장</a> <a href=""
							style="margin-right: 5px;"><img
							src="${pageContext.request.contextPath}/resources/images/store_bg.jpg"
							alt=""></a>

					</div>
				</div>
			</div>
		</div>


		<div class="d">
			<button class="d-btn">창업안내</button>
			<div class="d-content">
				<div class="row">
					<div class="column">
						<p>
							글로벌 외식기업<br /> ALL FOR ONE 에대해 <br />알려드립니다!
						</p>
						<a href="" style="margin-left: 15px;"><img
							src="${pageContext.request.contextPath}/resources/images/business01.jpg"
							alt="창업절차"><br />창업절차</a> <a href=""
							style="margin-right: 5px;"><img
							src="${pageContext.request.contextPath}/resources/images/business02.jpg"
							alt="상생경영"><br />상생경영</a> <a href=""><img
							src="${pageContext.request.contextPath}/resources/images/business05.jpg"
							alt="창업설명회장 안내" style="margin-left: 10px;"><br />창업설명회장 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;안내</a>
						<a href="${pageContext.request.contextPath}/headquarter/calendar.do?userid=<%=userid%>""><img
							src="${pageContext.request.contextPath}/resources/images/business03.jpg"
							alt="창업설명회 일정" style="margin-left: 20px;"><br />창업설명회 일정</a> <a
							href=""><img
							src="${pageContext.request.contextPath}/resources/images/business04.jpg"
							alt="창업설명회 신청" style="margin-left: 22px;"><br />창업설명회 신청</a> <a
							href="${pageContext.request.contextPath}/headquarter/launchbusiness.do"><img
							src="${pageContext.request.contextPath}/resources/images/business06.png"
							alt="창업문의"><br />창업문의</a>
					</div>
				</div>
			</div>
		</div>


		<div class="d">
			<button class="d-btn">더본소식</button>
			<div class="d-content">
				<div class="row">
					<div class="column">
                  <p>
                     글로벌 외식기업<br /> 더본코리아에 대해 <br />알려드립니다!<br />
                  </p>
                  <a href=""><img
                     src="${pageContext.request.contextPath}/resources/images/news01-1.jpg"
                     alt="뉴스"><br />&nbsp;&nbsp;&nbsp;뉴스</a> <a href=""><img
                     src="${pageContext.request.contextPath}/resources/images/news04-1.png"
                     alt="미디어"><br />&nbsp;&nbsp;미디어</a> <a href=""><img
                     src="${pageContext.request.contextPath}/resources/images/news02-1.jpg"
                     alt="가맹점 활동 및 소식" style="margin-left: 37px;"><br />가맹점 활동및
                     소식</a> <a href="${pageContext.request.contextPath}/headquarter/person"><img
                     src="${pageContext.request.contextPath}/resources/images/news03-1.jpg"
                     alt="채용"><br />&nbsp;&nbsp;&nbsp;채용</a>
               </div>

				</div>
			</div>
		</div>
		
		
		
		
		

		<a href="${pageContext.request.contextPath}/reviewBoard/list">고객의
			소리</a>

		<div class="login">
			<%
				if (member == null) {
			%>
			<a href="${pageContext.request.contextPath}/member/login.do"
				style="font-size: 8px;
    float: right;
    position: relative;
    right: -350px;">로그인/회원가입</a>
			<%
				} else {
			%>
			<%
				if (member.getTier().equals("headquarter")) {
			%>
			<a href="${pageContext.request.contextPath}/headquarter/admin.do" style = "font-size:15px;">
				<%=member.getName()%>님 환영합니다.&nbsp;&nbsp;&nbsp; THE ONE 관리자페이지
			</a>
			<!-- 사업정보, 매출현황, 그 외모든 통계들 -->
			&nbsp;&nbsp;
			<input type="button" value="로그아웃" style="margin-left: 0px; margin-right: 15px; margin-top: 13px;" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">
			<%
				} else if (member.getTier().equals("franchise")) {
			%>
			<a>
			<%=member.getName()%> 님 환영합니다.</a> &nbsp;
			 <a class = "messageBox" href="${pageContext.request.contextPath}/member/mypage.do?userId=<%=session.getAttribute("userid") %>" 
			 style = "font-size:11px;">
			 		MYPAGE(<%=needtoreadmessages %>/<%=receivedMessages %>)
			 </a>
			 <input type="button" value="내지점 바로가기" style = "font-size:11px;" onclick="location.href='<%=member.getUrl()%>?franchisekey=<%=member.getFranchisekey()%>&selectmenu=<%=member.getSelectmenu()%>&tier=<%=member.getTier()%>'" class = "btn btn-primary">&nbsp;&nbsp;
			 <input type="button" value="로그아웃" style="margin-left: 0px; margin-right: 5px; margin-top: 0px;font-size:11px;position: relative;
    top: 0px;" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'" class = "btn btn-danger">
			  <a href="${pageContext.request.contextPath}/member/message" class="notification" style = "    height: 32px;
    position: relative;
    top: 0px;">
			 	<span>메시지함</span>
  				<span class="badge"><%=needtoreadmessages %></span>
			  </a>
			<%
				} else {
			%>
			<a>
			<%=member.getName()%> 님 환영합니다.</a>&nbsp;
			<a href="${pageContext.request.contextPath}/member/mypage.do?userId=<%=session.getAttribute("userid") %>" style = "font-size:11px;">
				MYPAGE(<%=needtoreadmessages %>/<%=receivedMessages %>)
			</a>
			<input type="button" value="로그아웃" style="margin-left: 0px; margin-right: 8px; margin-top: 13px;position: relative;
    top: -8px;" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'" class = "btn btn-danger">
			<a href="${pageContext.request.contextPath}/member/message" class="notification">
			 	<span>메시지함</span>
  				<span class="badge"><%=needtoreadmessages %></span>
			</a>
			<%
				}
			%>
			<%
				}
			%>
		</div>

	</nav>
</body>
</html>