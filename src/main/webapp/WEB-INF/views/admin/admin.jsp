<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterAdmin.css">
<title>Insert title here</title>
</head>
<body>

<div class="sub_header sub_bg05">
			<div>
				<p class="company">THEONE</p>
				<p class="sub_tit">관리자페이지</p>
				
			</div>
		</div>
.


<nav role="navigation">
  <ul id="main-menu">
    <li><a href="#">더원관리</a>
    	<ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/theonechart.do" aria-label="subemnu">기간별 매출</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/theonescore.do" aria-label="subemnu">지점별 평점</a></li>
        
      </ul>
    </li>
    
    <!-- 창업지원 -->
    <li><a href="#">창업지원</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/adminLaunchApproval.do" aria-label="subemnu">창업신청 승인</a></li>
        
      </ul>
    </li>
    
   
    <!-- 비대면강좌 서비스 -->
    <li><a href="">교육자료</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/Study/studyflist" aria-label="subemnu">더원 교육자료</a></li>
        <li><a href="${pageContext.request.contextPath}/Study/list" aria-label="subemnu">신메뉴 교육자료</a></li>
      </ul>
    </li>
    
    <!-- 가맹점들로부터의 재고관리 -->
    <%-- 메뉴 --%>
    <li><a href="#">재고관리</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise" aria-label="subemnu">주문현황</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/addmenu" aria-label="subemnu">메뉴 추가구성</a></li>
      </ul>
    </li>
    
  </ul>
</nav>



</body>
</html>