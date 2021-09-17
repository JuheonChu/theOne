<%@page import="com.project.vo.SurveyVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table{
	border:1px solid black; 
	border-color: black;
	border-collapse: collapse;
	margin: 0 auto;
    width: 600px;
	
}

td{
	border:1px solid black; 
	border-color: black;
	text-align: center;
    width: 150px;
    height: 70px;
}

</style>
</head>
<body>
<%
ArrayList<SurveyVO> list = (ArrayList<SurveyVO>)request.getAttribute("survey");
String data = (String)request.getAttribute("data");
int flavor = 0;
int delivery = 0;
int service = 0;

if(data.equals("data")){
flavor = (int)list.get(0).getFlavor()/list.get(0).getOrdercount();
delivery = (int)list.get(0).getDelivery()/list.get(0).getOrdercount();
service = (int)list.get(0).getService()/list.get(0).getOrdercount();
}%>
<script>
if("<%=data%>"=="nodata"){
	alert("찾을수 없는 지점입니다.");
	window.close();
}
</script>
<div style="width:800px">
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
        labels: ["맛","배달","서비스"],
        datasets: [{
            label: '지점 평가',
            data: [<%=flavor%>, <%=delivery%>, <%=service%>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
            ],
            borderWidth: 1
        }]
    },
    options: {
        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
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
<div>
	<table>
		<tr>
			<td></td>
			<td>맛</td>
			<td>배달</td>
			<td>서비스</td>
		</tr>
		<tr>
			<td>평점</td>
			<td><%=flavor %></td>
			<td><%=delivery %></td>
			<td><%=service %></td>
		</tr>
	</table>
</div>
</body>
</html>