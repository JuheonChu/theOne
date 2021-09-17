<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.project.vo.*" %>
<%@ page import="com.project.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%@ page session="false" pageEncoding="UTF-8"%>
<html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>Home</title>
<script src="<c:url value="${pageContext.request.contextPath }/resources/js/sockjs-0.3.4.js" />"></script>
<script src="<c:url value="${pageContext.request.contextPath }/resources/js/stomp.js" />"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<style>

body > table{
	text-align:center;
	margin: 0 auto;
}

div{
	text-align: center;
}

table{
	border-collapse: collapse;
	text-align:center;
}

tr{
	text-align: center;
}

td{
	border:1px solid black;
}

th{
	border: 1px solid black;
	text-align:center;
}

	img{
		width:33px;
		height:auto;
	}
</style>


<script>
var socket = null;
var isStomp = false;

$(document).ready(function() {

	connectStomp();

	$(".ratify").click(function() {

				event.preventDefault();
		
				var quantity = $(this).parent().find("input#reqCount").val();
				var price = $(this).parent().find("input#price").val();
				var profit = quantity * price;
				var imgsrc = $(this).parent().find("input#imgsrc").val();
				var franchisekey = $(this).parent().find("input#franchisekey").val();
				var contractno = $(this).parent().find("input#contractno").val();
				var pid = $(this).parent().find("input#pid").val();
				var status = $(this).parent().find("input#status").val();
				var available = $(this).parent().find("input#available").val();
				var random = $(this).parent().find("input#random").val();
				var req_orderid = $(this).parent().find("input#req_orderid").val();
				
				var warn = confirm("해당 상품을 주문을 승인하시겠습니까??");
				if (warn) {
					
					var data = {
						quantity: quantity,
						contractno: contractno,
						price: price,
						imgsrc: imgsrc,
						franchisekey: franchisekey,
						pid: pid,
						status: status,
						random: random,
						available: available,
						req_orderid: req_orderid
						
					};

					$.ajax({
						url : 'http://192.168.6.118:8080/rest2/vo/ratify/inventory/to/franchise',
						data : JSON.stringify(data),
						cache : false,
						async : true,
						contentType:"application/json", 
						type : "post",
						success : function(response){

							location.href = 'http://192.168.6.118:8080/headquarter/temp?quantity='+response.quantity + '&price='+ response.price
							+ '&pid='+ response.pid + '&franchisekey=' + response.franchisekey + '&random=' + response.random + '&contractno='
							+ contractno + '&req_orderid='+req_orderid;
							
							
							var ajaxName = decodeURIComponent(response.ajaxName);
						},
						error : function(xhr,status,error) {
							alert("에러!");
							alert("code:"+ xhr.status+ "\n"+ "message:" + xhr.responseText+ "\n"+ "error:"+ error);
						}

					});


					
					
					
					
				 if (!isStomp && socket.readyState != 1)return;

				 
					var msg = $(this).parent().find("input#messagecontent").val();
					var fromId = $(this).parent().find("input#fromId").val();
					var receiver = $(this).parent().find("input#receiver").val();
					var contractno = $(this).parent().find("input#contractno").val();
					var pid = $(this).parent().find("input#pid").val();
					var quantity = $(this).parent().find("input#reqCount").val();
					var price = $(this).parent().find("input#price").val();
					var profit = quantity * price;

					var message = {
						fromId : fromId,
						receiver : receiver,
						messagecontent : msg,
						topic : '배송조회',
						contractno : contractno,
						pid:pid,
						reqCount:quantity,
						profit:profit
					};

					if (isStomp) {
						alert("승인완료!");

						socket.send('/app/stompTest/approveResources',{}, JSON.stringify(message));
					}else {
						socket.send(msg);
					}

				//	localStorage.setItem('approve', approve);
				}else{
					alert("취소!");
				}
	});
});


function connectStomp() {
		var sock = new SockJS("/stompTest"); //end point
		var client = Stomp.over(sock);

		isStomp = true;
		socket = client;

		client.connect({}, function() {
			console.log("Connected StompTest!!!!!");
			//Controller에서의 MessageMapping, header, message(자유형식)
			client.send('/TTT', {}, "연결됩니다..."); //컨트롤러 매핑주소

			//해당 토픽을 구독한다.
			client.subscribe('/topic/message', function(event) {
				console.log("!!!!!!!!!evt: " + event);
			});
		});
}

</script>
</head>
<body>
<div>
	<h2>주문요청 현황</h2>
</div><br/><br/>


<%
	int pagenum = ((Integer) request.getAttribute("page")).intValue();
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");
	int totalPage = (Integer) request.getAttribute("totalPage");
	DecimalFormat df = new DecimalFormat("###,###");
	
	
	RequestOrderService service = (RequestOrderService)request.getAttribute("service");
	ProductService productservice = (ProductService)request.getAttribute("productservice");
	MemberService memberservice = (MemberService)request.getAttribute("memberservice");
	
	List<RequestOrderVO> orderlist = (List<RequestOrderVO>)request.getAttribute("orderlist");
	
	String topic = "배송완료";
	
	UUID uuid = UUID.randomUUID();
	
	String random = uuid.toString().substring(0, 13);
	
	String rr = "";
