<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 평가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
</style>
<script type="text/javascript">
$(function() {
	$('.survey span').click(function(){
		 $(this).parent().children('span').removeClass('on');
		 $(this).addClass('on').prevAll('span').addClass('on');
		 var point =  $(this).text();
		 $(this).parent().children('input').val(point);
		 return false;
		});
});
</script>
</head>
<body>
<%
String key = (String)request.getAttribute("franchisekey");
%>
<form action="survey.do" style="text-align: center; margin-top: 60px;">
<input type="hidden" name="fkey" value="1">
<input type="hidden" name="franchisekey" value="<%=key%>">
<p>맛</p>
<div class="survey">
  <span class="starR">1</span>
  <span class="starR">2</span>
  <span class="starR">3</span>
  <span class="starR">4</span>
  <span class="starR">5</span>
  <input class="flavor" type="hidden" name="flavor" value="">
</div>
<p>배송</p>
<div class="survey">
  <span class="starR">1</span>
  <span class="starR">2</span>
  <span class="starR">3</span>
  <span class="starR">4</span>
  <span class="starR">5</span>
  <input class="flavor" type="hidden" name="delivery" value="">
</div>
<p>서비스</p>
<div class="survey">
  <span class="starR">1</span>
  <span class="starR">2</span>
  <span class="starR">3</span>
  <span class="starR">4</span>
  <span class="starR">5</span>
  <input class="flavor" type="hidden" name="service" value="">
</div>
<p>기타</p>
<input type="text" name="etc"><br/>
<input type="submit" value="제출하기">
</form>
</body>
</html>