<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정/Users/updateform.jsp</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
</head>
<body>
<section id="context">
 <form action="update.do" method="post">
 	<div class="input_area">
 		<h2>개인정보 수정 페이지</h2>
 		<div>
 			<label for="userId">ID</label>
 			<input type="text" name="userId" id="Id" readonly="readonly" value="${dto.getUserId() }" />
 		</div>
 		<div>
 			<label for="userName">이름</label>
 			<input type="text" name="userName" id="newuserName" required="required" value="${dto.getUserName() }" />
 		</div>
 		<div>
 			<label for="userPhone">연락처</label>
 			<input type="text" name="userPhone" id="newUserPhone" />
 		</div>
 		<div>
 			<label for="email">E-mail</label>
 			<input type="text" name="email" id="newemail" required="required" />
 		</div>
  		<div class="container" ng-class="{'has-success':myForm.userAddr1.$valid,'has-error':myForm.userAddr1.$invalid &&myForm.userAddr1.$dirty}">
            <label for="userAddr1">우편 번호 <strong id="required">*</strong></label>
            <input type="text" name="userAddr1" id="userAddr1" placeholder="우편번호" ng-model="userAddr1" ng-required="true"/>
            <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
            <span ng-show="myForm.userAddr1.$valid" class="glyphicon glyphicon-ok form-control-feedback"></span>
            <span ng-show="myForm.userAddr1.$invalid && myForm.userAddr1.$dirty" class="glyphicon glyphicon-remove form-control-feedback"></span>
         </div>
         
         <div class="container" ng-class="{'has-success':myForm.userAddr2.$valid,'has-error':myForm.userAddr2.$invalid &&myForm.userAddr2.$dirty}">
            <label for="userAddr2">기본 주소 <strong id="required">*</strong></label>
            <input type="text" name="userAddr2" id="userAddr2" placeholder="기본주소" ng-model="userAddr2" ng-required="true"/>
            <span ng-show="myForm.userAddr2.$valid" class="glyphicon glyphicon-ok form-control-feedback"></span>
            <span ng-show="myForm.userAddr2.$invalid && myForm.userAddr2.$dirty" class="glyphicon glyphicon-remove form-control-feedback"></span>
         </div>
         <span id="guide" style="color:#999;display:none"></span>
         <div class="container">
            <label for="userAddr3">상세 주소</label>
            <input type="text" name="userAddr3" id="userAddr3" placeholder="상세주소"/>
  		</div>
 		
 		<button type="submit" id="update_Btn" name="update_Btn">개인정보 수정완료</button>
 	</div>
 </form>	
</section>
<!-- 다음 주소 API 사용 -->     
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
             
    new daum.Postcode({
       oncomplete: function(data) {
       // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
       
       // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
       // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
       var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
       var extraRoadAddr = ''; // 도로명 조합형 주소 변수
       
       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraRoadAddr += data.bname; }
       // 건물명이 있고, 공동주택일 경우 추가한다.
       if(data.buildingName !== '' && data.apartment === 'Y'){
                         extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName); }
       // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
       if(extraRoadAddr !== ''){
                          extraRoadAddr = ' (' + extraRoadAddr + ')'; }
       // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
       if(fullRoadAddr !== ''){
                          fullRoadAddr += extraRoadAddr; }
       
       // 우편번호와 주소 정보를 해당 필드에 넣는다.
       document.getElementById('userAddr1').value = data.zonecode; //5자리 새우편번호 사용
       document.getElementById('userAddr2').value = fullRoadAddr;
       //document.getElementById('userAddr3').value = data.jibunAddress;
                  
       // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
       if(data.autoRoadAddress) {
          //예상되는 도로명 주소에 조합형 주소를 추가한다.
          var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
          document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
       
          } else if(data.autoJibunAddress) {
            var expJibunAddr = data.autoJibunAddress;
            document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
       	  } else {
            document.getElementById('guide').innerHTML = '';
            }
               }
              }).open();
          }        
</script>
</body>
</html>