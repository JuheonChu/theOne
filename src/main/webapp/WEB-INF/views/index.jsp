<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<% request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html;charset=UTF-8"); %>
<%@ include file ="./includeFile.jsp" %>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"> 
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script> 
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<%
	if("franchiseSignup".equals((String)request.getAttribute("franchiseSignup"))){
%>
	<script>alert("창업신청이 완료되었습니다.")</script>
<%		
	}
%>



<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/index.css">
<style>
.slider_btn {
    position: absolute;
    top: 100%;
    left: 6%;
    width: 158.95px;
    height: 31px;
    border: 1px solid #596570;
    display: block;
}
</style>
</head>
<script> 
$(document).ready(function(){ 
    var main = $('.bxslider').bxSlider({ 
    mode: 'fade', 
    auto: true,	//자동으로 슬라이드 
    controls : true,	//좌우 화살표	
    autoControls: false,	//stop,play 
    pager:false,	//페이징 
    pageSelector: '.pager',
    nextSelector: '.next-slide',
    nextText: '>', 
    prevSelector: '.prev-slide',
    prevText: '<',

    pause: 30000, 
    autoDelay: 0,	
    slideWidth: 1700,
    speed: 50, 
    stopAutoOnclick:true,

    onSlideBefore: function($slideElement, oldIndex, currentIndex){
		$('.num').text((main.getCurrentSlide()+1)+"/"+main.getSlideCount());
    },
    
    onSlideAfter: function($slideElement, oldIndex, currentIndex){   
        
    	 // $('.num').text((main.getCurrentSlide()+1)+'/'+main.getSlideCount());  
    }

    	
	}); 
   
$(".bx-stop").click(function(){	// 중지버튼 눌렀을때 
    main.stopAuto(); 
    
    $(".bx-start").show(); 
    return false; 
}); 

$(".bx-start").click(function(){	//시작버튼 눌렀을때 
    main.startAuto(); 
    
    $(".bx-stop").show(); 
    return false; 
}); 

$( '.prev' ).on( 'click', function () {
	   main.goToPrevSlide();  //이전 슬라이드 배너로 이동
	   return false;              //<a>에 링크 차단
	  });

	    //다음 버튼을 클릭하면 다음 슬라이드로 전환
	  $( '.next' ).on( 'click', function () {
	   main.goToNextSlide();  //다음 슬라이드 배너로 이동
	   return false;
	  } );





	  var didScroll;
	  var lastScrollTop = 0;
	  var delta = 5;
	  var navbarHeight = $('header').outerHeight();

	  $(window).scroll(function(event){
	      didScroll = true;
	  });

	  setInterval(function() {
	      if (didScroll) {
	          hasScrolled();
	          didScroll = false;
	      }
	  }, 250);

	  function hasScrolled() {
	      var st = $(this).scrollTop();
	      
	      // Make sure they scroll more than delta
	      if(Math.abs(lastScrollTop - st) <= delta)
	          return;
	      
	      // If they scrolled down and are past the navbar, add class .nav-up.
	      // This is necessary so you never see what is "behind" the navbar.
	      if (st > lastScrollTop && st > navbarHeight){
	          // Scroll Down
	          $('header').removeClass('.header').addClass('nav-up');
	      } else {
	          // Scroll Up
	          if(st + $(window).height() < $(document).height()) {
	              $('header').removeClass('nav-up').addClass('header');
	          }
	      }
	      
	      lastScrollTop = st;
	  }

  
}); 
</script> 

