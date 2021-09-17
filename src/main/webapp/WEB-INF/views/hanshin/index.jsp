<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한신포차</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/hanshin/hanshinmain.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/hanshin/swiper.css"/>
	<!-- Link Swiper's CSS -->
	<link rel="stylesheet" href="https://swiperjs.com/package/swiper-bundle.min.css">
</head>

<body>

<%System.out.println(request.getServletContext());

	List<ProductVO> bestproduts = (List<ProductVO>)session.getAttribute("bestproduts");   //Null Pointer
	List<ProductVO> bestProducts = null;
	
	if(bestproduts == null){
		ArrayList<Integer> bestmenu =(ArrayList<Integer>)request.getAttribute("bestmenu");
		if(bestmenu.get(0)!= 0 || bestmenu.get(1) != 0 || bestmenu.get(2) != 0){
			bestProducts = (List<ProductVO>)request.getAttribute("bestProducts");
		}
		  System.out.println("index.jsp에서 157번째줄에서 보는 bestproducts: <<<<>>>>> " +bestProducts);
		 session.setAttribute("bestproduts", bestProducts);
	}else{	   			  
			ArrayList<Integer> bestmenu =(ArrayList<Integer>)request.getAttribute("bestmenu");
			   if(bestmenu!=null){
				   bestProducts = (List<ProductVO>)request.getAttribute("bestProducts");
					session.removeAttribute("bestproduts");
				   System.out.println("index.jsp에서 165번째줄에서 보는 bestproducts: <<<<>>>>> " + bestproduts.toString());	   
				   session.setAttribute("bestproduts", bestProducts);
			   }  
	}

%>
	<!-- Header -->
	<header>
		<%@ include file="./header.jsp"%>
	</header>
  	
	<!-- Body -->
			<!-- 헤더 아래 슬라이드 이미지 -->
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide" id="slide1">
					<div class="main_text_h2">
						<h2 class="slide_sentence">
							NEVER BEEN<br/>
							CLOSED<br/>
							SINCE 1998
						</h2>
					</div>
					<div class="main_text_p">
						<p class="slide_sentence">
							1980년~1990년 후반까지 길거리에서 쉽게 볼 수 있던 포장마차는 퇴근길 맛있는 안주로 출출함을 달래주고 피로를 녹여주었으며,<br/>
							특유의 정겨운 분위기로 많은 이들의 발걸음을 붙잡았습니다. 한신포차는 이러한 길거리 포장마차의 분위기를 실내<br/>
							에 연출한 대한민국 최초의 대형 실내 포장마차로써,<br/>
							20여 년이 흐른 오늘날까지 특유의 분위기와 한신닭발, 옛날통닭, 해물모둠볶음 등의 특별한 안주로 많은 사랑을 받고 있습니다.
						</p>
					</div>
				</div>
				<div class="swiper-slide" id="slide2">
					<div class="main_text_h2">
						<h2 class="slide_sentence">
							멈출수 없는<br/>
							매력의 매운맛,<br/>
							한신닭발
						</h2>						
					</div>
					<div class="main_text_p">
						<p class="slide_sentence">
							보글보글 끓여 먹는 매운 국물 닭발의 원조! 한신닭발은 화끈하고 부드러운 맛으로 많은 사랑을 받고 있는 한신포차의 대표 메뉴입니다. 콩나물<br/>
							을 넣어 아삭한 식감을 더하고, 동글동글 직접 만들어 먹는 셀프주먹밥을 추가하여 맛을 한층 더 풍부하게, 그리고 닭발을 다 먹은 후 남은 양념<br/>
							에 밥을 볶아 마무리 하며 한신닭발을 완벽하게 즐겨보세요!
						</p>
					</div>
				</div>
				<div class="swiper-slide" id="slide3">
					<div class="main_text_h2">
						<h2 class="slide_sentence">
							대한민국<br/>
							대표 실내 포장마차<br/>
							한신포차
						</h2>
					</div>
					<div class="main_text_p">
						<p class="slide_sentence">
							북적대는 포차 속 정겨운 사람 냄새, 주방에서 들려오는 맛있는 소리,<br/>
							특별한 안주가 어우러져 누구나 부담없이<br/>
							술잔을 기울일 수 있는 편안함이 있습니다.
						</p>
					</div>
				</div>
			</div>
			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
		</div>
	
	<div class="bodyContent">
		<div class="menu1" style = "display:flex;">
			<div class="signatureMenuDetail1">
				<h2>한신 닭발</h2>
				<h3>중독성 강한 한신포차의 대표메뉴!</h3>
				<p>보글보글 끓여먹는 매운 닭발 메뉴입니다.<br/>
				      콩나물을 넣어 아삭한 식감을 더하고,<br/>
				      매운 맛을 잡아주는 셀프주먹밥과<br/>
				      함께 드시면 더욱 맛있습니다.
				</p>
			</div>
			<div class="signatureMenuImg1"></div>
		</div>
	
	
		<div class="menu2" style = "display:flex;">
			<div class="signatureMenuDetail2"">
				<h2>치즈돼지고추장바베큐</h2>
				<h3>매콤 바베큐 &<br/>모짜렐라 치즈의 완벽한 조화!</h3>
				<p>직화로 구워낸 매콤한 양념의 돼지고기를<br/>
				      모짜렐라 치즈와 함께 먹는 메뉴입니다.</p>
			</div>
			<div class="signatureMenuImg2"></div>
		</div>
	
	
		<div class="menu3" style = "display:flex;">
			<div class="signatureMenuDetail3">
				<h2>해물모둠볶음</h2>
				<h3>튀긴 소면 위에 푸짐한<br/>
					해물이 한 가득!</h3>
				<p>접시 모양의 소면 튀김 위에 다양한 해산물,<br/>
				       야채를 푸짐하게 볶아 올린 메뉴입니다.<br/>
				   Tip. 남은 소스에 소면을 비벼 드셔보세요!
				</p>
			</div>
			<div class="signatureMenuImg3"></div>
		</div>
		
		
		
	</div>
	<!-- Footer -->
	<footer>
		<%@ include file="./footer.jsp"%>
	</footer>
	
	
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