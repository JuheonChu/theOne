<%@page import="com.project.vo.TempVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.vo.SurveyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<TempVO> list = (ArrayList<TempVO>)request.getAttribute("frankey");
ArrayList<SurveyVO> list1 = (ArrayList<SurveyVO>)request.getAttribute("paikslist");

int paiksflavor = 0;
int paiksdelivery = 0;
int paiksservice = 0;

ArrayList<String> flavorsolution =  new ArrayList<String>();
ArrayList<String> deliverysolution =  new ArrayList<String>();
ArrayList<String> servicesolution =  new ArrayList<String>();


for(int i=0;i<list1.size();i++){
	paiksflavor += (int)(list1.get(i).getFlavor()/list1.get(i).getOrdercount());
	paiksdelivery += (int)(list1.get(i).getDelivery()/list1.get(i).getOrdercount()); 
	paiksservice +=  (int)(list1.get(i).getService()/list1.get(i).getOrdercount());
}
	paiksflavor = paiksflavor/list1.size();
	paiksdelivery = paiksdelivery/list1.size();
	paiksservice = paiksservice/list1.size();

for(int i=0;i<list1.size();i++){
	int num  = (int)(list1.get(i).getFlavor()/list1.get(i).getOrdercount());
	int num1 = (int)(list1.get(i).getDelivery()/list1.get(i).getOrdercount()); 
	int num2 =  (int)(list1.get(i).getService()/list1.get(i).getOrdercount());

	if(num<paiksflavor){
		flavorsolution.add(list1.get(i).getFranchisekey());
	}
	if(num1<paiksdelivery){
		deliverysolution.add(list1.get(i).getFranchisekey());
	}
	if(num2<paiksservice){
		servicesolution.add(list1.get(i).getFranchisekey());
	}
}
if(flavorsolution.size()==0){
	flavorsolution.add("관리가 잘되고 있습니다.");
}else{
	for(int i=0;i<flavorsolution.size();i++){
		for(int j=0;j<list.size();j++){
			if(flavorsolution.get(i).equals(list.get(j).getFranchisekey())){
				flavorsolution.remove(i);
				flavorsolution.add(i, list.get(j).getLocation());
			}
		}
	}
}

if(deliverysolution.size()==0){
	deliverysolution.add("관리가 잘되고 있습니다.");
}else{
	for(int i=0;i<deliverysolution.size();i++){
		for(int j=0;j<list.size();j++){
			if(deliverysolution.get(i).equals(list.get(j).getFranchisekey())){
				deliverysolution.remove(i);
				deliverysolution.add(i, list.get(j).getLocation());
			}
		}
	}
}

if(servicesolution.size()==0){
	servicesolution.add("관리가 잘되고 있습니다.");
}else{
	for(int i=0;i<servicesolution.size();i++){
		for(int j=0;j<list.size();j++){
			if(servicesolution.get(i).equals(list.get(j).getFranchisekey())){
				servicesolution.remove(i);
				servicesolution.add(i, list.get(j).getLocation());
			}
		}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterAdmin.css">
<title>Insert title here</title>
<script>
	$(function() {
		$('.search').click(function() {
			var key = $('.location').val();
			window.open('/headquarter/locationsearch.do?location='+key,'지점검색','width=900,height=600');
			});
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
        <li><a href="#" aria-label="subemnu">지점별 평점</a></li>
        
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
        labels: ["맛평점", "배달평점", "서비스평점"],
        datasets: [{
            label: '더원의 평점현황',
            data: [<%=paiksflavor%>,<%=paiksdelivery%>, <%=paiksservice%>],
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
			<h3 style="border-bottom: 0px;">맛의 평점 : <%=paiksflavor%></h3>
			<h3 style="border-bottom: 0px;">배달 평점 : <%=paiksdelivery%></h3>
			<h3 style="border-bottom: 0px;">서비스 평점 : <%=paiksservice%></h3><br/>
			<h3 style="border-bottom: 0px;">※관리가 필요한 지점※<br/><br/>
			맛 개선이 필요 : <br/>
			<%for(int i=0;i<flavorsolution.size();i++){
				if(i==flavorsolution.size()-1){
					out.print(flavorsolution.get(i));
				}else{
					out.print(flavorsolution.get(i)+",");
				}
			}%>
			<br/><br/>배달 개선이 필요 : <br/>
			<%for(int i=0;i<deliverysolution.size();i++){
				if(i==deliverysolution.size()-1){
					out.print(deliverysolution.get(i));
				}else{
					out.print(deliverysolution.get(i)+",");
				}
			}%>
			<br/><br/>서비스 개선이 필요 : <br/>			
			<%for(int i=0;i<servicesolution.size();i++){
				if(i==servicesolution.size()-1){
					out.print(servicesolution.get(i));
				}else{
					out.print(servicesolution.get(i)+",");
				}
			}%>
			</h3>		
		</div>
<div class="boardList" style="margin-top: 20px; margin-left: 50px;">
      
            	  지 점 : 
                  <input type="text" class="location" name="franchise"/>
                  <button class="search">검색</button>
      
</div>
	</div>
</div>
</body>
</html>