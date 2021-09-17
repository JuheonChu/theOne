<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@  page import = "com.project.vo.*"%>
<%@  page import = "com.project.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커에 인포윈도우 표시하기</title>
   
</head>
<body>
<header class="header">
		<%@ include file="./header.jsp"%>
</header><br/><br/><br/>
<% 
 String tempStr = "";
 TempVO mystore = (TempVO)request.getAttribute("mystore");
 if(mystore.getDetailaddress()==null){
	tempStr = "";  
 }else{
 	tempStr = mystore.getDetailaddress();
 }
 //String address = KakaoGeoApi1.coordToAddr(x, y)
 %>
<input type = "hidden" value = "<%=mystore.getLatitude()%>" id = "latitude">
<input type = "hidden" value = "<%=mystore.getLongitude()%>" id = "longitude">
<input type = "hidden" value = "<%=mystore.getLocation()%>" id = "location">
<input type = "hidden" value = "${franchisekeyyy }" id ="franchisekey">
<input type = "hidden" value = "" id = "userlatitude">
<input type = "hidden" value = "" id = "userlongitude">
<input type = "hidden" value = "" id = "userLocationInfo" name = "userlocationInfo">
<input type = "hidden" value = "" id = "userLocationInfo">
<input type = "hidden" value = "<%= mystore.getAddress() + tempStr %>" id  = "address"/>

<div id="map" style="width:100%;height:350px;"></div>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/whereami.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5173eb95e6460d7f378547a04b4cf979"></script>



<script>
$(function(){
	var elt = document.getElementById("userLocationInfo");

	whereami(elt); //value 세팅은됨...
	
});


var mylongitude = document.getElementById("longitude").value;
var mylocation = document.getElementById('location').value;
var mylatitude = document.getElementById("latitude").value;
var myaddress = document.getElementById('address').value;
//alert("mylatitude: " + mylatitude + " , mylongitude: " + mylongitude + " , mylocation : " + mylocation);

var userlatitude  = document.getElementById("userlatitude").value;
var userlongitude = document.getElementById("userlongitude").value;

alert("사용자의 현재위치 : " + userlatitude + " , " + userlongitude);
console.log("사용자의 현재위치 : " + userlatitude + " , " + userlongitude);

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(mylatitude, mylongitude), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(mylatitude, mylongitude); 
var usermarkerPosition = new kakao.maps.LatLng(userlatitude, userlongitude); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

var usermarker = new kakao.maps.Marker({
    position: usermarkerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);


var useraddress = "현재위치";

var iwContent = '<div style="padding:18px;background-color:red;">' + myaddress + '<br><a href="https://map.kakao.com/link/map/' +	myaddress + ',' + mylatitude + ',' + mylongitude + '" style="color:blue;background-color:yellow;" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/' +	myaddress + ',' + mylatitude + ',' + mylongitude + '" style="color:blue;background-color:yellow;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(mylatitude, mylongitude); //인포윈도우 표시 위치입니다


    
// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});


  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker);
//userwindow.open(map,usermarker);




</script>

<footer>
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>