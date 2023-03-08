<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>환불 상세 페이지</title>
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
  	
  	function fRefund(){ //환불신청 등록
			let refundDetail = myform.refundDetail.value;
			if(refundDetail.trim()==""){alert("환불 사유를 입력해주세요.");};
			const regNum=/^[0-9]*$/gm;
			let minusPoint = myform.minusPoint.value;if(!minusPoint.match(regNum)){alert("차감 포인트를 숫자로 입력해주세요.");myform.minusPoint.focus();return;}
			let plusPoint = myform.plusPoint.value;if(!plusPoint.match(regNum)){alert("반환 포인트를 숫자로 입력해주세요.");myform.plusPoint.focus();return;}
			let deliveryPrice = myform.deliveryPrice.value;if(!deliveryPrice.match(regNum)){alert("배송비를 숫자로 입력해주세요.");myform.deliveryPrice.focus();return;}
			let couponUse = myform.couponUse.value;if(!couponUse.match(regNum)){alert("쿠폰사용금액을 숫자로 입력해주세요.");myform.couponUse.focus();return;}
			let totalRefund = myform.totalRefund.value;if(!totalRefund.match(regNum)){alert("총 환불 금액을 숫자로 입력해주세요.");myform.totalRefund.focus();return;}
			let idx = myform.idx.value;
			let mid = myform.mid.value;
			
			
			let query={
					idx:idx,
					minusPoint:minusPoint,
					plusPoint:plusPoint,
					deliveryPrice:deliveryPrice,
					couponUse:couponUse,
					totalRefund:totalRefund,
					mid:mid
			};
			
			$.ajax({
				type:"post",
				url:"${ctp}/admin/refund/refundUpdateOK",
				data: query,
				success:function(){
			  		opener.location.reload();
			  		window.close();
				},
				error:function(){
					alert("수정 실패");
				}
			});
  	}
  	
	
  	
  </script>
</head>
<body class=" bg-light">
<form name="myform" method="post">
	<p><br/></p>
	<div class="container-fluid message">
	  <h1 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/main/상담.JPG" style="width:80px"/>&nbsp;&nbsp; 환불 금액 수정</b></h1>
	  <table class="table bg-white" >
		<c:forEach var="bucketVo" items="${ordersVos}">
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
			<td style="width:25%"><input type="text" name="minusPoint" value="${refundVo.minusPoint}" class="form-control"/></td>
			<td>반환포인트</td>
			<td  style="width:25%"><input type="text" name="plusPoint" value="${refundVo.plusPoint}"   class="form-control"/></td>
		</tr>
		<tr class="table-bordered">
			<td>소비자부담 <br/>배송비</td>
			<td><input type="text" id="delivery" value="${refundVo.deliveryPrice}" name="deliveryPrice"  class="form-control"/></td>
			<td>쿠폰사용금액</td>
			<td><input type="text" value="${refundVo.couponUse}"  name="couponUse"  class="form-control"/></td>
		</tr>
		<tr class="table-bordered">
			<td>총 환불금액</td>
			<td colspan="3"><input type="text" id="refundPrice" name="totalRefund" value="${refundVo.totalRefund}"  class="form-control"/></td>
		</tr>
		<tr class="table-bordered">
			<td>상환 아이디</td>
			<td colspan="3"><input type="text" id="mid" name="mid" value="${refundVo.mid}"  class="form-control"/></td>
		</tr>
		<tr><td colspan="4" class="m-0 p-0">
		<input type="button" class="btn btn-warning form-control" onclick="fRefund()" value="수정하기"/>
		</td></tr>
		</table>
		<h3 class="mt-5">환불사유</h3>
		<table class="table">
			<tr>
				<td>환불사유</td>
				<td>
					<select id="detail" disabled="disabled"  name="refundReason" class="form-control">
						<option value="1" ${refundVo.refundReason==1?'selected':''}>배송지연</option>
						<option value="2" ${refundVo.refundReason==2?'selected':''}>상태불량</option>
						<option value="3" ${refundVo.refundReason==3?'selected':''}>단순변심</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>상세사유</td>
				<td>
					<textarea rows="5" class="form-control" name="refundDetail" disabled="disabled">${refundVo.refundDetail}</textarea>
				</td>
			</tr>
		</table>
	</div>
	<p><br/></p>
	<input type="hidden" name="idx" value="${refundVo.idx}"/>
</form>
</body>
</html>