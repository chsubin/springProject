<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberBucket.jsp</title>
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
	function fDelete(){
		let del="";
		for(let i=0;i<myform.chk.length;i++){
			if(myform.chk[i].checked){
				del+=myform.chk[i].value;
				del+=",";
			}
		}
		if(del==""){
			del = myform.chk.value+",";
		}
		if(del==","){
			alert("환불하실 상품을 골라주세요.");return; 
		}
		
		let url="${ctp}/refund/refundDelete?del="+del;
		window.open(url,"nWin","width=500px,height=800px");
		
		}

	
	</script>
</head>
<body>
<form name="myform">
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
	<p><br/></p>
	<div class="container-fluid text-center" style="width:80%" >
		<div class="container-fluid border">
			<h1 style="font-family:'ChosunNm'" class="pt-5 pl-5 pr-5 text-left">주문 정보</h1>
			<div class="row">
				<div class="col-md-6 p-3">
					<table class="table table-borderless">
						<tr class="table-borderless" >
							<th><h4><b>결제 정보</b></h4></th>
						</tr>
						<tr>
							<th>주문번호 <input type="text" readonly name="mid" value="${ovo.orderIdx}" disabled style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
						<tr>
							<th>결제일 <input type="text" readonly name="mid" value="${ovo.orderDate}"  disabled style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
						<tr>
							<th>아이디 <input type="text" readonly name="mid" value="${ovo.mid}" disabled  style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
						<tr>
							<th>이름 <input type="text" name="name" readonly value="${ovo.name}" disabled  style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
						<tr>
							<th>이메일 주소<input type="text" name="email" readonly value="${ovo.email}" disabled  style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
						<tr>
							<th>도로명 주소
								<input type="text" name="postcode" id="sample6_postcode" value="${fn:substring(fn:split(ovo.address,'/')[0],0,fn:length(fn:split(ovo.address,'/')[0])-1)}" style="height:50px" disabled  class="bg-light mt-3 form-control"/>
								<input type="text" name="roadAddress" id="sample6_address" size="50" value="${fn:substring(fn:split(ovo.address,'/')[1],0,fn:length(fn:split(ovo.address,'/')[1])-1)}"  style="height:50px" disabled  class="bg-light mt-3 form-control"/>
								<input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:substring(fn:split(ovo.address,'/')[2],0,fn:length(fn:split(ovo.address,'/')[2])-1)}" style="height:50px" disabled  class="bg-light mt-3 form-control"/>
								<input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:substring(fn:split(ovo.address,'/')[3],0,fn:length(fn:split(ovo.address,'/')[3]))}"  style="height:50px" disabled  class="bg-light mt-3 form-control"/>
							</th>
						</tr>
						<tr>
							<th>전화번호<input type="text" name="tel" value="${ovo.tel}" style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
					</table>
				</div>
				<div class="col-md-6 pt-3 pb-5">
					<div class=" p-5 mt-5 text-left border" style="width:100%">
						<table class="table table-borderless">
							<tr>
								<th class="text-center" colspan="4"><h4><b>상품 정보</b><br/></h4></th>
							</tr>
							<c:forEach var="bucketVo" items="${orderVos}">
								<tr>
									<td>
										<c:if test="${bucketVo.orderSw>0}">
											<input type="checkbox" name="chk" class="chk" value="${bucketVo.idx}">
										</c:if> &nbsp;&nbsp;
										<img style="width:120px" src="${ctp}/data/ckeditor/product/${bucketVo.FSName}">
									</td>
									<td colspan="2">
										${bucketVo.productName} 
										<c:if test="${bucketVo.orderSw==-1}"><div class="badge badge-danger">환불</div></c:if>
										<br/>
											${bucketVo.optionDetail}
										${bucketVo.optionName} X ${bucketVo.optionNum}<br/><br/>
										 <c:if test="${bucketVo.orderSw==5||bucketVo.subSw=='OK'}"><div class="btn btn-outline-info" onclick="location.href='${ctp}/reviews/reviewsInput?idx=${bucketVo.idx}';">리뷰작성</div></c:if>
									</td>
									<td class="text-right"><fmt:formatNumber pattern="#,##0" value="${bucketVo.totalPrice}"></fmt:formatNumber>
									</td>
								</tr>
							</c:forEach>
							<tr class="table-bordred"><td colspan="4"><hr style="border:solid 1px gray"/></td></tr>
							<tr>
								<td>쿠폰</td>
								<td colspan="3" class="text-right">
									<c:if test="${subVo.couponIdx!=0}">
										<fmt:formatNumber pattern="#,##0" value="-${subVo.couponPrice}"/>원
									</c:if>
									<c:if test="${subVo.couponIdx==0}">
										-0원
									</c:if>
								</td>
							</tr>
							<tr>
								<td>포인트</td>
								<td colspan="3" class="text-right">
									<c:if test="${subVo.point!=0}">
										<fmt:formatNumber pattern="#,##0" value="-${subVo.point}"/>원
									</c:if>
									<c:if test="${subVo.point==0}">
										-0원
									</c:if>
								</td>
							</tr>
							<tr>
								<td>배송비</td>
								<td colspan="3" class="text-right">
									${subVo.deliveryPrice}원
								</td>
							</tr>
							<tr class="table">
								<td ><h4><b> 총 결제금액 </b></h4></td>
								<td colspan="3" class="text-right">
									<h4><b> 
										<c:if test="${ovo.orderSw==0}"><div class="badge badge-danger">미결제</div></c:if>
										<c:if test="${ovo.orderSw!=0}"><div class="badge badge-success">결제완료</div></c:if>
										<fmt:formatNumber pattern="#,##0" value="${subVo.totalPrice}"/>원
									</b></h4>
								</td>
							</tr>
						</table>
					</div>
					<c:if test="${!empty sMid}"><div class="btn btn-info btn-lg form-control" onclick="location.href='${ctp}/member/memberOrderList'">내 주문내역 보기</div></c:if>
					<div class="btn btn-danger btn-lg form-control" onclick="fDelete()">환불신청등록</div>
				</div>
			</div>
	
		</div>
	</div>
	<div style="height:50px;"></div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</form>
</body>
</html>