%>



	<table>
		<tr>
			<th>상품</th>
			<th>메뉴</th>
			<th>상품분류</th>
			<th>HOT/ICE/BASIC/SOFT</th>
			<th>상품설명</th>
			<th>상품 가격</th>
			<th>요청 수량</th>
			<th>요청 지점</th>
			<th>승인</th>
		</tr>

	
		<%
				for(int i = 0; i < orderlist.size();i++){ 
						RequestOrderVO order = orderlist.get(i);
					//	System.out.println("작성자는? "+board.getWriter());
						int tempPid = service.selectpidbyorderid(order.getReq_orderid());
						ProductVO product = productservice.selectPdt(tempPid);// expected one result or null to be returned by selectOne()
						TempVO temp = service.getTempByRid(order.getRid());
						rr = temp.getAddress();
						if(temp.getDetailaddress()!=null){
							rr += " " + temp.getDetailaddress();
						}
						String receiver = memberservice.selectIDWithFranchisekey(temp.getFranchisekey());
					
		%> 	
				
		<tr>
			<%if(product.getBrand().equals("빽다방")){ %>
				<td><img src = "${pageContext.request.contextPath}/resources/images/paikdabang/<%=product.getImage()%>"/></td>
			<%}else if(product.getBrand().equals("한신포차")){ %>
				<td><img src = "${pageContext.request.contextPath}/resources/images/hanshin/<%=product.getImage()%>"/></td>
			<%} %>
	            <td><%=product.getMenu()%></td>
	            <td><%=product.getType()%></td>
	            <td><%=product.getTemp()%></td>
	            <td><%=product.getDetailExplain()%></td>
	            <td><%=product.getPrice()%></td>
	            <td><%=order.getReqCount()%></td>
	            <td><%=rr%></td>
	            <td>
	            
	            	<input type = "hidden" id = "menu" value = "<%=product.getMenu() %>">
	            	<input type = "hidden" id = "type" value = "<%= product.getType() %>"/>
	            	<input type = "hidden" id = "temp" value = "<%= product.getTemp() %>"/>
	            	<input type = "hidden" id = "detailExplain" value = "<%= product.getDetailExplain() %>"/>
	            	<input type = "hidden" id = "price" value = "<%= product.getPrice()%>"/>
	            	<input type = "hidden" id = "reqCount" value = "<%= order.getReqCount() %>"/>
	            	<input type = "hidden" id = "brand" value = "<%= temp.getBrand()%>"/>
	            	<input type = "hidden" id = "imgsrc" value = "<%=product.getImage() %>">
	            	<input type = "hidden" id = "franchisekey" value = "<%= order.getRid()%>"/><!--  franchisekey -->
	            	<input type = "hidden" id = "pid" value = "<%=product.getIdx() %>"/>
	            	<input type = "hidden" id = "status" value = "<%=order.getStatus() %>">
	            	<!-- 여기서부턴 메시지 관련된 태그들 -->
	            	<input type = "hidden" id = "contractno" value = "<%=temp.getContractno() %>">
	            	<input type = "hidden" id = "fromId" value = "<%= "admin" %>">
	            	<input type = "hidden" id = "topic" value = "<%=topic %>">
	            	<input type = "hidden" id = "receiver" value = "<%=receiver%>">
	            	<input type = "hidden" id = "messagecontent" value = "<%=rr +"으로 배송완료되었습니다!" %>">
	            	<!-- 랜덤식별값 -->
	            	<input type = "hidden" id = "random" value = "<%= random %>">
	            	
	            	<input type = "hidden" id = "req_orderid" name = "req_orderid" value = "<%=order.getReq_orderid()%>"/>
	            	
	            	<%if(!order.getStatus().equals("delivered")){%>
                  <input type = "button"  id = "ratify" class=  "ratify" value = "승인하기">
                   <%}else{%>
                   <input type = "button"   value = "승인됨" disabled ="true">
                   <%} %>
	            </td>
			
		</tr>
	<%} %>
	



		<!-- 페이징 -->
		<tr>
			<td colspan='9'>
				<%
					if (startPage > 1) {
				%> <a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=1%>">[처음으로]</a> <%
 	}
 %> <%
 	if (pagenum > 10) {
 %> <a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=pagenum - 10%>">[이전페이지]</a> <%
 	}
 %> <%
 	//System.out.print(endPage+"페이지입니다");
 	for (int a = startPage; a <= endPage; a++) {
 		%><a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=a%>">[<%=a%>]
 		         </a><%
 }%>
  <%
 	if (totalPage - pagenum >= 10) {
 %> <a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=pagenum + 10%>">[다음페이지]</a> <%
 	} else {
 %> <a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=totalPage%>">[다음페이지]</a> <%
 	}
 %> <%
 	if (endPage < totalPage) {
 %> <a href="${pageContext.request.contextPath}/headquarter/selectorder/from/franchise?page=<%=totalPage%>">[끝]</a> <%
 	}
 %>

			</td>

		</tr>

	</table>
	<br />

	<input type="button" value="뒤로가기"  class = "btn btn-primary" onclick="location.href='javascript:history.go(-1);'" />
	
</body>
</html>
