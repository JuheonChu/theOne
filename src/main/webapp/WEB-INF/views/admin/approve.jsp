<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix= "d"%>
<%@ page import="com.project.service.*"%>
<%@ page import="com.project.vo.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Web에서 처음 favicon 404에러 막아주는코드 -->
<link rel="shortcut icon" href="#">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>Insert title here</title>

<script src="<c:url value="/resources/js/sockjs-0.3.4.js" />"></script>
<script src="<c:url value="/resources/js/stomp.js" />"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>

<style>
table {
	border-collapse: collapse;
	font-size:10px;
}

th {
	border: 1px solid black;
}

td {
	border: 1px solid black;
}
</style>

<script type="text/javascript">
	var socket = null;
	var isStomp = false;
	
	$(document).ready(function() {
			connectStomp();

						$(".approve").click(function(event) {
							event.preventDefault();

							if (!isStomp && socket.readyState != 1)
												return;

											var msg = $(this).parent().find(
													"input#messagecontent")
													.val();
											var fromId = $(this).parent().find(
													"input#fromId").val();
											var receiver = $(this).parent()
													.find("input#receiver")
													.val();
											var contractno = $(this).parent()
													.find("input#contractno")
													.val();

											var message = {
												fromId : fromId,
												receiver : receiver,
												messagecontent : msg,
												topic : '필수',
												contractno : contractno
											};

											if (isStomp) {
												alert("승인완료!");
												socket.send('/app/stompTest', {topic : '필수'}, JSON.stringify(message));

											} else {
												socket.send(msg);
											}

										});

						$(".finalApproval").click(function(event) {

							var selectmenu = $(this).parent().find("input#selectmenu").val();
							var postcode = $(this).parent().find("input#postcode").val();
							var address = $(this).parent().find("input#address").val();
							var membershipmaintenance = $(this).parent().find("input#membershipmaintenance").val();
							var membershipfee = $(this).parent().find("input#membershipfee").val();

							if (!selectmenu || !postcode || !address || (membershipmaintenance == 0) || (membershipfee == 0)) {
								alert('최종승인을 할수없습니다!');
								return;
							}
							
							var warn = confirm("해당 창업주의 가맹 창업을 승인하시겠습니까??");
							if (warn) {

								//$(this).prop('value', '승인됨');
								var approve =  $(this).prop('value');
							//	$(this).prop('disabled', true);
								//var disable = $(this).prop('disable');
								var contractno = $(this).parent().find("input#contractno").val();
								var status = $(this).parent().find("input#status").val();
								var data = {
									approve: approve,
									contractno: contractno,
									status:status
								};
								
								$.ajax({
									url : 'http://192.168.6.118:8080/rest2/vo/approveBusiness.do',
									data : JSON.stringify(data),
									dataType:'json',
									cache : false,
									async : true,
									contentType: "application/json",
									type : "post",
									success : function(response){
										alert("response! : " + response.approve);
										$(this).prop('value', response.approve);
										$(this).prop('disabled', response.disabled);
										
										
										var ajaxName = decodeURIComponent(response.ajaxName);
									},
									error : function(xhr,status,error) {
										alert("에러!");
										alert("code:"+ xhr.status+ "\n"+ "message:" + xhr.responseText+ "\n"+ "error:"+ error);
									}

								});
							}else {
							
							}
									
							event.preventDefault();
							
						    if (!isStomp && socket.readyState != 1)return;
							var msg = $(this).parent().find("input#messagecontent").val();
							var fromId = $(this).parent().find("input#fromId").val();
							var receiver = $(this).parent().find("input#receiver").val();
							var contractno = $(this).parent().find("input#contractno").val();

							var message = {
								fromId : fromId,
								receiver : receiver,
								messagecontent : msg,
								topic : '승인완료',
								contractno : contractno
							};

									if (isStomp) {
										alert("승인완료!");

										socket.send('/app/stompTest/finalApproval',
												{}, JSON.stringify(message));

									} else {
										socket.send(msg);
									}

									localStorage.setItem('approve', approve);

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
	<%
		List<TempVO> waitinglist = (List<TempVO>) request.getAttribute("waitinglist");
		MemberService memberService = (MemberService) request.getAttribute("memberService");
		//how to bring the idx of members
		List<MemberVO>members  = memberService.selectAll();
		String disable = (String)request.getAttribute("disable");
	%>
	<table class="table">
		<tr>
			<th>계약체결 번호</th>
			<th>국내/해외</th>
			<th>브랜드</th>
			<th>가맹위치</th>
			<th>가맹 신청인</th>
			<th>신청인 연락처</th>
			<th>신청인 이메일</th>
			<th>신청인 약관동의 여부</th>
			<th>가맹비</th>
			<th>가맹 유지비</th>
			<th>가맹주 선택메뉴</th>
			<th>가맹주 가맹점 주소</th>
			<th>가맹점 우편번호</th>
			<th>가맹주 창업세부절차</th>
			<th>최종승인</th>
		</tr>

		<%
			for (int i = 0; i < waitinglist.size(); i++) {
			TempVO vo = waitinglist.get(i);
			String receiverId = null;
		try{
			//receiverId = memberService.findIdByName(vo.getName(), vo.getBrand());// where the issue evokes.... member테이블에서 idx도 가져올수있어야함.
			receiverId = memberService.findIdByIdx(vo.getMember_index());
		
		}catch(Exception e){%>
			<script>alert("중복회원 가입불가!");</script>
		<%}
		%>
		<tr>
			<td><%=vo.getContractno()%></td>
			<td><%=vo.getStartup_field()%></td>
			<td><%=vo.getBrand()%></td>
			<td><%=vo.getLocation()%></td>
			<td><%=vo.getName()%></td>
			<td><%=vo.getPhone()%></td>
			<td><%=vo.getEmail()%></td>

			<%
				if ("checkedValue".equals(vo.getConsent())) {
			%>
			<td>O</td>
			<%
				} else {
			%>
			<td>X</td>
			<%
				}
			%>
			<td><%=vo.getMembershipfee() + "원"%></td>
			<td><%=vo.getMembershipmaintenance() + "원"%></td>
			<td><%=vo.getSelectmenu()%></td>
			<td><%=(vo.getAddress() == null ? null : vo.getAddress() + " " + vo.getDetailaddress())%></td>
			<td><%=vo.getPostcode()%></td>
			<td>
				<input id="contractno" name="contractno" type="hidden" value="<%=vo.getContractno()%>"> 
				<input id="fromId" name="fromId" type="hidden" value="<%=session.getAttribute("userid")%>"> 
				<input id="receiver" name="receiver" type="hidden" value="<%=receiverId%>">
				<input id="messagecontent" name="receiver" type="hidden" value="<%=vo.getName()%>님 상담문의가 승인되었습니다.자세한 내용은  여기를 클릭해주세요">
				<%if(!vo.getStatus().equals("approved")){ %>
				<input type="button" value="승인하기" class="approve" onclick="">
				<%}else{ %>
				<input type="button" value="승인하기" class="approve" disabled = "true" onclick="">
				<%} %>
			</td>
			<td>
				<input id = "selectmenu" name = "selectmenu" value = <%= vo.getSelectmenu() %> type = "hidden"/>
				<input id = "postcode" name = "postcode" value = "<%= vo.getPostcode() %>" type = "hidden"/>
				<input id = "address" name = "address" value = "<%=vo.getAddress()%>" type = "hidden"/>
				<input id = "membershipmaintenance" name = "membershipmaintenance" value = "<%= vo.getMembershipmaintenance()%>" type = "hidden"/>
				<input id = "membershipfee" name = "membershipfee" value = "<%= vo.getMembershipfee()%>" type = "hidden"/>
				<input id="contractno" name="contractno" type="hidden" value="<%=vo.getContractno()%>"/> 
				<input id="fromId" name="fromId" type="hidden" value="<%=session.getAttribute("userid")%>"/>
				<input id="receiver" name="receiver" type="hidden" value="<%=receiverId%>"/>
				<input id="messagecontent" name="receiver" type="hidden" value="<%=vo.getName()%>님   최종승인되었습니다.자세한 내용은  여기를 클릭해주세요"/>
				<input id = "status" name = "status" type = "hidden" value = "<%=vo.getStatus() %>" />
				
				<%if(vo.getStatus().equals("approved")){ %>
					<input type="button" value="<%=vo.getStatus()%>" class="finalApproval" style="border: none;" disabled="true"/>
				
				<%}else{ %>
					<input type="button" value="<%=vo.getStatus()%>" class="finalApproval" style="border: none;"/>
				<%} %>
			</td>
				
				
		</tr>
		<%
			}
		%>
	</table>

	<div class="row">
		<div class="col-sm-12">
			<button class="btn btn-default" onclick="history.back()">뒤로가기</button>
		</div>

	</div>
</body>
</html>