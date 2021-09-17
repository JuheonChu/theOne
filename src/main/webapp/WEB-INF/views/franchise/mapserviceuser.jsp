<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.project.vo.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<meta charset="utf-8">
<title>여러개 마커 표시하기</title>
</head>
<body>
   <div class="header">
      <%@ include file="../header.jsp"%>
   </div>
   <%
   	  int locationservice = 500000;
      //MemberVO loggedinMember = (MemberVO) session.getAttribute("loginMember");
      String passedId = (String) request.getAttribute("aaId");
      //System.out.println("넘겨받은 ID는? " + passedId);
      String contractno = (String)request.getAttribute("mymycontractno");
      //System.out.println("넘겨받은 contractno? " + contractno);
      int ctno = Integer.parseInt(contractno.trim());
      List<MapServiceVO> locationlist = (List<MapServiceVO>) request.getAttribute("locationlist"); //db에있는 locationlist
   %>

<%
   if (passedId.equals(member.getId())) {
%>
   <div id="map" style="width: 100%; height: 350px;"></div> <!--  지도를 표시할곳 -->

   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5173eb95e6460d7f378547a04b4cf979"></script>
   
<script>
function gotoNextPage(){

   history.back();
   
}
</script>
<script>
   var ss = "";
   var tt = "";

   //db에서 가져온것
   var building = [
      "서울특별시 마포구 동교동 184-24 호평빌딩",
      "서울특별시 서대문구 창천동 현석빌딩",
      "서울특별시 마포구 노고산동 440-41번지 신촌 114빌딩",
      "서울특별시 서대문구 창천동 57-23 영화빌딩",
      "서울특별시 서대문구 창천동 18-1 조은빌딩",
      "서울특별시 서대문구 창천동 신촌로9길 용재빌딩",
      "서울특별시 마포구 노고산동 31-11번지 신촌로터리예식장빌딩", //7
      "서울특별시 서대문구 창천동 13-2번지 준성빌딩",//8
      "서울특별시 서대문구 창천동 41-6 영우빌딩",//9
      "서울특별시 서대문구 창천동 즐거운빌딩", //10
      "경기도 부천시 원미구 상1동 부천빌딩",//11
      "경기도 부천시 원미구 심곡동 부천용주빌딩", //12
      "경기도 부천시 상동 401번지 1층 아리따움 부천송내 세원빌딩", //13
      "경기도 부천시 원미구 심곡동 383-8  프리존빌딩", //14
      "경기도 부천시 원미구 심곡동 우정빌딩",//15
      "경기도 부천시 원미구 심곡2동 부흥빌딩", //16
      "경기도 고양시 덕양구 화정동 969 동원텔빌딩", //17
      "서울특별시 종로구 종로 328 동대문빌딩",//18
      "서울특별시 중구 정동 정동길17 이화정동빌딩",//19
      "경기도 고양시 일산동구 장항동 890-4 일산법조빌딩",//20
      "경상북도 구미시 원평동 417-3 교차로빌딩"//21
      
   ];

   //db에서 가져온것
    var array1_x = [37.556511,
       37.55968,
       37.555939,
       37.557604,
       37.558147,
       37.559065,
       37.555458,
       37.558893,
       37.558961,
       37.557089,
       37.494007,
       37.493179,
       37.494123,
       37.487564,
       37.497842,
       37.487829,
       37.635345,
       37.5725,
       37.5667337,
       37.656845,
       36.131454];
   //db에서가져옴
    var array1_y = [126.931626,
       126.938149,
       126.938363,
       126.935831,
       126.937376,
       126.933643,
       126.937634,
       126.938278,
       126.937419,
       126.936904,
       126.752839,
       126.771722,
       126.753182,
       126.780629,
       126.784834,
       126.783289,
       126.831474,
       127.014254,
       126.970421,
       126.776059,
       128.328782];
   


   
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
      mapOption = {
         center : new kakao.maps.LatLng(33.450701, 125.570667), // 지도의 중심좌표
         level : 3
      // 지도의 확대 레벨
      };

      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

      
      // 마커를 표시할 위치와 title 객체 배열입니다 
      var positions = [ {
         title : '서울특별시 마포구 동교동 184-24 호평빌딩',
         latlng : new kakao.maps.LatLng(37.556511, 126.931626)
      //완료
      }, {
         title : '서울특별시 서대문구 창천동 현석빌딩',
         latlng : new kakao.maps.LatLng(37.55968, 126.938149)
      //완료
      }, {
         title : '서울특별시 마포구 노고산동 440-41번지 신촌 114빌딩',
         latlng : new kakao.maps.LatLng(37.555939, 126.938363)
      //완료
      }, {
         title : '서울특별시 서대문구 창천동 57-23 영화빌딩',
         latlng : new kakao.maps.LatLng(37.557604, 126.935831)
      //완료
      },

      {
         title : '서울특별시 서대문구 창천동 18-1 조은빌딩',
         latlng : new kakao.maps.LatLng(37.558147, 126.937376)
      //완료
      },

      {
         title : '서울특별시 서대문구 창천동 신촌로9길 용재빌딩', //완료
         latlng : new kakao.maps.LatLng(37.559065, 126.933643)
      //완료
      }, {
         title : '서울특별시 마포구 노고산동 31-11번지 신촌로터리예식장빌딩', //완료
         latlng : new kakao.maps.LatLng(37.555458, 126.937634)
      //완료
      }, {
         title : '서울특별시 서대문구 창천동 13-2번지 준성빌딩', //8(완료)
         latlng : new kakao.maps.LatLng(37.558893, 126.938278)
      //완료
      }, {
         title : '서울특별시 서대문구 창천동 41-6 영우빌딩', //9(완료)
         latlng : new kakao.maps.LatLng(37.558961, 126.937419)
      //완료
      }, {
         title : '서울특별시 서대문구 창천동 즐거운빌딩', //10(완료)
         latlng : new kakao.maps.LatLng(37.557089, 126.936904)
      //완료
      }, {
         title : '경기도 부천시 원미구 상1동 부천빌딩', //11(완료)
         latlng : new kakao.maps.LatLng(37.494007, 126.752839)
      //완료 
      }, {
         title : '경기도 부천시 원미구 심곡동 부천용주빌딩', //12(완료)
         latlng : new kakao.maps.LatLng(37.493179, 126.771722)
      //완료
      }, {
         title : '경기도 부천시 상동 401번지 1층 아리따움 부천송내 세원빌딩', //13(완료)
         latlng : new kakao.maps.LatLng(37.494123, 126.753182)
      //완료
      }, {
         title : '경기도 부천시 원미구 심곡동 383-8  프리존빌딩', //14 완료
         latlng : new kakao.maps.LatLng(37.487564, 126.780629)
      // 완료
      }, {
         title : '경기도 부천시 원미구 심곡동 우정빌딩', //15 (완료)
         latlng : new kakao.maps.LatLng(37.497842, 126.784834)
      //
      }, {
         title : '경기도 부천시 원미구 심곡2동 부흥빌딩', //16(완료)
         latlng : new kakao.maps.LatLng(37.487829, 126.783289)
      // 완료
      }, {
         title : '경기도 고양시 덕양구 화정동 969 동원텔빌딩', //17(완료)
         latlng : new kakao.maps.LatLng(37.635345, 126.831474)
      // 완료
      }, {
         title : '서울특별시 종로구 종로 328 동대문빌딩', //18(완료)
         latlng : new kakao.maps.LatLng(37.5725, 127.014254)
      // 완료
      }, {
         title : '서울특별시 중구 정동 정동길17 이화정동빌딩', //19(완료)
         latlng : new kakao.maps.LatLng(37.5667337, 126.970421)
      // 완료
      }, {
         title : '경기도 고양시 일산동구 장항동 890-4 일산법조빌딩', //20(완료)
         latlng : new kakao.maps.LatLng(37.656845, 126.776059)
      //20완료
      }, {
         title : '경상북도 구미시 원평동 417-3 교차로빌딩',// 완료
         latlng : new kakao.maps.LatLng(36.131454, 128.328782)
      //완료
      } ];

      var selectedMarker = null;

      // 마커 이미지의 이미지 주소입니다
      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

      for (var i = 0; i < positions.length; i++) {
         tt = positions[i].title;
         // 마커 이미지의 이미지 크기 입니다
         var imageSize = new kakao.maps.Size(24, 35);

         // 마커 이미지를 생성합니다    
         var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

         var clickImage = markerImage;
         // 마커를 생성합니다
         var marker = new kakao.maps.Marker({
            map : map, // 마커를 표시할 지도
            position : positions[i].latlng, // 마커를 표시할 위치
            title : tt, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
            image : markerImage
         // 마커 이미지 
         });

         
         marker.setMap(map); //마커가 지도위에 표시되도록 설정합니다.
         
         ss = building[i]; //always selecting the last index of the element from that array
         
         var iwContent = '<div style="padding:18px;">' + building[i] + '<br><a href="https://map.kakao.com/link/map/' + building[i] + ',' + array1_x[i] + ',' + array1_y[i] + '" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/' + building[i] + ',' + array1_x[i] + ',' + 126.570667 + '" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
          iwPosition = new kakao.maps.LatLng(positions[i].latlng, positions[i].latlng); //인포윈도우 표시 위치입니다

         // 인포윈도우를 생성합니다
         var infowindow = new kakao.maps.InfoWindow({
               position : iwPosition, 
             content : iwContent 
         });

      (function(marker, title) {
          kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
          kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
         // 마커에 click 이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'click', function() {

              // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
              // 마커의 이미지를 클릭 이미지로 변경합니다
              if (!selectedMarker || selectedMarker !== marker) {

                  // 클릭된 마커 객체가 null이 아니면
                  // 클릭된 마커의 이미지를 기본 이미지로 변경하고
                  !!selectedMarker && selectedMarker.setImage(selectedMarker.markerImage);

                  // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
                  marker.setImage(clickImage);
                  alert(marker.tt + ", " + marker.title + ", " + marker.position + " , " + ss + ", " + title);
               
                  document.getElementById("mymylocation").value = title;
              }

              // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
              selectedMarker = marker;
            
          });
      })(marker, ss);
         
   } // end of the for-loop

      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
      function makeOverListener(map, marker, infowindow) {
          return function() {
              infowindow.open(map, marker);
          };
      }

      // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
      function makeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      }
</script>
   
<form action = "${pageContext.request.contextPath}/headquarter/franchiseform/Mapservice/submit" accept-charset="UTF-8">
   <input type = "text" id = "mymylocation" value = "" required = "" name = "address"> 
   <input type = "hidden" id = "" value = "${myTempStatus.membershipfee}" name = "membershipfee"/><br/>
   <input type = "hidden" id = "" value = "${myTempStatus.membershipmaintenance}" name = "membershipmaintenance"/>
   <input type = "hidden" value = "${myTempStatus.selectmenu }" name = "selectmenu"/>
   <input type = "hidden" value = "${myTempStatus.status }" name = "status"/>
   <input type = "hidden" value = "<%=member.getIdx() %>" id = "member_index" name = "member_index">
   <input type = "hidden" value = "${mymycontractno}" id = "contractno" name = "contractno">
   <input type = "hidden" value = "<%=locationservice %>" id = "mapservicefee" name = "mapservicefee"/>
   <input type = "submit" value = "선택하기"/>   
</form>   

   <%} %>
   <div class="footer">
      <%@ include file="../footer.jsp"%>
   </div>
</body>
</html>