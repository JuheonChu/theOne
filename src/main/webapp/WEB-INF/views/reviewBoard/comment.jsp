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
</head>
<body>
<div class="container">
	<h1>게시판 글 쓰기</h1>
	<form action="addComment?ref=${vo.ref }&indent=${vo.indent}&step=${vo.step}" method="post" enctype="multipart/form-data">
	   <div class="form-group">
		  <label for="writer">작성자 : </label>
	      <input type="text" class="form-control" id="writer" name="writer" required="required" placeholder="작성자"/>
	   </div>
	   <div class="form-group">
	      <label for="title">제목 : </label>
	      <input type="text" class="form-control" id="title" name="title" required="required" placeholder="제목"/>
	   </div>
	   <div class="form-group">
	      <label for="imageFile">파일첨부 : </label>
	      <input type="file" class="form-control" id="imageFile" name="imageFile"/>
	   </div>
	   <div class="form-group">
	  	  <label for="content">내용 : </label>
	 	  <textarea class="form-control" rows="5" id="content" name="content" placeholder="내용"></textarea>
	   </div>
	   
		<button class="btn btn-primary">댓글 달기</button>
  </form>

</div>
</body>
</html>