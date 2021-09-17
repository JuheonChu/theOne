<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project.service.*"%>
<%@ page import="com.project.vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signUp.css"> --%>

</head>
<body>
<header class="header">
		<%@ include file="./header.jsp"%>
</header>
<%
	/* MemberVO member = (MemberVO)request.getAttribute("id"); */
	ProductVO product = (ProductVO)request.getAttribute("basketList");
	DecimalFormat df = new DecimalFormat("###,###");
	int count = (Integer)request.getAttribute("count");
	int sum = product.getPrice() * count;
	
	System.out.println("상품 번호 : " + product.getIdx());
	System.out.println("갯수 : " + count);
	
	List<Integer> pidList = new ArrayList<Integer>();
	List<Integer> countList = new ArrayList<Integer>();
	
	session.setAttribute("pidList", product.getIdx());
	session.setAttribute("countList", count);
%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center">
				<table width="1000" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="796" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="38">
										<table width="796" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="108" align="left">
													<table width="796" border="0" cellspacing="0"
														cellpadding="0">

														<tr>
															<td height="29" align="center">

																<table width="796" border="0" cellspacing="0"
																	cellpadding="0">
																	<tr>
																		<td width="200"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">이미지</td>
																		<td width="300"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">상품
																			이름</td>
																		<td width="120"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">판매가</td>
																		<td width="180"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">수량</td>
																		<td width="100"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">시간</td>
																		<td width="100"
																			style="border-top: 4px solid orange; border-bottom: 2px solid orange;">합계</td>
																	</tr>
																	<tr>
																		<td width="150"
																			style="border-bottom: 4px solid orange;">
																			<div class="bak_item">
																				<div class="pro_img"></div>
																				<div class="pro_nt"></div>
																				<img
																					src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=product.getImage() %>"
																					width="150" height="150">
																			</div>
																		</td>
																		<td width="150"
																			style="border-bottom: 4px solid orange;"><%=product.getMenu() %></td>
																		<td width="150"
																			style="border-bottom: 4px solid orange;"><%=product.getMenu() %></td>
																		<td width="150"
																			style="border-bottom: 4px solid orange;">
																			<div>
																				<input type="number" value="<%=count %>" name="count"
																					size="2" min="0" max="100" class="proquantity">
																			</div>
																		</td>
																		<td width="150"
																			style="border-bottom: 4px solid orange;">
																			<%=df.format(sum) %> 원</td>
																	</tr>
																</table>


															</td>
														</tr>

														<tr>
															<td></td>

														</tr>
													</table>
												</td>
											</tr>

											<tr>
												<td height="21">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table> <br /> <br />
							
						<form action="${pageContext.request.contextPath}/product/dabang/nullBuyAction?pid=<%=product.getIdx() %>&sum=<%=sum %>&count=<%=count %>&franchisekey=<%=franchisekey %>" method="post">
						
							<table width="796" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="155" align="left">주문자</td>
									<td width="451" align="left">
										<input type="text" name="name" size="13" value="" placeholder="이름" required = ""/>
										<input type="hidden" name="id" value="<%=member.getId()%>"/>									
									</td>
								</tr>

								<tr>
									<td rowspan="3" align="left">받으실곳</td>
								</tr>
								<tr>
									<td height="20" align="left">
									<input type="text" name="address" size="40" value=""  placeholder="주소" required = ""/></td>
								</tr>

								<tr>
									<td height="20" align="left">
									<input type="text" name="detailaddress" size="40" value=""
									placeholder="상세 주소"/></td>
								</tr>

								<tr>
									<td align="left">핸드폰번호</td>
									<td align="left">
										<input type="text" name="phone" size="15" value="" placeholder="핸드폰 번호" required = ""/></td>
								</tr>

								<tr>
									<td align="left">이메일</td>
									<td align="left">
									<input type="text" name="email" size="20" value=""
									placeholder="이메일"/>
									</td>
								</tr>

								<tr>
									<td align="left">남기실말씀</td>
									<td align="left"><input type="text" name="text" size="64" /></td>
								</tr>

								<tr>
									<td align="left">배송선택</td>
									<td align="left">
										<form id="form1" name="form1" method="post" action="">
											<input type="radio" name="radio" id="radio" value="radio" checked = "checked"/>
											<label for="radio">기본배송</label>
										</form>
									</td>
								</tr>
							</table> <br /> <br />

							<table width="796" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="190" rowspan="3" align="left" bgcolor="#D9D9D9"><font
										size="3"><b>결제금액</b></font></td>
									<td width="155" height="20" align="left">상품합계금액</td>
									<td width="451" align="right"><%=df.format(sum) %> 원</td>
								</tr>

								<tr>
									<td height="20" align="left">배송비</td>
									<td align="right">2,500 원</td>
								</tr>

								<tr>
									<td height="20" align="left">총 결제금액</td>
									<td align="right"><%=df.format(sum + 2500) %> 원</td>
								</tr>
							</table> <br /> <br />
							
							<table width="796" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td align="center">
										<a href="history.back()" class="btn btn-danger" onclick="return confirm('정말 취소 하시겠습니까??')">취소하기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="submit" onclick="return confirm('<%=df.format(sum)%> 원을 결제하시겠습니까??')" class="btn btn-primary" value="결제하기"/> </td>
								</tr>
							</table>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<footer id="footer" class="footer">
		<%@ include file="./footer.jsp"%>
	</footer>
</body>
</html>