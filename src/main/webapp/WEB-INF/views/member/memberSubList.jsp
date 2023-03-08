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
		function locationOrder(orderIdx){
			location.href="${ctp}/member/ordersResult?orderIdx="+orderIdx;
		}
	
	</script>
</head>
<body>
<div class="container-fluid " style="width:80%;" >
	<div class="row bg-light" >
		<div class="col-md-4 border shadow bg-white" style="height:100vh"  >
			<jsp:include page="memberMenu.jsp"/>
		</div>
		<div class="col-md-8 fadein"  style="height:100vh;overflow:auto">
			<h4 class="m-5"><b>나의 구독상품</b></h4>
			<c:if test="${empty ordersVos}">
				<h4 class="m-5">구독하신 상품이 없습니다.</h4>
			</c:if>
			<c:if test="${!empty ordersVos}">
				<table class="table table-hover table-bordered bg-white">
					<tr class="text-center border bg-dark text-white">
						<th>주문번호</th>
						<th colspan="2">상품</th>
						<th colspan="2">결제</th>
					</tr>
					<c:forEach var="ordersVo" items="${ordersVos}">
						<tr>
							<c:if test="${ordersVo.orderIdx!=orderIdx}"><td class="border-top"><b>${ordersVo.orderIdx}</b></td></c:if>
							<c:if test="${ordersVo.orderIdx==orderIdx}"><td class="table-borderless"></td></c:if>
							<td class="border-top"><img style="width:120px" src="${ctp}/data/ckeditor/product/${ordersVo.FSName}"></td>
							<td class="border-top"><b>${ordersVo.productName}</b><br/>${ordersVo.optionName} /${ordersVo.optionNum}/${ordersVo.optionDetail}</td>
							<td class="border-top"><fmt:formatNumber value="${ordersVo.totalPrice}" pattern="#,##0"/>원</td>
							<td class="border-top">${ordersVo.orderDate}
								<c:if test="${ordersVo.orderSw==0}"><div class="badge badge-danger">미결제</div></c:if>
								<c:if test="${ordersVo.orderSw==1}"><div class="badge badge-success">결제완료</div></c:if><br/><br/>
								<div class="btn btn-outline-success" onclick="locationOrder('${ordersVo.orderIdx}')">결제정보 보기</div>
								<div class="btn btn-outline-info" onclick="location.href='${ctp}/subscribe/subscribeList?oIdx=${ordersVo.idx}';">구독 상세정보</div>
							</td>
						</tr>
						<c:set var="orderIdx" value="${ordersVo.orderIdx}"/>
					</c:forEach>
				</table>
			</c:if>
			
<!-- 페이징처리  -->			
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberOrderList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
		</div>
	</div>
</div>
</body>
</html>
