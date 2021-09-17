<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>

<body>

	

	<div class="footer_wrap">
		<div class="footer">
			<h1 class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/The One -logo (1).png" alt="더원코리아" style="width: 105px;">
			</h1>
			<div>
				<ul>
					<li><a style="color: #d51f26; font-weight: bold;"
						href="/agreement/">개인정보처리방침</a></li>
					<li><a href="/business-center/business-story/">상생경영</a></li>
					<li><a href="/site-map/">사이트맵</a></li>
					<li><a href="/theborn-notice/employ/">채용</a></li>
				</ul>
				<p>
					<span class="txt">(주)더원코리아</span><span class="bar">|</span><span
						class="txt">사업자등록번호 211-86-00870</span><span class="bar">|</span><span
						class="txt">대표이사 추주헌</span> <br>
					<span class="txt">주소: 서울시 강남구 봉은사로 1길 39 유성빌딩 5~6층</span><span
						class="bar">|</span><span class="txt">팩스: 02-511-3864</span> <br>
					<span class="txt">본사 대표전화 및 가맹상담전화 : 02-549-3864</span><span
						class="bar">|</span><span class="txt">빽다방 가맹상담전화:
						02-3447-0410</span><span class="bar">|</span><span class="txt">고객센터:
						1544-2360</span>
				</p>
				<p>COPYRIGHTⓒ 2017 THEBORN KOREA INC. ALL RIGHTS RESERVED</p>
			</div>

			<div class="brand-site">
				<select name="" id="goto_familiy_site" onchange="if(this.selectedIndex){this.blur();window.open(options[selectedIndex].value);}">
					<option value="" selected="">패밀리 사이트 바로가기</option>
					<option value="http://newmaul.com/">새마을식당</option>
					<option value = "http://192.168.6.118:8080/gotoPaikDabang.do">빽다방</option>
					<option value="http://zzambbong.com/">홍콩반점</option>
					<option value="http://www.bornga.co.kr/">본가</option>
					<option value="http://192.168.6.118:8080/product/hanshin/gotoHanshin.do">한신포차</option>
					<option value="http://www.paiks-pan.com/">백철판</option>
					<option value="http://paiksbeer.com/">백스비어</option>
					<option value="http://dolbaegi.com/">돌배기집</option>
				</select>
			</div>
		</div>
	</div>









</body>
</html>