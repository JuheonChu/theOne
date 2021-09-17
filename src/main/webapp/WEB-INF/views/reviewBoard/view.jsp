<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 보기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<h1>게시판 글 보기</h1>
	<table class="table">
		<tr>
			<th>글 번호</th>
			<td>${vo.no }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${vo.title }</td>
		</tr>
		<tr>
			<th>이미지</th>
			<td><img src="${pageContext.request.contextPath}/resources/images/review/${vo.fileName}" height="100"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><pre style="border:none;">${vo.content }</pre></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${vo.writer }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${vo.writeDate }</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${vo.hit }</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="comment?no=${vo.no }&inc=0" class="btn btn-default">댓글</a>
				<a href="update?no=${vo.no }&title=${vo.title}&content=${vo.content}&writer=${vo.writer}" class="btn btn-primary">수정</a>
				<a href="deleteAction?no=${vo.no }" class="btn btn-danger" onclick="return confirm('${vo.no}번 글을 삭제 하시겠습니까??')">삭제</a>
				<a href="list" class="btn btn-default">리스트</a>
			</td>
		</tr>
	</table>
</div>
</body>
</html>