<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
		.cli{
			cursor:pointer;
		}
	</style>
	<script>
		'use strict';

	
	</script>
</head>
<body>
<div class="container-fluid " style="width:80%;" >
	<div class="row bg-light" >
		<div class="col-md-4 border shadow bg-white" style="height:100vh" >
			<jsp:include page="memberMenu.jsp"/>
		</div>
		<div class="col-md-8 fadein p-3" style="overflow:auto;height:100vh">
			<table  class="table border text-center table-borderless shadow form-group bg-white" onclick="location.href='memberUpdate';">
				<tr>
					<td colspan="4">
						<h2 class="text-left pl-5">나의 정보</h2>
					</td>
				</tr>
				<tr >
					<td><h4>구분</h4></td>
					<td>
						<h4>
							<c:if test="${sLevel==0}">관리자</c:if>
							<c:if test="${sLevel==1}">운영자</c:if>
							<c:if test="${sLevel==2}">개인회원</c:if>
							<c:if test="${sLevel==3}">기업회원</c:if>
						</h4>
					</td>
					<td>
						<h4>가입일</h4> 
					</td>
					<td>
					 	<h4>${fn:substring(vo.startDate,0,11)}</h4>	
					</td>
				</tr>
				<tr>
					<td class="pl-2 pb-5"><h4>이름</h4></td>
					<td class="pb-5"><h4>${vo.name}</h4></td>
					<td class="pl-2 pb-5"><h4>현재 포인트</h4></td>
					<td class="pb-5"><h4><fmt:formatNumber pattern="#,##0" value="${vo.point}"/></h4></td>
				</tr>
			</table>
			<table  class="table border text-center table-borderless shadow form-group bg-white" onclick="location.href='memberOrderList';" >
				<tr>
					<td colspan="4">
						<h2 class="text-left pl-5">최근 결제내역</h2>
					</td>
				</tr>
				<c:if test="${empty ordersVos}">
					<tr>
						<td colspan="4">
							<h4 class="m-5">주문내역이 없습니다.</h4>
						</td>
					</tr>
				</c:if>
				<c:forEach var="ordersVo" items="${ordersVos}">
					<tr onclick="locationOrder('${ordersVo.orderIdx}')" >
						<c:if test="${ordersVo.orderIdx!=orderIdx}"><td><b>${ordersVo.orderIdx}</b></td></c:if>
						<c:if test="${ordersVo.orderIdx==orderIdx}"><td ></td></c:if>
						<td ><img style="width:120px" src="${ctp}/data/ckeditor/product/${ordersVo.FSName}"></td>
						<td ><b>${ordersVo.productName}</b><br/>${ordersVo.optionName} X ${ordersVo.optionNum}</td>
						<td><fmt:formatNumber value="${ordersVo.totalPrice}" pattern="#,##0"/>원</td>
						<td >${fn:substring(ordersVo.orderDate,0,19)}
								<c:if test="${ordersVo.orderSw==0}"><div class="badge badge-danger">미결제</div></c:if>
								<c:if test="${ordersVo.orderSw==1}"><div class="badge badge-success">결제완료</div></c:if>
								<c:if test="${ordersVo.orderSw==2}"><div class="badge badge-success">입금확인</div></c:if>
								<c:if test="${ordersVo.orderSw==3}"><div class="badge badge-success">배송준비중</div></c:if>
								<c:if test="${ordersVo.orderSw==4}"><div class="badge badge-success">배송중</div></c:if>
								<c:if test="${ordersVo.orderSw==5}"><div class="badge badge-success">배송완료</div></c:if>
								<c:if test="${ordersVo.orderSw==-1}"><div class="badge badge-danger">환불</div></c:if>
						</td>
					</tr>
					<c:set var="orderIdx" value="${ordersVo.orderIdx}"/>
				</c:forEach>
				<tr ><td colspan="4" class="p-2"></td></tr>
			</table>
			<div  class="p-2 border text-center shadow  bg-white" onclick="location.href='memberSubList';">
				<h2 class="text-left pl-5 p-2">현재 구독 중인 상품</h2>
					<div class="row">
						<c:forEach var="subVo" items="${subVos}">
							<div class="col-md-2">
								<img style="width:120px" src="${ctp}/data/ckeditor/product/${subVo.FSName}">
								<p>${subVo.productName}</p>
							</div>
						</c:forEach>
					</div>
					<c:if test="${empty subVos}"><h4 class="m-5 text-center">현재 구독중인 상품이 없습니다.</h4></c:if>
			</div>
			<p><br/></p>
		</div>
	</div>
</div>
</body>
</html>
