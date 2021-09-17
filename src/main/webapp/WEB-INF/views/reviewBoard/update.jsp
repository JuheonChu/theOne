<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 수정</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js"></script>
  
  <script type="text/javascript">
  	/* $(function() {
		$(".cancelBtn").click(function() {
			history.back();
		});
  	}); */
  </script>
</head>
<body>
<div class="container">
	<h1>게시판 글 수정</h1>
	<form action="updateAction" method="post">
		<!-- pattern=".{0,0}" 몇자부터 몇자까지 글자제한 
	     	 requiref="requiref" not null
	   --> 
	    <div class="form-group">
		  <label for="writer">글 번호 : </label>
	      <input type="text" class="form-control" id="no" name="no" readonly="readonly" value="${vo.no }">
	   </div>
	   <div class="form-group">
		  <label for="writer">작성자 : </label>
	      <input type="text" class="form-control" id="writer" name="writer" readonly="readonly" value="${vo.writer }">
	   </div>
	   <div class="form-group">
	      <label for="title">제목 : </label>
	      <input type="text" class="form-control" id="title" name="title" required="required" value="${vo.title }">
	   </div>
	   <div class="form-group">
	      <label for="imageFile">파일첨부 : </label>
	      <input type="file" class="form-control" id="imageFile" name="imageFile" value="${vo.fileName }"/>
	   </div>
	   <div class="form-group">
	  	  <label for="content">내용 : </label>
	 	  <textarea class="form-control" rows="5" id="content" name="content" required="required">${vo.content }</textarea>
	   </div>
		<button class="btn btn-primary">글 쓰기</button>
		<button type="reset" class="btn btn-warning">새로 입력</button>
		<a href="list" class="btn btn-danger">취소</a>
		
  </form>
</div>
</body>
<script type="text/javascript">
CKEDITOR.replace( 'content', {
          width:'100%',
          height:'500px'
});
</script>
</html>