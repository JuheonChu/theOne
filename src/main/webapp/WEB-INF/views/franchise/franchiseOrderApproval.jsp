<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@page import = "java.util.*" %>
<%@ page import = "com.project.vo.*" %>
<%@ page import = "com.project.service.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   body{
      margin: 0 auto;
      text-align:center;
   }
   table{
      border-collapse:collapse;
   }
   
   th{
      border:1px solid black;
   }
   
   td{
      border: 1px solid black;
   }
   
   img{
      width:33px;
   }
</style>

<script src="<c:url value="${pageContext.request.contextPath }/resources/js/sockjs-0.3.4.js" />"></script>
<script src="<c:url value="${pageContext.request.contextPath }/resources/js/stomp.js" />"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"
   integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
   crossorigin="anonymous"></script>

<script type="text/javascript">

$(function(){

   $(".verifyDelivery").click(function(){
      event.preventDefault();
      var pid = $(this).parent().find("input#pid").val();
      var rid = $(this).parent().find("input#rid").val();
      var price = $(this).parent().find("input#price").val();
      var reqcount = $(this).parent().find("input#reqCount").val();
      var req_orderid = $(this).parent().find("input#req_orderid").val();
      alert("pid: " + pid + ", rid : " + rid + " , price: " + price + ", reqcount : " + reqcount + " , req_orderid: " + req_orderid);
      var data = {
            reqcount: reqcount,
            price: price,
            rid: rid,
            pid: pid,
            req_orderid: req_orderid
            
         };
      
      
      var warn = confirm("해당 재품을 수령하셨습니까??");
      if(warn){
      
         $.ajax({
            url : 'http://192.168.6.118:8080/rest2/vo/verify/delivery',
            data : JSON.stringify(data),
            cache : false,
            async : true,
            contentType:"application/json", 
            type : "post",
            success : function(response){
               alert('성공');                              
               
               
            },
            error : function(xhr,status,error) {
               alert("에러!");
               alert("code:"+ xhr.status+ "\n"+ "message:" + xhr.responseText+ "\n"+ "error:"+ error);
            }

         });
         }else {

         }

      
   });
   
   
   
});

</script>
</head>
<body>
<%   
   ProductService productservice = (ProductService)request.getAttribute("productservice");
   RequestOrderService orderservice = (RequestOrderService)request.getAttribute("orderservice");
   FranchisePdtApprovalService approveService  = (FranchisePdtApprovalService)request.getAttribute("approveService");
   TempVO mycurrentBusiness = (TempVO)request.getAttribute("mycurrentBusiness"); 
   System.out.println("아아" + mycurrentBusiness.toString());
  // List<RequestOrderVO> orderlist = (List<RequestOrderVO>)request.getAttribute("requestorderlist");
   List<FranchisePdtApprovalVO> approvedList = (List<FranchisePdtApprovalVO>)request.getAttribute("approvedList");
   //System.out.println(approvedList.toString());
//   int pidTT = Integer.parseInt((String)request.getAttribute("pidTT").toString().trim());
   
%>


<table>
      
      <tr>
         <th>상품</th>
         <th>배송지역</th>
         <th>수신인</th>
         <th>상품재고</th>
         <th>상품분류</th>
         <th>HOT/ICE/BASIC/SOFT</th>
         <th>상품설명</th>
         <th>상품 가격</th>
         <th>요청 수량</th>
         <th>배송확인</th>
      </tr>

   
      <%
            for(int i = 0; i < approvedList.size();i++){ 
                  FranchisePdtApprovalVO order = approvedList.get(i);
                  RequestOrderVO tt = approveService.selectObjectJoinOnApproval(order.getApproveId());
                  int tempPid = approveService.selectPidJoinOnApproval(order.getApproveId());
               //   System.out.println("작성자는? "+board.getWriter());
                  ProductVO product = productservice.selectPdt(tempPid);// expected one result or null to be returned by selectOne()
                  TempVO temp = orderservice.getTempByRid(order.getFranchisekey());
                  String ss = temp.getAddress();
                  if(temp.getDetailaddress()!=null){
                     ss += " " + temp.getDetailaddress();
                  }
               
      %>    
      
      <tr>
         <%if(product.getBrand().equals("빽다방")){ %>
            <td><img src = "${pageContext.request.contextPath}/resources/images/paikdabang/<%=product.getImage()%>"/></td>
         <%}else if(product.getBrand().equals("한신포차")){ %>
            <td><img src = "${pageContext.request.contextPath}/resources/images/hanshin/<%=product.getImage()%>"/></td>
         <%} %>
            <td><%=ss%></td>
            <td><%=temp.getName() %></td>
               <td><%=product.getMenu()%></td>
               <td><%=product.getType()%></td>
               <td><%=product.getTemp()%></td>
               <td><%=product.getDetailExplain()%></td>
               <td><%=product.getPrice()%></td>
               <td><%=tt.getReqCount()%></td>
               <td>
               
                  <input type = "hidden" id = "menu" value = "<%=product.getMenu() %>">
                  <input type = "hidden" id = "type" value = "<%= product.getType() %>"/>
                  <input type = "hidden" id = "temp" value = "<%= product.getTemp() %>"/>
                  <input type = "hidden" id = "detailExplain" value = "<%= product.getDetailExplain() %>"/>
                  <input type = "hidden" id = "price" value = "<%= product.getPrice()%>"/>
                  <input type = "hidden" id = "reqCount" value = "<%= tt.getReqCount() %>"/>
                  <input type = "hidden" id = "brand" value = "<%= temp.getBrand()%>"/>
                  <input type = "hidden" id = "imgsrc" value = "<%=product.getImage() %>">
                  <input type = "hidden" id = "rid" value = "<%= tt.getRid()%>"/><!--  franchisekey -->
                  <input type = "hidden" id = "pid" value = "<%=product.getIdx() %>"/>
                  <input type = "hidden" id = "status" value = "<%=tt.getStatus() %>">

                  <input type = "hidden" id = "req_orderid" name = "req_orderid" value = "<%= order.getReq_orderid()%>"/>
               <%if(tt.getStatus().equals("delivered")){ %>
                  <input type = "button"  id = "verifyDelivery" class="verifyDelivery" value = "배송완료" disabled="true">
               <%}else{ %>
               <input type = "button"  id = "verifyDelivery" class = "verifyDelivery" value = "배송확인">
               <%} %>
               </td>
         
      </tr>
   <%} %>
</table>



</body>
</html>