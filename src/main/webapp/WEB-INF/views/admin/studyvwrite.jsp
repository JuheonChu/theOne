<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- , 또는 날자 패턴을 넣을수 있는 태그 -->
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project.vo.StudyVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterAdmin.css">
<title>교육자료 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
table.q{
	border:1px solid black; 
	border-color: black;
	border-collapse: collapse;
	width: 80%;
	margin: 100px auto;
}

td.w{
	border:1px solid black; 
	border-color: black;
	height: 70px;
	text-align: center;	
}
div.form-group{
	width: 800px;
	}
input.form-control{
	width: 90%;
}
label {
	margin-top: 7px;
}
</style>
 <script type="text/javascript">
	$(function() {
	});
  </script>
</head>
<body>
<div class="sub_header sub_bg05">
			<div>
				<p class="company">THEONE</p>
				<p class="sub_tit">관리자페이지</p>
			</div>
		</div>
<nav role="navigation">
  <ul id="main-menu">
    <li><a href="#">매출현황</a>
    	<ul id="sub-menu">
        <li><a href="#" aria-label="subemnu">2020년 매출</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
      </ul>
    </li>
    
    <li><a href="#">창업지원</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/adminLaunchApproval.do" aria-label="subemnu">창업신청 승인</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
      </ul>
    </li>
    
    <!-- 비대면강좌 서비스 -->
    <li><a href="">MENU3</a>
      <ul id="sub-menu">
        <li><a href="" aria-label="subemnu">submenu</a></li>
        <li><a href="" aria-label="subemnu">submenu</a></li>
        <li><a href="" aria-label="subemnu">submenu</a></li>
        <li><a href="" aria-label="subemnu">submenu</a></li>
      </ul>
    </li>
    <li><a href="#">MENU4</a>
      <ul id="sub-menu">
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
        <li><a href="#" aria-label="subemnu">submenu</a></li>
      </ul>
    </li>
    <li><a href="#">MENU5</a></li>
    <li><a href="#">MENU6</a></li>
  </ul>
</nav>

<div style="width: 100%">
	<div style="float:left; width: 15%; height: 1150px; background-color: #edece8;" >
		<table class="q" >
			<tr >
				<td class="w"><a style="display: block" class="active" href="study.jsp">더원교육</a></td>
			</tr>
			<tr >
				<td class="w"><a style="display: block" href="study1.jsp">신메뉴교육</a></td>
			</tr>
		</table>
	</div>
	<div style="width: 85%; display: inline-block; height: 1000px; text-align:center; padding-top: 10px; background-color: cornsilk;">
		<h1>게시판 글 쓰기</h1><br/>
		<form action="writeAction">
		<table style="width: 800px; margin: 0 auto;" class="table">
			<tr>
				<td><label for="title">제목 : </label></td>
				<td><input type="text" class="form-control" id="title" name="title" required="required" placeholder="제목"/></td>
			</tr>
			<tr>
				<td><label for="url">주소 : </label></td>
				<td><input type="text" class="form-control" id="url" name="url" required="required" placeholder="주소"/></td>
			</tr>
			<tr>
				<td><label for="content">내용 : </label></td>
				<td><textarea style="resize: none;" class="form-control" rows="5" id="content" name="content" required="required" placeholder="내용"></textarea></td>
			</tr>
		</table>
		<button class="btn btn-primary">작성 완료</button>
  </form>
	</div>
</div>

</body>
</html>