<body style = "padding-top:45px;">


	<header id = "header" class="header">
		<%@ include file="./header.jsp"%>
	</header>

	<div class="content">

	
		<div class="home__slider"> 
    		<div class="bxslider"> 
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/main1.jpg" alt="그림1">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                            	<p class="tit">글로벌 더본코리아<br/>
                                <span>한국을 넘어 해외 곳곳으로</span></p>
                            	<p>더본의 ORIGINAL KOREAN TASTE,
                                <br>이제 세계 각지에 한식의 맛을 전하고 있습니다.</p>
                        	</div>
                    	</div>
                	</div>
                </div>
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/main_slider03.jpg" alt="그림2">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit">SINCE 1993,<br/>
                                <span>20여 년, 한결같은 뜻으로</span></p>
                            	<p>더본은 20여 년 외식 사업 노하우를 바탕으로,
                                <br>모든 고객 여러분께 즐거운 식사를 전해 드리고자 노력하겠습니다.</p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/3_slide3.jpg" alt="그림2">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit">만족스러운 한끼를 위해<br/>
                                <span>고민을 멈추지 않는 곳</span></p>
                            	<p>모든 고객이 부담 없는 가격에 기분 좋은 식사를,
                                <br>더본이 지향하는 합리적 외식문화이자 기업의 핵심가치입니다.</p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
    		</div> 
    		
    		<div class = "slider_btn slider_btn01" style = "display:-webkit-inline-box;">
    			<p class = "num"><a style = "margin:-5px auto;">1/3</a></p>
    			<p class = "prev">
    				<a class="bx-prev" href="" style = "margin:-2px auto; line-height:0px;"><i class="fas fa-angle-left" aria-hidden="true"></i></a>
    			</p>
    			<p class="next" ><a class="bx-next" href="" style = "margin:-2px auto; line-height:0px;"><i class="fas fa-angle-right" aria-hidden="true"></i></a></p>
    			<p class="auto">
    				<a class="bx-start" href="" style = "margin:-2px auto; line-height:0px;">
    							<i class="fa fa-play" aria-hidden="true"></i>
    				</a>
    			</p>
    			
    			<p class = "autoStop">
 					<a class="bx-stop" href=""  style = "margin:-2px auto; line-height:0px;">
    					<i class="fa fa-pause" aria-hidden="true"></i>
    				</a>
    			</p>
    		</div>
		</div> 



		<div class="mn_content" style = "margin-top:-60px;">
    <ul>
        <li>
            <div>
                <p class="category">The One</p>
                <dl>
                    <dt>더원 코리아</dt>
                    <dd>더원코리아를 소개합니다.</dd>
                </dl>
                <a href="" class="more_btn">MORE +</a>
            </div>
        </li>
        <li>
            <div>
                <p class="category">Brand</p>
                <dl>
                    <dt>브랜드</dt>
                    <dd>더원 코리아의 다양한 브랜드를 소개합니다. </dd>
                </dl>
                <a href="/brand/representation/" class="more_btn">MORE +</a>
            </div>
        </li>
        <li>
            <div>
                <p class="category">Store</p>
                <dl>
                    <dt>매장찾기</dt>
                    <dd>주변 가맹점의 위치를 찾아보세요.</dd>
                </dl>
                <a href="/store/domestic-store/" class="more_btn">MORE +</a>
            </div>
        </li>
        <li>
            <div>
                <p class="category">FRANCHISE</p>
                <dl>
                    <dt>창업문의</dt>
                    <dd>지금 바로 더본코리아와 함께하세요.</dd>
                </dl>
                <a href="/business-center/inquiry/" class="more_btn">MORE +</a>
            </div>
        </li>
		
    </ul>
</div>

<div class="quick">
			<div>
				<div class="news">
					<p class="category">news</p>
					<p>
						<a href="">한신포차x요기요 슈퍼레드위크2.0 프로모션</a><span>2020-07-03</span>
					</p>
				</div>

				<div class="quick_m">
					<ul>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/quick_m02.jpg" alt="창업센터">&nbsp;&nbsp;창업센터</a> &nbsp;&nbsp;
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/quick_m03.jpg"
							alt="고객의 소리">&nbsp;&nbsp;고객의 소리</a> &nbsp;&nbsp;
						<a href="" target="_blank"><img
							src="${pageContext.request.contextPath}/resources/images/quick_m04.jpg" alt="공식 유튜브">&nbsp;&nbsp;공식
							유튜브</a> &nbsp;&nbsp;
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/naver_logo.jpg"
							alt="네이버 공식 포스트">&nbsp;&nbsp;공식포스트</a>

					</ul>
				</div>
			</div>
		</div>

	</div>



	<footer class="footer">
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>