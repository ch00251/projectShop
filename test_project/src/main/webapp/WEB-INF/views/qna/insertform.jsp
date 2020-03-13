<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/private/insertform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* textarea 의 크기가 SmartEditor 의 크기가 된다. */
	#content{
		
		width: 100%;
		height: 400px;
	}
</style>
</head>
<body>
<div class="container">
	<ol class="breadcrumb">
		<li><a href="${pageContext.request.contextPath }/qna/list.do">목록</a></li>
		<li>새글 작성</li>
	</ol>
	<form action="insert.do" method="post">
		<div class="form-group">
			<label for="writer">작성자</label>
			<input class="form-control" type="text" value="${id }" disabled/>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" type="text" 
				name="title" id="title"/>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content" cols="30" rows="10"></textarea>
		</div>
		<button class="btn btn-primary" type="submit" onclick="submitContents(this);">저장</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
</div>

</body>
</html>