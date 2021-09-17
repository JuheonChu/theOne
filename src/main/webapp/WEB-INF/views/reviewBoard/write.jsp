<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 쓰기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js"></script>
</head>
<body>
<div class="container">
	<h1>게시판 글 쓰기</h1>
	<form action="writeAction" method="post" enctype="multipart/form-data">
		<!-- pattern=".{0,0}" 몇자부터 몇자까지 글자제한 
	     	 requiref="requiref" not null
	   --> 
	   <div class="form-group">
		  <label for="writer">작성자 : </label>
	      <input type="text" class="form-control" id="writer" name="writer" required="required" placeholder="작성자"/>
	   </div>
	   
	   
	 <%--<div class="form-group">
	      <label for="title">제목 : </label>
	      <input type="text" class="form-control" id="title" name="title" required="required" placeholder="제목"/>
	   </div>
 --%>  	   
	   <div class="form-group">
         <label for="title">제목 : </label>
         <input type="text" class="form-control" id="title" name="title" required="required" placeholder="ex[빽다방 신촌점] 제목"/>
      </div>
	   
	   <div class="form-group">
	      <label for="imageFile">파일첨부 : </label>
	      <input type="file" class="form-control" id="imageFile" name="imageFile"/>
	   </div>
	   <div class="form-group">
	  	  <label for="content">내용 : </label>
	 	  <textarea class="form-control" rows="5" id="content" name="content" placeholder="내용"></textarea>
	   </div>
	   
		<button class="btn btn-primary">글 쓰기</button>
  </form>

<script type="text/javascript">
//1 첫번째
CKEDITOR.replace( 'content', {
          width:'100%',
          height:'500px'
});
</script>
</div>
</body>
</html>