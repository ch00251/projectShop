<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/style/style.css">
</head>
<body>
	<div class="home_div">
		<img alt="" src="resources/images/제목-없음-1.png" class="home_img1">
		<img alt="" src="resources/images/제목-없음-111.gif" class="home_img2">
	</div>
	
	<script>
		$('.home_div').mouseover(function(){
			$('.home_img1').prop("style","z-index:-1");
		});
		$('.home_div').mouseout(function(){
			$('.home_img1').prop("style","z-index:1");
		});
		$('.home_div').mouseup(function(){
			location.href="index.do";
		})
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>