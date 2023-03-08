<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	</style>
	<script>
		function locationOrder(orderIdx){
			location.href="${ctp}/member/ordersResult?orderIdx="+orderIdx;
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid text-center fadein" style="width:80%" >
	<div style="width:100%">
		<table class="table text-center" style='width:100%;margin:0 auto'>
			<tr class="table-borderless text-left">
				<td colspan="4" class="p-3 pt-5 table-borderless">
					<h2 style="font-family:ChosunNm" class="pl-5">My Page</h2>
				</td>
			</tr>
			<tr class="table-borderless"><td>
				<div class="row">
					<div class="col-md-9">
						<div class="border p-5 shadow-sm">
							<h4><b>나의 주문내역</b></h4>
							<c:if test="${empty ordersVos}">
								<h4 class="m-5">주문내역이 없습니다.</h4>
							</c:if>
							<c:if test="${!empty ordersVos}">
								<table class="table table-hover table-bordered">
									<tr class="text-center border bg-light">
										<th>주문번호</th>
										<th colspan="2">상품</th>
										<th>결제금액</th>
										<th>결제</th>
									</tr>
									<c:forEach var="ordersVo" items="${ordersVos}">
										<tr onclick="locationOrder('${ordersVo.orderIdx}')" >
											<c:if test="${ordersVo.orderIdx!=orderIdx}"><td class="border-top"><b>${ordersVo.orderIdx}</b></td></c:if>
											<c:if test="${ordersVo.orderIdx==orderIdx}"><td></td></c:if>
											<td class="border-top"><img style="width:120px" src="${ctp}/data/ckeditor/product/${ordersVo.FSName}"></td>
											<td class="border-top"><b>${ordersVo.productName}</b><br/>${ordersVo.optionName} /${ordersVo.optionNum}/${ordersVo.optionDetail}</td>
											<td class="border-top">${ordersVo.totalPrice}</td>
											<td class="border-top">${ordersVo.orderDate}
												<c:if test="${ordersVo.orderSw==0}"><div class="badge badge-danger">미결제</div></c:if>
												<c:if test="${ordersVo.orderSw==1}"><div class="badge badge-success">결제완료</div></c:if>
											</td>
										</tr>
										<c:set var="orderIdx" value="${ordersVo.orderIdx}"/>
									</c:forEach>
								</table>
							</c:if>
						</div>
					</div>
					<div class="col-md-3 pt-0">
							<table class="table table-borderless border mt-0 shadow bg-light">
								<tr>
									<td colspan="3">
										<h1 style="display:inline"><font color="GoldenRod"><i class='bx bx-user-pin' ></i></font></h1><h5 class="m-0 p-0" style="display:inline">${vo.name}님</h5>  
									</td>
								</tr>
								<tr>
									<td colspan="3">
									 ${vo.email}
									</td>
								</tr>
								<tr>
									<td colspan="3">
										포인트 ${vo.point}
									</td>
								</tr>
								<tr>
									<td colspan="3">
										가입날짜 ${vo.startDate}
									</td>
								</tr>
								<tr class="table">
									<td class=" table-bordered border">
										정보수정
									</td>
									<td class=" table-bordered border">
										<a href="${ctp}/member/memberPwdUpdate">비밀번호 변경</a>
									</td>
									<td class=" table-bordered border">
										회원 탈퇴
									</td>
								</tr>
							</table>
							<table class="table table-borderless border shadow bg-light">
								<tr>
									<td colspan="3">
										내쿠폰  
									</td>
								</tr>
							</table>
					</div>
				</div>
		</td></tr>
	</table>
		
		

</div>
</div>
<div style="height:50px;"></div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
