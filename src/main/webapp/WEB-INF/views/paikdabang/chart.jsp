<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.project.vo.ProductVO" %>
<%@ page import="com.project.vo.SurveyVO" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/paikdabang/itemlist.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	$("#selectBox").change(function() {
		var num = $(this).val();
		if(num==("매출현황")){
		location.href="saleschart.do?franchisekey=<%=request.getParameter("franchisekey")%>"}
		});
});
</script>
</head>
<body>
<%
List<SurveyVO> list = (List<SurveyVO>)request.getAttribute("info"); //franchisekey에 해당하는 survey
System.out.println("프랜차이즈에 정보 사이즈"+list.size());
List<SurveyVO> list1 = (List<SurveyVO>)request.getAttribute("paikaverage"); 
System.out.println(list1.toString());

int flavor = 0;
int delivery = 0;
int service = 0;
int count=0;
if(list1.size()!=0){
for(int i=0;i<list1.size();i++){
		flavor += list1.get(i).getFlavor();
		delivery += list1.get(i).getDelivery();
		service += list1.get(i).getService();
		count += list1.get(i).getOrdercount();
} 
	flavor = (int)flavor/count;
	delivery = (int)delivery/count;
	service = (int)service/count;
}else{
	
}

int franflavor =  0;	
int frandelivery = 0;	
int franservice = 0;	

if(list.size()!=0){
	franflavor = (list.get(0).getFlavor())/(list.get(0).getOrdercount());
	frandelivery = (list.get(0).getDelivery())/(list.get(0).getOrdercount());
	franservice = (list.get(0).getService())/(list.get(0).getOrdercount());
}else{
}

%>
<header class = "header">
	<%@ include file="./header.jsp"%>
</header>

<div class="sub_section menu_wrap">
	<div class="container" style="height: 500px">
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
        labels: ["맛", "배달", "서비스"],
        datasets: [{
            label: '${location}점 만족도',
            data: [<%=franflavor%>, <%=frandelivery%>, <%=franservice%>],
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
		<div style="height: 500px; text-align: center;">
		<select id="selectBox" style="float: right;">
		<option value="소비자평점">소비자평점</option>
		<option value="매출현황">매출현황</option>		
		</select><br/>
		
		
		<%if(list.size()>0 && list1.size() > 0 ){%>
			<h2> ${location}의 지점평가</h2><br/>
			<h3 style="border-bottom: 0px;">맛평점 평균 : <%=franflavor %></h3>
			<h4>전국 백다방 맛평점 평균 : <%=flavor %></h4><br/>
			<h3 style="border-bottom: 0px;">배달평점 평균 : <%=frandelivery %></h3>
			<h4>전국 백다방 배달평점 평균 : <%=delivery %></h4><br/>
			<h3 style="border-bottom: 0px;">서비스평점 평균 : <%=franservice %></h3>
			<h4>전국 백다방 서비스평점 평균 : <%=service %></h4><br/>
			<h3 style="border-bottom: 0px;">※개선방안※</h3><br/><br/>
			
			<%if(flavor-franflavor>0){
				%>맛에 조금더 신경써주세요!!<br/><br/>
			<% } %>
			<%if(delivery-frandelivery>0){
				%>배달에 조금더 신경써주세요!!<br/><br/>
			<% } %>
			<%if(service-franservice>0){
				%>서비스에 조금더 신경써주세요!!<br/><br/>
			<% } %>
		<%} else{%>
			<h2> ${location}의 지점평가</h2><br/>
			<h3 style="border-bottom: 0px;">맛평점 평균 : <%=0 %></h3>
			<h4>전국 백다방 맛평점 평균 : <%=flavor %></h4><br/>
			<h3 style="border-bottom: 0px;">배달평점 평균 : <%=0%></h3>
			<h4>전국 백다방 배달평점 평균 : <%=delivery %></h4><br/>
			<h3 style="border-bottom: 0px;">서비스평점 평균 : <%=0%></h3>
			<h4>전국 백다방 서비스평점 평균 : <%=service %></h4><br/>
			<h3 style="border-bottom: 0px;">※개선방안※<br/><br/>
		<%} %>
</h3>		
		</div>
	</div>
</div>

<footer id = "footer" class = "footer">
	<%@ include file = "./footer.jsp" %>
</footer>
</body>
</html>