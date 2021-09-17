<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import = "java.util.*" %>
  <%@ page import = "com.project.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file ="./includeFile.jsp" %>
<title>Insert title here</title>
<% request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html;charset=UTF-8"); %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"> 
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script> 
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>



<title>빽다방 메인페이지</title>
<style>
.bx-wrapper .bx-pager {
    text-align: center;
    font-size: .85em;
    font-family: Arial;
    font-weight: bold;
    color: #666;
    padding-top: 20px;
    position: relative;
    top: -10px;
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
    pager:true,	//페이징 
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


<body>

<%
	List<ProductVO> bestproduts = (List<ProductVO>)session.getAttribute("bestproduts");   //Null Pointer
	List<ProductVO> bestProducts = null;
	
	if(bestproduts==null){
		ArrayList<Integer> bestmenu =(ArrayList<Integer>)session.getAttribute("bestmenu");
		if(bestmenu.get(0)!= 0 || bestmenu.get(1) != 0 || bestmenu.get(2) != 0){
			bestProducts = (List<ProductVO>)request.getAttribute("bestProducts");
		}
		  System.out.println("index.jsp에서 157번째줄에서 보는 bestproducts: <<<<>>>>> " +bestProducts);
		 session.setAttribute("bestproduts", bestProducts);
	}else{	   			  
			ArrayList<Integer> bestmenu =(ArrayList<Integer>)session.getAttribute("bestmenu");
			   if(bestmenu != null || bestmenu.size() != 0){
				   bestProducts = (List<ProductVO>)session.getAttribute("bestProducts");
				   session.removeAttribute("bestproduts");
				   System.out.println("index.jsp에서 165번째줄에서 보는 bestproducts: <<<<>>>>> " + bestproduts.toString());	   
				   session.setAttribute("bestproduts", bestProducts);
			   }  
	}

%>
<header id = "header" class="header">
		<%@ include file="./header.jsp"%>
</header>
	
	
	

		<div class="content">

	
		<div class="home__slider"> 
    		<div class="bxslider"> 
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_귀묘한스무디 (1).jpg" alt="그림1" data-slide-index="0">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                            	
                        	</div>
                    	</div>
                	</div>
                </div>
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_곡물3종.jpg" alt="그림2" data-slide-index="1">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_한끼라떼.jpg" alt="그림2" data-slide-index="2">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		
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
		
		
	<div class = "grid_wrap clear" style = "margin: 0 auto; position: relative; left: -170px;">
		<div class=  "r_box">
		
		
		
		</div>
			
			
		<div class="l_box clear" style = "text-align:center;">
                <div class="l_inner">
                    <h1 class="main_tit2 color-1">store</h1>
                    <p class="font-l">원하시는 지역의 매장을 검색해 보세요!</p>
                    <div class="store_search">
                        <form action="${pageContext.request.contextPath}/headquarter/gotostores.do" method="get">
                            <input type="hidden" name="search_string" placeholder="Find a store in your area!">
                            <button class="ok" type="submit" name=""><img src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/search-ico.png" alt="검색"></button>
                        </form>
                    </div>
                </div>
                <div class="l_inner">
                    <h1 class="main_tit2 color-1">franchise</h1>
                    <p class="font-l">빽다방 창업안내를 도와드리겠습니다.</p>
                    <a class="btn st-1" href="${pageContext.request.contextPath }/headquarter/launchbusiness.do"></a>
                </div>
        </div>
	</div>

	
	<section class="main_sec row-4" style ="text-align:center;">
        <div class="sns_section">
            <div class="container">
                <div class="text-center">
                    <p class="font-2">SNS</p>
                    <p class="tag"><span>#빽다방</span><span>#빽다방신메뉴</span><span>#빽다방이벤트</span></p>
                </div>
                <ul class="sns_ico" style = "display:inline-flex; list-style:none;margin-top:20px;">
                    <li><a href="https://ko-kr.facebook.com/ipaikscoffee/" target="_blank"><img src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/facebook-ico.png" alt="facebook"></a></li>
                    <li><a href="https://www.instagram.com/paikscoffee_official/" target="_blank"><img style = "margin-left:30px;" src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/insta-ico.png" alt="instagram"></a></li>
                </ul>
            </div>
        </div>

    </section>
		



	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<%--	

<div class = "content">
	<div class="home__slider"> 
    		<div class="bxslider"> 
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_귀묘한스무디 (1).jpg" alt="그림1" data-slide-index="0">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                            	<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
                </div>
        		<div>
        			<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_곡물3종.jpg" alt="그림2" data-slide-index="1">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_한끼라떼.jpg" alt="그림2" data-slide-index="2">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div>
        		
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_몽땅쉐이크.jpg" alt="그림2" data-slide-index="3">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_긴페스츄리와플흑당.jpg" alt="그림2" data-slide-index="4">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_콜드브루-1.jpg" alt="그림2" data-slide-index="5">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
        		
        		<div>
	        		<img src="${pageContext.request.contextPath}/resources/images/paikdabang/main_달고나크런치-1.jpg" alt="그림2" data-slide-index="6">
        			<div class="mst_wrap">
                    	<div class="txt_slider">
                        	<div>
                        		<p class="tit"><br/>
                                <span></span></p>
                            	<p>
                                <br></p>
                        	</div>
                    	</div>
                	</div>
        		</div> 
    		</div> 
    		
    		
		</div> 
		
		
		<div class = "main_section">
			<section class = "main_sec row-1">
				<div class = "container space" style = "margin-top:-59px;">
					<img class = "pc_ver" src = "http://paikdabang.com/wp-content/themes/paikdabang/assets/images/main_sec2.jpg" style = "width:1200px;">
					<div class = "container" style = "width: 100%;position: absolute;top: 610px;left: 0%;">
					<h1 class="main_tit font-eb color-1" style = "margin-top:-600px;">
						<span class="font-l" style = "color:brown; font-weight:bold;">FRESH<br/>COFFEE</span><br/>
					</h1>
					<a class="btn st-1" href=""><span></span></a>
					</div>
				</div>
			</section>
			
			
			<section class = "main_sec row-2">
				<img class="pc_ver" src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/main_sec3.jpg" alt="" style= "margin-top:-4px;width:100%">
				<div class = "container space">
					<h1 class = "main_tit" style = "color:#93a03d; margin-top:-576px;width:100%;font-weight:bold;">VARIOUS<br/>BEVERAGE</h1>
					<h1 class = "sub_tit" style = "color:#93a03d; font-weight:bold;">에이드, 티, 주스등 취향대로 <br/>골라먹는 즐거움!</h1>
				</div>
			</section>
			
			
			<section class = "main_sec row-3">
				<div class = "grid_wrap clear">
					<div class = "m10-col-6 clear">
						<img class="pc_ver" src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/main_sec5.jpg" alt="" style = "width:100%;margin-top:430px;">
						<div class = "inner" style = "margin-top:-715px;">
							<h1 class="main_tit font-bl" style = "color:purple; font-weight: bold">TASTY<br>ICE CREAM<br>DESSERT</h1>
                    		<h2 class="sub_tit" style = "color:purple;">달콤한 아이스크림부터<br>든든한 브레드 까지!</h2>
						</div>
					</div>
				</div>
			</section>
			


	<section class="main_sec row-4" style ="margin-top:600px; text-align:center;">
        <div class="sns_section">
            <div class="container">
                <div class="text-center">
                    <p class="font-2">PAIK’S COFFEE SNS</p>
                    <p class="tag"><span>#빽다방</span><span>#빽다방신메뉴</span><span>#빽다방이벤트</span></p>
                </div>
                <ul class="sns_ico" style = "display:inline-flex; list-style:none;margin-top:20px;">
                    <li><a href="https://ko-kr.facebook.com/ipaikscoffee/" target="_blank"><img src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/facebook-ico.png" alt="facebook"></a></li>
                    <li><a href="https://www.instagram.com/paikscoffee_official/" target="_blank"><img style = "margin-left:30px;" src="http://paikdabang.com/wp-content/themes/paikdabang/assets/images/insta-ico.png" alt="instagram"></a></li>
                </ul>
            </div>
        </div>

    </section>
		
		</div>
</div>
 --%>
<footer id = "footer" class = "footer">
	<%@ include file = "./footer.jsp" %>
</footer>
</body>
</html>