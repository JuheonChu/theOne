<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
		if(num==("소비자평점")){
		location.href="hanshinchart?franchisekey=<%=request.getParameter("franchisekey")%>"
		}
		});
});
</script>
</head>
<body>
<% int sales =(int)request.getAttribute("sales");
int fransales = (int)request.getAttribute("fransales");
DecimalFormat df = new DecimalFormat("###,###,###,###");
%>
<header class = "header">
	<%@ include file="./header.jsp"%>
</header>

<div class="sub_section menu_wrap" style = "margin-top:115px;">
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
        labels: ["${location}점", "한신포차평균"],
        datasets: [{
            label: '${location}지점 매출현황',
            data: [<%=sales%>, <%=fransales%>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
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
		<option value="매출현황">매출현황</option>		
		<option value="소비자평점">소비자평점</option>
		</select><br/>
			<h2> ${location}의 지점평가</h2><br/><br/><br/><br/>
			<h3 style="border-bottom: 0px;">${location}점 매출현황 :<%=df.format(sales)%></h3>
			<h4>한신포차 매출현황(평균) : <%=fransales %></h4><br/><br/><br/>
			<h3 style="border-bottom: 0px;">※개선방안※<br/><br/><br/>
			<%if(fransales-sales>0){
				%>본사에 케어서비스를 신청해보세요!!<br/><br/>
			<% } %>
			<%if(fransales-sales==0){
				%>잘하고 있으니 현상유지해주세요!!<br/><br/>
			<% } %>
			<%if(fransales-sales<0){
				%>이번달 우수지점을 노려보세요!!<br/><br/>
			<% } %>
</h3>		
		</div>
	</div>
</div>

<footer id = "footer" class = "footer">
	<%@ include file = "./footer.jsp" %>
</footer>
</body>
</html>