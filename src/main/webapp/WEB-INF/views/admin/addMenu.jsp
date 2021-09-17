<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
    <%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] { display:block; }
input { width:150px; }
textarea#gdsDes { width:400px; height:180px; }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>

<script>
$(function(){

	$("#addBtn").click(function(){

		if(!$("#menu").val() || !$("#price").val() || !$("#salaryprice").val() || !$("#detailExplain").val() || !$("#image").val()){
			alert("모든 항목을 입력하십시오!");
		}

		document.form1.action = "${pageContext.request.contextPath}/headquarter/addmenuSub";
		document.form1.submit();
	});
		
	
	$("option:selected", this).each(function(){
		var selectedVal = $(this).val();
		
	});
});
	
</script>
</head>
<% List<String> brandlist = new ArrayList<String>();
brandlist.add("빽다방");
brandlist.add("한신포차");
%>
<body>
<h3>상품등록</h3>
<form id = "form1" name = "form1" method = "post" role = "form" autocomplete = "off" accept-charset="UTF-8">
	<table border="1">
		<tr>
			<td>상품브랜드</td>
			<td>
			<select id = "category1" class = "brand"  id = "brand" name = "brand">
				<%for(int i =0; i < brandlist.size();i++){ %>
				<option value = "<%=brandlist.get(i)%>"><%=brandlist.get(i) %></option>
				<%} %>
			</select>
			</td>
		</tr>
	
		<tr>
			<td>상품명</td>
			<td><input type = "text" name = "menu" id = "menu" required = ""></td>
		</tr>
		
		<tr>
			<td>상품분류</td>
			<td><input type = "text" name = "type" id = "type" required = ""></td>
		</tr>
		
		<tr>
			<td>상품(ICE/BASIC/SOFT/HOT) 여부</td>
			<td><input type = "text" name = "temp" id = "temp"></td>
		</tr>
		
		<tr>
			<td>원가</td>
			<td><input type = "text" name = "price" id = "price" required = ""/></td>
		</tr>
		
		<tr>
			<td>판매가</td>
			<td><input type = "text" name = "salaryprice" id = "salaryprice" required = ""/></td>
		</tr>
		
		<tr>
			<td>상품설명</td>
			<td><textarea row = "5" cols = "60" name = "detailExplain" id= "detailExplain" required = ""></textarea></td>
		</tr>
		<tr>
			<td>상품이미지</td>
			<td><input type = "text" id = "image" name = "image" required = ""></td>
		</tr>
		
		<tr>
			<td>상품등록</td>
			<td align = "center">
				<input type = "button" value = "등록" id = "addBtn">
			</td>
		</tr>
	
	</table>



</form>
</body>
</html>