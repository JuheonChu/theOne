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
   
   //OrderService pid = (OrderService)request.getAttribute("pid");
   //OrderService sellCount = (OrderService)request.getAttribute("count");
   /* MemberVO member = (MemberVO)request.getAttribute("id"); */
   /* int pid2 = (int)(request.getAttribute("pid"));
   int sellCount2 = (int)(request.getAttribute("count")); */
   
   
   
   /* Map<String, Integer> map = new HashMap<String, Integer>();
   map.put("pid", pid2);
   map.put("count", sellCount2); */
   
   //List<Integer> idxList = orderService.getPidList(member.getId()); //id
   //Map<String,Object> map = new HashMap<String,Object>();
   ArrayList<OrderVO> list = (ArrayList<OrderVO>)request.getAttribute("basketList");
   DecimalFormat df = new DecimalFormat("###,###");
   
   System.out.println(request.getAttribute("id"));
   //String id = (String)request.getAttribute("id");
   
   List<Integer> pidList = new ArrayList<Integer>();
   List<Integer> countList = new ArrayList<Integer>();
   
   
   int tempPidSum=0;
   
    for (int i=0; i<list.size(); i++) {
       tempPidSum+=list.get(i).getPid();
      pidList.add(list.get(i).getPid());
   }
   
   for (int i=0; i<list.size(); i++) {
      countList.add(list.get(i).getCount());
   }
   
   session.setAttribute("pidList", pidList);
   session.setAttribute("countList", countList);
   
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
                                                         style="border-top: 4px solid orange; border-bottom: 2px solid orange;">배송비</td>
                                                      <td width="100"
                                                         style="border-top: 4px solid orange; border-bottom: 2px solid orange;">시간</td>
                                                      <td width="100"
                                                         style="border-top: 4px solid orange; border-bottom: 2px solid orange;">합계</td>
                                                   </tr>
                                                   <% for (int i=0; i<list.size(); i++) {
                                                      int count = list.get(i).getCount();
                                                      int sum = list.get(i).getPrice();
                                                      int lastPrice =+ count * sum;
                                                   %>
                                                   <tr>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;">
                                                         <div class="bak_item">
                                                            <div class="pro_img"></div>
                                                            <div class="pro_nt"></div>
                                                            <img
                                                               src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=list.get(i).getImage() %>"
                                                               width="150" height="150">
                                                         </div>
                                                      </td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;"><%=list.get(i).getMenu()%> (<%=list.get(i).getTemp() %>)</td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;"><%=df.format(sum)%></td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;">
                                                         <div>
                                                            <input type="number" value="<%=count%>" name="count"
                                                               size="2" min="0" max="100" class="proquantity">
                                                         </div>
                                                      </td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;">2,500원</td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;"><%=list.get(i).getTime().substring(0, 10)%></td>
                                                      <td width="150"
                                                         style="border-bottom: 4px solid orange;"><%=df.format(sum * count)%>
                                                         원</td>
                                                   </tr>
                                                   <%} %>
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

                     <table width="796" border="0" cellspacing="0" cellpadding="0"
                        margin-botton="10">
                        <tr>
                           <td width="190" rowspan="7" align="left" bgcolor="#D9D9D9"><font
                              size="3"><b>주문자 정보</b></font></td>
                           <td width="155" align="left">주문자</td>
                           <td width="451" align="left">
                              <input type="text" name="name" size="13" value="<%=member.getName() %>" 
                              placeholder="이름" readOnly />
                              <input type="hidden" name="id" value="<%=member.getId()%>"/>                           
                           </td>
                        </tr>
                        <tr>
                           <td rowspan="3" align="left">받으실곳</td>
                        </tr>
                        <tr>
                           <td height="20" align="left">
                           <input type="text" name="address" size="40" value="<%=member.getAddress()%>" 
                           placeholder="주소"/></td>
                        </tr>

                        <tr>
                           <td height="20" align="left">
                           <input type="text" name="name" size="40" value="<%=member.getDetailaddress()%>"
                           placeholder="상세 주소"/></td>
                        </tr>

                        <tr>
                           <td align="left">핸드폰번호</td>
                           <td align="left">
                              <input type="text" name="phone" size="15"
                              value="<%=member.getPhone() %>" placeholder="핸드폰 번호"/></td>
                        </tr>

                        <tr>
                           <td align="left">이메일</td>
                           <td align="left">
                           <input type="text" name="email" size="20" value="<%=member.getEmail()%>"
                           placeholder="이메일"/>
                           <select name="mail_name" id="mail_name" onchange="javascript_:emailselect(form)">
                              <option>- 직접입력 -</option>
                              <option value="naver.com">네이버</option>
                              <option value="daum.net">다음</option>
                              <option value="kakao.com">카카오</option>
                              <option value="google.com">구글</option>
                           </select></td>
                        </tr>
                     </table> <br /> <br />

                     <table width="796" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                           <td width="220" rowspan="9" align="left" bgcolor="#D9D9D9"><font
                              size="3"><b>배송지 정보</b></font></td>
                           <td width="155" align="left">배송지확인</td>
                           <td width="451" align="left"><input type="checkbox"
                              name="checkbox" id="checkbox" /> <label for="checkbox">주문고객
                                 정보와 동일합니다.</label></td>
                        </tr>

                        <tr>
                           <td width="155" align="left">주문자</td>
                           <td width="451" align="left">
                              <input type="text" name="name" size="13" value="<%=member.getName() %>" 
                              placeholder="이름" readOnly />
                              <input type="hidden" name="id" value="<%=member.getId()%>"/>                           
                           </td>
                        </tr>

                        <tr>
                           <td rowspan="3" align="left">받으실곳</td>
                        </tr>
                        <tr>
                           <td height="20" align="left">
                           <input type="text" name="address" size="40" value="<%=member.getAddress()%>" 
                           placeholder="주소"/></td>
                        </tr>

                        <tr>
                           <td height="20" align="left">
                           <input type="text" name="name" size="40" value="<%=member.getDetailaddress()%>"
                           placeholder="상세 주소"/></td>
                        </tr>

                        <tr>
                           <td align="left">핸드폰번호</td>
                           <td align="left">
                              <input type="text" name="phone" size="15"
                              value="<%=member.getPhone() %>" placeholder="핸드폰 번호"/></td>
                        </tr>

                        <tr>
                           <td align="left">이메일</td>
                           <td align="left">
                           <input type="text" name="email" size="20" value="<%=member.getEmail()%>"
                           placeholder="이메일"/>
                           </td>
                        </tr>

                        <tr>
                           <td align="left">남기실말씀</td>
                           <td align="left"><input type="text" name="name" size="64" /></td>
                        </tr>

                        <tr>
                           <td align="left">배송선택</td>
                           <td align="left">
                              <form id="form1" name="form1" method="post" action="">
                                 <input type="radio" name="radio" id="radio" value="radio" />
                                 <label for="radio">기본배송</label>
                              </form>
                           </td>
                        </tr>
                     </table> <br /> <br />

                     <table width="796" border="0" cellspacing="0" cellpadding="0">
                     <% 
                     int sum = 0;
                     int price = 0;
                     
                     for (int i=0; i<list.size(); i++) { 
                        price = list.get(i).getCount() * list.get(i).getPrice();
                        
                        sum += price;
                     }
                     %>
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
                              <a href="${pageContext.request.contextPath}/product/dabang/buyAction?id=<%=member.getId() %>&iuid=<%=franchisekey %>" class="btn btn-primary" 
                              onclick="return confirm('<%=df.format(sum+2500)%>원을 결제 하시겠습니까??')">결제하기</a></td>
                        </tr>
                     </table>
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