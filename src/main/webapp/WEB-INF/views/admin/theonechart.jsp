<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.project.vo.SurveyVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.vo.OrderVO"%>
<%@page import="com.project.vo.IncomeVO"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<IncomeVO>	list = (ArrayList<IncomeVO>)request.getAttribute("theoneprice");
ArrayList<OrderVO>	list1 = (ArrayList<OrderVO>)request.getAttribute("paiksprice");	
ArrayList<OrderVO> list2 = (ArrayList<OrderVO>)request.getAttribute("hanshinprice");
int theoneprice = 0;
int paiksprice = 0;
int hanshinprice = 0;
int theoneprice1 = 0;
int theoneprice2 = 0;


DecimalFormat df = new DecimalFormat("###,###");
if(list != null){
	for(int i=0;i<list.size();i++) {
		theoneprice += list.get(i).getProfit();
	}
	}else{
		theoneprice = 0;
}
if(list1 != null){
	for(int i=0;i<list1.size();i++) {
		paiksprice += (int)list1.get(i).getSumPrice();
	}
	}else{
		paiksprice = 0;
}
if(list2 != null){
	for(int i = 0; i < list2.size();i++){
		hanshinprice += (int)list2.get(i).getSumPrice();
	}
	}else{
		hanshinprice = 0;
}

if(theoneprice != 0){
	System.out.println("원래 더원매출 : "+theoneprice);
	theoneprice =  theoneprice/10000;
	System.out.println("만단위매출"+theoneprice);
	theoneprice1 =  theoneprice/10000;
	System.out.println("억단위매출"+theoneprice1);
		if(theoneprice>10000){
			theoneprice2 = theoneprice-(theoneprice1*10000);
		}else{
			theoneprice2 = theoneprice;
		}
	System.out.println("천단위매출"+theoneprice2);		
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>   <!-- 달력 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterAdmin.css">
<title>Insert title here</title>
<script>
    $(function() {
      $("#datepicker1").flatpickr();
      $("#datepicker2").flatpickr();
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
      	<li><a href="${pageContext.request.contextPath}/headquarter/theonechart.do" aria-label="subemnu">기간별 매출</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/theonescore.do" aria-label="subemnu">지점별 평점</a></li>
        
      </ul>
    </li>
    
    <li><a href="#">창업지원</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/adminLaunchApproval.do" aria-label="subemnu">창업신청 승인</a></li>
       
      </ul>
    </li>
    
    <!-- 비대면강좌 서비스 -->
    
    <li><a href="">창업지원 교육자료</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/Study/studyflist" aria-label="subemnu">더원 교육자료</a></li>
        <li><a href="${pageContext.request.contextPath}/Study/list" aria-label="subemnu">신메뉴 교육자료</a></li>
      </ul>
    </li>
    <li><a href="#">재고관리</a>
      <ul id="sub-menu">
        <li><a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise" aria-label="subemnu">주문현황</a></li>
        <li><a href="${pageContext.request.contextPath}/headquarter/addmenu" aria-label="subemnu">메뉴 추가구성</a></li>
       
      </ul>
    </li>
    
  </ul>
</nav>
<div class="sub_section menu_wrap" style="width:100%";>
	<div class="container" style="margin-left:200px; margin-top:60px; height: 500px">
		<div style="width:600px; height: 500px; float: left">
		    <canvas id="myChart"></canvas>
		</div>
<script>
// 우선 컨텍스트를 가져옵니다. 
var ctx = document.getElementById("myChart").getContext('2d');
/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
*/
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["더원(만원)", "한신포차(원)", "백다방(원)"],
        datasets: [{
            label: '더원의 매출현황',
            data: [<%=theoneprice%>, <%=hanshinprice%>, <%=paiksprice%>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
                            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        maintainAspectRatio: false, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>
		<div style="height: 500px; text-align: center; margin-right: 200px;">
			<h2> 더원의 본사평가</h2><br/>
			<h3 style="border-bottom: 0px;">더원의 매출현황 : <%=theoneprice1%>억<%=theoneprice2%>만원</h3>
			<h3 style="border-bottom: 0px;">한신포차의 매출현황 : <%=df.format(hanshinprice)%>원</h3>
			<h3 style="border-bottom: 0px;">백다방의 매출현황 : <%=df.format(paiksprice) %>원</h3><br/>
			<h3 style="border-bottom: 0px;">※개선방안※<br/><br/>
			<%if(hanshinprice>paiksprice){
				%>백다방에 관리가 필요합니다!!<br/><br/>
			<% }else{
			%>한신포차에 관리가 필요합니다!!<br/><br/>
			<%	
			}
			%>
			</h3>		
		</div>
<div class="boardList" style="margin-top: 20px; margin-left: 50px;">
            <form action="${pageContext.request.contextPath}/headquarter/searchdate.do"> <%-- --%>
               <p>기&nbsp;&nbsp;간 : &nbsp;
                  <input type="text" id="datepicker1" name="fromdate"/>
               에서             
                  <input type="text" id="datepicker2" name="todate"/>
                  <input type="submit" id="btn" value="조&nbsp;회"/>
               </p>
            </form>
		</div>
	</div>
</div>
</body>
</html>