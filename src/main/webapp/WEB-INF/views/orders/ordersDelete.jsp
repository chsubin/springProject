<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1대1 문의</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <style>
  	@font-face {
    font-family: 'ChosunNm';
    font-weight: normal;
    font-style: normal;
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot');
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot?#iefix') format('embedded-opentype'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff2') format('woff2'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff') format('woff'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.ttf') format("truetype");
    font-display: swap;
		}
  </style>
  <script>
  	'use strict';
  	
  	
  	$(function() {
  		$("#message").scrollTop(1000000);
  	 });
  	
  	function inputQNA(){
  		let part= myform.part.value;
  		let content = myform.content.value;
  		if(content.trim()==""){
  			alert("내용을 입력해주세요.");
  			return false;
  		}
  		
	  	$.ajax({
	  		type:"post",
	  		url:"${ctp}/qna/qnaInput",
	  		data:{questionId:"${sMid}",part:part,question:content},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  	
  	}
  	
  	function fRefund(){
  	}
  	
	$(function(){
		$("#detail").change(function(){
			let detail = $("#detail").val();
			if(detail>2){
				if("${subVo.deliveryPrice}">0) $("#delivery").val("${basisVo.deliveryPrice}");//배송비를 이미 냈을경우
				else if("${subVo.totalPrice}"-"${productPrice}">"${basisVo.deliveryMinPrice}"){
					$("#delivery").val("${basisVo.deliveryPrice}");
				}
				else {
					$("#delivery").val("${basisVo.deliveryPrice}"*2);//배송비를 안냈을경우
				}
			}
			else{
				$("#delivery").val(0);
			}
			let refundPrice = $("#refundPrice").val();
			let delivery = $("#delivery").val();
			$("#refundPrice").val(refundPrice-delivery);
			
		});
		
		
		
	});
	
  	
  </script>
</head>
<body class=" bg-light">
<form name="myform" >
	<p><br/></p>
	<div class="container-fluid message">
	  <h1 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/main/상담.JPG" style="width:80px"/>&nbsp;&nbsp; 환불 신청 등록</b></h1>
	  <table class="table bg-white" >
		<c:forEach var="bucketVo" items="${vos}">
			<tr>
				<td>
					 <img style="width:120px" src="${ctp}/data/ckeditor/product/${bucketVo.FSName}">
				</td>
				<td colspan="2">
					${bucketVo.productName}
					<br/>
						${bucketVo.optionDetail}
					${bucketVo.optionName} X ${bucketVo.optionNum}<br/><br/>
				</td>
				<td class="text-right">${bucketVo.totalPrice}
				</td>
			</tr>
		</c:forEach>
		<tr class="table-bordered">
			<td>차감포인트</td>
			<td style="width:25%"><input type="text" value="${offPoint}" readonly  class="form-control"/></td>
			<td>반환포인트</td>
			<td  style="width:25%"><input type="text" value="${onPoint}"  readonly  class="form-control"/></td>
		</tr>
		<tr class="table-bordered">
			<td>소비자부담 <br/>배송비</td>
			<td><input type="text" id="delivery" value="0" readonly  class="form-control"/></td>
			<td>쿠폰사용금액</td>
			<td><input type="text" value="${coupon}" readonly  class="form-control"/></td>
		</tr>
		<tr class="table-bordered">
			<td>총 환불금액</td>
			<td colspan="3"><input type="text" id="refundPrice" value="${productPrice}" readonly  class="form-control"/></td>
		</tr>
		<tr><td colspan="4" class="m-0 p-0"></td></tr>
		</table>
		<h3 class="mt-5">환불사유 입력</h3>
		<table class="table">
			<tr>
				<td>환불사유</td>
				<td>
					<select id="detail" name="detail">
						<option value="1">배송지연</option>
						<option value="2">상태불량</option>
						<option value="3">단순변심</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>상세사유</td>
				<td>
					<textarea rows="5" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" class="btn btn-danger form-control" onclick="fRefund()" value="등록"/>
				</td>
			</tr>
		</table>
	</div>
	<p><br/></p>
</form>
</body>
</html>