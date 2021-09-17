<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "com.project.service.*" %>
     <%@ page import = "com.project.vo.*" %>
         <%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signUp.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/signUp.js"></script>

<script>
   function fn_idCheck() {
      $.ajax({
         url : "/member/idCheck",
         type : "post",
         dataType : "json",
         data : {"id" : $("#id").val()},
         success : function(data) {
            if (data == 1) {
               alert("이미 존재하는 아이디 입니다.");
            } 
            else if (data == 0) {
               $("idCheck").attr("value", "Y");
               alert("사용 가능한 아이디 입니다.");
            }
         }
      })
   }
</script>
</head>
<body>
<% MemberService service = (MemberService)request.getAttribute("service");
   List<MemberVO> memberlist = service.selectAll();
   if("nameduplication".equals(request.getParameter("message"))){ //같은이름으로 회원가입할수없음!%>
         <script>alert("해당 회원은 이미 존재하는 회원입니다!")</script>
   <%} %>
   
<div class="container">
   <fieldset>
      <legend>회원가입</legend>
         <form action="${pageContext.request.contextPath}/member/signupAction.do" method="post" id="signUpForm" enctype="multipart/form-data">
         <div class="form-group">
            <label for="id">아이디</label>
            <input type="text" name="id" id="id" class="form-control" size="10"/>
            <button class="btn btn-primary" type="button" id="idCheck" onclick="fn_idCheck();" value="N">중복확인</button> <br/>
         </div>
         <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" size="10"/> <br/>
            <div class="password regex"></div>
         </div>
         
         <div class="form-group">
            <label for="passwordCheck">비밀번호 확인</label>
            <input type="password" id="passwordCheck" class="form-control" size="10"/> <br/>
            <div class="passwordCheck regex"></div>
         </div>
         
         <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" class="form-control" size="10"/> <br/>
         </div>
         <div class="email regex"></div>
         
         <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="text" name="phone" id="phone" class="form-control" size="10"/> <br/>
            <div class="phone regex"></div>
         </div>
         
         <div class="form-group">
            <label for="address">주소</label>
            <input type="text" id="postcode" placeholder="우편번호" name="postcode" class="form-control" size="5" style = "width:150px;">
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br>
            <input type="text" id="address" placeholder="주소" name="address" class="form-control" size="15" style = "width:350px;"><br/>
            <input type="text" id="detailAddress" placeholder="상세주소" name="detailaddress" class="form-control" size="15" style = "width:350px;"><br/>
            
         </div>
         
         <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" id="name" class="form-control" size="10"/> <br/>
            <div class="name regex"></div>
         </div>
         
         <div class="form-group">
            <label for="id">이미지(선택)</label>
            <input type="file" name="multipart"/>
         </div>
         
         <input type="submit" class="btn btn-primary" value="등록"/>
         <input type="reset" value="다시입력" class="btn btn-warning" id="resignupbtn">
         <input type="button" value="취소" class="btn btn-danger" onclick="location.href='javascript:history.back()'">
      </form>
   </fieldset>
</div>
</body>
</html>