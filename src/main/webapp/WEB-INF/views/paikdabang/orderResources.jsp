<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.project.vo.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>주문 재고요청</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/paikdabang/orderResources.css" />
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script>
	$(function(){//수량 증가

		$(".qtyqty").keydown(function() {

			var qty = $(this).val();
			var price = $(this).parent().find("input#gagyuk").val();
			

			var total = $(this).parent().parent().parent().find("td span").text(price * qty + "원"); //이값을잡아야합니다...................
			//alert(total);
			

			//total.val(price*qty);
			//var finalTotal = total.val();
			//alert(finalTotal);	
		});

		$(".plus").click(function() {

			var quantity = $(this).parent().find("input#quantity").val(); // $("#quantity").val();

			var price = $(this).parent().find("input#gagyuk").val(); //상품가격(alert)

			
				quantity++;

				$(this).parent().find("input#quantity").val(quantity);

				var newqty = $(this).parent().find("input#quantity").val();

				$(this).parent().parent().parent().find("td span").text(newqty * price + "원");
								//alert(newqty*price);// 이 가격으로 최종가격 설정해야함.
	  });
				//수량 감소
				$(".minus").click(function() {
					var quantity = $(this).parent().find("input#quantity").val(); // $("#quantity").val();
					var price = $(this).parent().find("input#gagyuk").val(); //상품가격(alert)

					if (quantity > 1) { //1이상일 때만 감소 가능
						quantity--;
						$(this).parent().find("input#quantity").val(quantity);

						var newqty = $(this).parent().find(	"input#quantity").val();

						$(this).parent().parent().parent().find("td span").text(newqty * price + "원");
					}
					//10개까지 구매 가능한거 지움
					$(this).parent().parent().find("div span").text("");
				});


				$(".buy").click(function() {

							event.preventDefault();
					
							var quantity = $(this).parent().parent().find("input#quantity").val();
							var price = $(this).parent().parent().find("input#gagyuk").val();
							var imgsrc = $(this).parent().find("input#imgsrc").val();
							var franchisekey = $(this).parent().find("input#franchisekey").val();
							var pid = $(this).parent().find("input#pid").val();
							var status = $(this).parent().find("input#status").val();
							var available = $(this).parent().find("input#available").val();
							
							var warn = confirm("해당 상품을 주문하시겠습니까??");
							if (warn) {

								var data = {
									quantity: quantity,
									price: price,
									imgsrc: imgsrc,
									franchisekey: franchisekey,
									pid: pid,
									status: status,
									available: available
								};
								
								
								$.ajax({
									url : 'http://192.168.6.118:8080/rest2/vo/order/product/to/hq',
									data : JSON.stringify(data),
									dataType:'json',
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
			})
		
			
</script>
<style>
	img{
		width:250px;
	}
</style>

<%
	//List <ResourcesOrderVO> boardList = (List<ResourcesOrderVO>)(request.getAttribute("list"));
	//int totalRowCount = ((Integer) request.getAttribute("totalRowCount")).intValue();
	//int currentPage = ((Integer) request.getAttribute("page")).intValue();
	//int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	//int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	//int endPage = ((Integer) request.getAttribute("endPage")).intValue();
%>
<style>
.quantity-manipulation {
	display: inline-flex;
}

table {
	width: 1000px;
}

 tr>{
	border:1px solid black;
}
</style>
</head>
<body>
	<%
		List<ProductVO> orderArr = (List<ProductVO>)session.getAttribute("menulist");
		String franchisekey = (String)request.getAttribute("key");
		System.out.println("franchisekey: " + franchisekey);
		String status = "waiting";
		System.out.println(orderArr);
		MemberVO member = (MemberVO)request.getAttribute("ceo");
		int quantity = 0;
		
		String sender = member.getId();
		String receiver = "admin";
		
		String address = null;
		String detailaddress = null;
		
		try{
			address = member.getAddress();
			detailaddress = member.getDetailaddress();
		}catch(Exception e){
			address = " ";
			detailaddress = " ";
		}
	%>
	

	<div style = "margin-top:50px; text-align:center;">
	<h2><%=(String)request.getSession().getAttribute("userid") %>님 주문</h2>
	</div>


	<div class="content" style= "margin: 0 auto; margin-top:20px;">


		<table class="barsket_list" id="mytable" style = "margin:0 auto;">
			<tr>
				<th class="td_h"></th>
				<th class="td_h">상품번호</th>
				<th class="td_h">상품 이름</th>
				<th class="td_h">상품 가격</th>
				<th class="td_h">상품 갯수</th>
				<th class="td_h">결제금액</th>
				<th class="td_h">주문</th>
			</tr>
			<%
				for (int i = 0; i < orderArr.size(); i++) {
					ProductVO pdt = orderArr.get(i);
					
			%>
			<tbody>
				<tr class = "hero">
					<td><%=pdt.getIdx() %></td>
					<td class="td_b"><img id="img" src="${pageContext.request.contextPath}/resources/images/paikdabang/<%=pdt.getImage()%>" /></td>
					<td class="td_b"><%=pdt.getDetailExplain()%></td>
					<td id="price" class="td_b"><%=pdt.getPrice()%>원</td>
					<td class="td_b_r">
						<div class="quantity-manipulation">
							<input type="button" value="-" class="p_down minus" /> 
							<input type="text" id="quantity" class="qtyqty" name="quantity" class="p" value="<%=quantity%>" style="text-align: center; width: 105px;" /> 
							<input type="button" value="+" class="p_up plus" /><br /> 
							 
							<input type="hidden" id="gagyuk" class="gagyuk" value="<%=pdt.getPrice()%>" /> 
							<input type="hidden" id="sum" class="sum" value="<%=pdt.getPrice() * quantity%>" />
							
						</div>
						
						<div>
							<span id="quantity-inform"></span>
						</div>
					</td>
					
					<td><span id="payment" class="payment"><%=quantity* pdt.getPrice()%></span></td>
					
					<td>
							<input type="button" class ="buy" name="purchase" value="구매"/>
							<input type = "hidden" id = "franchisekey" value = "<%=franchisekey %>" name = "rid">
							<input type = "hidden" id = "pid" value = "<%=pdt.getIdx()%>" name = "pid">
							<input type = "hidden" id = "reqCount" value = "" name = "reqCount">
							<input type = "hidden" id = "status"  value = "<%= status%>" name = "status">
							<input type = "hidden" id = "imgsrc" value = "<%=pdt.getImage() %>" name = "imgsrc">
							<input type = "hidden" id = "available" value = "<%= 0 %>" name = "available">
							

					</td>					
				</tr>
			</tbody>
			<%
				}
			%>

 

</body>
</html>