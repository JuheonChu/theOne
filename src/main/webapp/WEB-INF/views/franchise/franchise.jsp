<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.project.vo.*"%>
<%@ page import="com.project.service.*"%>
<%@ page import="java.util.*"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/franchise/franchise.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/franchise.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프랜차이즈 폼</title>
</head>
<body>

<%
	List<ProductVO> dabang = (List<ProductVO>) request.getAttribute("dabang");
	List<ProductVO> hanshin = (List<ProductVO>) request.getAttribute("hanshin");
	//MemberService memberService=  (MemberService)request.getAttribute("memberService");
	TempService service = (TempService) request.getAttribute("tempservice");
	MemberVO member = (MemberVO) session.getAttribute("loginMember");
	String contractnomber = (String) request.getAttribute("contractno");

	int contractno = 0;
	try {
		contractno = Integer.parseInt(contractnomber.trim());
	} catch (Exception e) {
		contractno = -1;
	}
	TempVO mybusiness = service.findmyBusiness(contractno);
%>

	<form action = "${pageContext.request.contextPath}/headquarter/franchiseRequirement.do" accept-charset="UTF-8">
		<div class="form">
			<div class="form_input">

				<div>
					<label><p>가맹점 메뉴 선택</p></label>
					<div class="form_st">
						<%
							if ("빽다방".equals(service.findBrandByContractNumber(contractno))) {//로그인한 유저의 이름, 그 유저의 계약번호(잘들어옴)
							for (int i = 0; i < dabang.size(); i++) {
						%>
						<img src = "${pageContext.request.contextPath}/resources/images/paikdabang/<%=dabang.get(i).getImage() %>" style = "width:80px;"/>
												<input type="checkbox" value="<%=dabang.get(i).getMenu() + ((dabang.get(i).getTemp() == null) ? dabang.get(i).getType() : dabang.get(i).getTemp())%>" name = "selectmenu"><%=dabang.get(i).getMenu()%>
						<%
							if (dabang.get(i).getTemp() != null)
						%><%=dabang.get(i).getTemp()%>&nbsp;&nbsp;
						<%
							}
						%>
						<%
							}else if ("한신포차".equals(service.findBrandByContractNumber(contractno))) {//로그인한 유저의 이름, 그 유저의 계약번호(잘들어옴)
						for (int i = 0; i < hanshin.size(); i++) {
						%>
						<img src = "${pageContext.request.contextPath}/resources/images/hanshin/<%=hanshin.get(i).getImage() %>" style = "width:80px;"/>
						<input type="checkbox" value="<%=hanshin.get(i).getMenu()%>" name = "selectmenu"><%=hanshin.get(i).getMenu()%>
						<%
							}
						%>
						<%
							}
						%>
					</div>
				</div>

				<div class = "form-group">
					<label for="">
						<p>가맹비</p>
					</label>
					<div class="form-group">
						<%
							if ("빽다방".equals(service.findBrandByContractNumber(contractno))) {
							mybusiness.setMembershipfee(20000000);
							
						%>
						가맹비: <input type="text" readonly="readonly"
							value="<%=mybusiness.getMembershipfee()%>" style="border: none;" name ="membershipfee">
						<%
							} else if ("한신포차".equals(service.findBrandByContractNumber(contractno))) {
						mybusiness.setMembershipfee(30000000);
						mybusiness.setMembershipmaintenance(3000000);
						%>
						가맹비: <input type="text" readonly="readonly"
							value="<%=mybusiness.getMembershipfee()%>" style="border: none;" name = "membershipfee">
						<%
							}
						%>
					</div>
				</div>		
				
				<div class = "form-group">
					<label for="">
						<p>가맹유지비</p>
					</label>
					<div class="form-group">
						<%
							if ("빽다방".equals(service.findBrandByContractNumber(contractno))) {
								mybusiness.setMembershipmaintenance(2000000);
						%>
						가맹유지비: <input type="text" readonly="readonly" value="<%=mybusiness.getMembershipmaintenance()%>" style = "border:none;" name = "membershipmaintenance">
						<%
							} else if ("한신포차".equals(service.findBrandByContractNumber(contractno))) {
								mybusiness.setMembershipmaintenance(3000000);
						%>
						가맹유지비: <input type="text" readonly="readonly" value="<%=mybusiness.getMembershipmaintenance()%>" style="border: none;" name = "membershipmaintenance">
						<%
							}
						%>
					</div>
				</div>
				
						
				<!--20200619 모션아이-->
				<div class="form-group" style = "display:inline-block;">
					<label for="address">창업지역</label> 
					<input type="text" id="postcode" placeholder="우편번호" name="postcode" class="form-control" size="10" required = ""><br />
					<input type="text" id="address" placeholder="주소" name="address" class="form-control" size="10" required = ""><br /> 
					<input type="text" id="extraAddress" placeholder="참고항목" name="extraAddress" class="form-control" size="10"> 
					<input type="text" id="detailAddress" placeholder="상세주소" name="detailaddress" class="form-control" size="10"><br />
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br> 
				</div>
				
			<input type = "hidden" value = "<%=member.getIdx() %>" name = "member_index">
			<input type = "hidden" value = "<%=contractno%>" name = "contractno">
			<input type="hidden" value="approved" name="status">
			<div class="clear"></div>
			<input type ="submit" value = "신청하기">
		</div>
	</form>

</body>
</html>