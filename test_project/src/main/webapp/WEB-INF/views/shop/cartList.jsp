<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/cartList</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include> 
</head>
<body>
<div id="root">
		<header>
			<div class="header_box">
				<nav id="nav">
					<div class="navbar-right">
						<%@ include file="../include/nav.jsp"%>
					</div>
					<div id="index_logo_div">
						<a href="../index.do"><img id="index_logo_img"
							src="${pageContext.request.contextPath }/resources/images/project.png" /></a>
					</div>
					<div class="navbar-left">
						<c:choose>
							<c:when test="${not empty sessionScope.id }">
								<%@ include file="../include/users_aside.jsp"%>
							</c:when>
							<c:otherwise>
								<%@ include file="../include/unknown_aside.jsp"%>
							</c:otherwise>
						</c:choose>
					</div>
				</nav>
			</div>
		</header>
	</div>
	<div class="container">
		<h1>Cart</h1>
		<c:choose>
			<c:when test="${map.count==0 }">
				장바구니가 비어있습니다.
			</c:when>
			<c:otherwise>
				<div class = "buy" style="float:right">
		<button class="btn btn-warning" id="buyEach" style="float:left">삭제</button>		
	</div>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th><input type="checkbox" id="AllCheck"/></th>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>수량</th>
				<th>최종 가격</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="sumMoney" value="0"/>
		<c:forEach var="tmp" items="${map.list }" varStatus="i">
			<tr>
				<td> 
					<input type="checkbox" name="delBox" value="${tmp.cartNum }"/>
				</td>
				<td><img src="../resources/${tmp.itemImg }" width="156px" height="120px"/></td>
				<td> <a href="../Users_Item/itemView_form.do?itemNum=${tmp.itemNum}">${tmp.itemName}</a></td>
				<td>
					<input type="hidden" id="itemPrice" />
                	<fmt:formatNumber value="${tmp.itemPrice}" 
                    	 pattern="###,###,###"/>원
                </td>
				<td>
               	<input type="number" min="1" value="${tmp.cartStock }" style="width:40px" name="cartStock" id="${tmp.cartNum }"/>
               	<input type="hidden" name="itemNum" value="${tmp.itemNum }" />
               	<button type="button" class="btn btn-primary" id="${tmp.cartNum }">수정</button>             	
                </td>
				<td>
					
                	<fmt:formatNumber value="${tmp.cartStock * tmp.itemPrice}" 
                     pattern="###,###,###"/>원
                </td>
			</tr>
			 <c:set var="sumMoney" value="${sumMoney+(tmp.cartStock * tmp.itemPrice) }"/>
		</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button type="button" class="btn btn-primary"
						onclick="location.href='orderform.do'">주문하기</button>
				</td>
				<td>
					<button type="button" class="btn btn-warning"
						onclick="location.href='../index.do'">쇼핑계속</button>
				</td>
			</tr>
		</tfoot>
	</table>
	 <table class="table table-hover">
         <thead>
            <tr>
               <th>총 상품금액</th>
               <th>총 배송비</th>
               <th>결제예정금액</th>
            </tr>
         </thead>
         <tbody>
            <tr> 
               <c:set var="allPrice" value="${sumMoney+fee }"/>
               <td>
                  <fmt:formatNumber value="${sumMoney }" 
                  pattern="###,###,###"/>원
               </td>
               <td>
               +<fmt:formatNumber value="${map.fee }" 
                  pattern="###,###,###"/>원
               </td>
               <td>
                  <fmt:formatNumber value="${map.allPrice }" 
                  pattern="###,###,###"/>원
               <input  type="hidden" name="allPrice" id="allPrice"
                     value="${allPrice}" />
               </td>
               
            </tr>
         </tbody>
      </table>
			</c:otherwise>
		</c:choose>
	
	 
	</div>
	<!-- 전부 선택 -->
	<script type="text/javascript">
		 $("#AllCheck").click(function(){
			if($("#AllCheck").prop("checked")){
				$("input[name=delBox]").not("[disabled]").prop("checked",true);
			}else {
				$("input[name=delBox]").prop("checked", false);
			}
		});
		$("#buyEach").click(function(){
			 var eachSize=$("input[name=delBox]:checked").length;
	         if(eachSize==0){
	            alert("1개 이상 체크해주세요.");
	            return false;
	         }
		var arrCheckBox=[];
		$("input[name=delBox]:checked").each(function(i) {
			arrCheckBox.push($(this).val());
		});
		
		  $.ajax({
              url: "deleteEachCart.do", //이동할 주소
              type: "post", //form 전송 방식
              data:
                 //데이터는 arrEachCode라는 이름으로 배열 전달
                 {"arrCheckBox": arrCheckBox},
                 //ajax 성공이라면 전달된값을 전달자로 받아 함수실행
              success:function(responseData){
                 if(responseData.isSuccess){
                    //알림 띄우고 새로고침
                    alert("성공.");
                    location.reload();
                 }else{                    
                    alert("실패.");
                 }
              }   
           });
      });
   </script>      
   <script type="text/javascript">
   var tag = null;
   var targetVal = null;
   		$("input[type=number]").click(function(){
   			tag=$(this).attr("id");
   			console.log(tag);
   			targetVal = $(this).val();
   			console.log(targetVal);
   		})
   		$("button[type=button]").click(function() {	
			var tarArray=[];
			tarArray.push(tag);
			tarArray.push(targetVal);   
			console.log(tarArray);
   			$.ajax({
   				url:"updateCartStock.do",
   				type: "post",
   				data:{"tarArray":tarArray},
   				success:function(responseData){
                    if(responseData.isSuccess){
                       //알림 띄우고 새로고침
                       alert("성공.");
                       location.reload();
                    }else{                    
                       alert("실패.");
                    }
   				}
   			})
			})
   </script>   
   <footer id="footer">
      <div id="footer_box">
         <%@ include file="../include/footer.jsp" %>
      </div>      
   </footer>
</div>
</body>
</html>