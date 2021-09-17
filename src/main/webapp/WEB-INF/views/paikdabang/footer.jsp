<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "com.project.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.in_footer {
    border-top: 3px solid blue;
}

@media (max-width: 1199px){
.container {
    width: calc(100% - 20px);
    padding-left: 10px;
    padding-right: 10px;
}}
.container {
    max-width: 1150px;
    margin: 0 auto;
    position: relative;
}
.in_footer {
    padding: 30px 0;
    text-align: center;
    color: #262626;
    position: relative;
}
.in_footer .logo {
    display: inline-block;
    width: 179px;
}
a {
    color: inherit;
    text-decoration: none;
}

.in_footer .company_info {
    padding-top: 30px;
    margin-bottom: 0;
    font-size: 0.812rem;
}

.in_footer .r_box {
    width: 100%;
    max-width: 175px;
    position: absolute;
    top: 30px;
    right: 0;
    font-size: 0.75rem;
}

.in_footer .family_site {
    width: 100%;
    padding: 5px 7px;
    margin-bottom: 25px;
    border: 1px solid #262626;
    position: relative;
    cursor: pointer;
    text-align: left;
    -webkit-appearance: menulist-button;
}


.in_footer .family_site #fmenu {
    display: none;
    padding: 0 5px;
    position: absolute;
    bottom: 28px;
    left: -1px;
    right: 0;
    background: #fff;
    border: 1px solid #262626;
    width: 175px;
}
select {
    margin: 0;
    padding: 0;
}

.in_footer .family_site #fmenu option {
    padding: 7px 0;
}
</style>
<body>
<%
TempVO mymymymymymyown = (TempVO)session.getAttribute("mydabangbusiness"); //nullpointer
String myAddr = mymymymymymyown.getAddress();	//nullpointer
if(mymymymymymyown.getDetailaddress()!=null){
	myAddr += " " + mymymymymymyown.getDetailaddress();
}
%>
	<div class="container" style = "margin-top:40px;">
	            <div class="in_footer">
	                <a class="logo" href=""><img src="${pageContex.request.contextPath}/resources/images/paikdabang/DABANG-logo (1).png" alt="다방로고" style = "width:149px;"></a>
	                <div class="company_info">
	                    <ul style = "list-style:none;">
	                        <li>(주)THE ONE</li>
	                        <li>사업자등록번호 <%=mymymymymymyown.getPhone() %></li>
	                        <li>대표이사 <%=mymymymymymyown.getName() %></li>
	                    </ul>
	                    
	                    <ul style = "list-style:none;">
	                        <li>주소: <%=myAddr %></li>
	                        <li>팩스: 02-511-3864</li>
	                    </ul>
	                    
						<ul style = "list-style:none;">
	                        <li>본사 대표전화: 010-3952-4545</li>
	                        <li>가맹상담전화: 02-3447-0410</li>
							<li>고객센터: 1544-2360</li>
	                    </ul>
	                    
	                    <p class="copyright">COPYRIGHTⓒ 2020 THE ONE KOREA INC. ALL RIGHTS RESERVED</p>
	                </div>
	                <div class="r_box">
	                    
						<select id="fmenu">
								<option value="" selected="">더원코리아 공식홈페이지</option>
								<option><a href="${pageContext.request.contextPath }/headquarter" target="_blank">더본코리아 공식홈페이지</a></option>
						</select>
						
	                </div>
	            </div>

				<!-- TOP버튼 -->
				<div class="to_top">
					<span></span>
				</div>
				<!-- //TOP버튼 -->
	        </div>
</body>
</html>