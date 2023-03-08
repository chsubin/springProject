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
		
		.btnNone {
			color:darkblue;
			border:1px solid gray;
		}
		.btnActive {
			background-color:darkblue;
			color:white;
		}
		.btnNone:hover {
			background-color:darkblue;
			color:white;
		}
		.productname {
		  font-family:'Noto Sans KR', sans-serif;
  		font-weight:300;
  		font-size:1.2em;
		}
	.fadein {
	  animation: fadein 1.5s;
	}
	@keyframes fadein {
	    from {
	        opacity: 0;
	    }
	    to {
	        opacity: 1;
	    }
	}
	@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
		
	</style>
	<script>
		'use strict';
		
		function fSearch(){
			let part = $("#part").val()
			let search = $("#search").val()
			
			location.href="reviewsList?part="+part+"&search="+search;
		}
		function fCheck(){
			let delItems="";
			let ans = confirm("선택하신 항목을 취소하시겠습니까?");
			if(!ans) return false;
			for(let i=0;i<myform.chk.length;i++){
				if(myform.chk[i].checked){
					delItems+=myform.chk[i].value+"/";
				}
			}
			if(delItems.trim()==""){alert("항목을 선택해주세요.");return;}
			
			$.ajax({
				type:"post",
				url:"${ctp}/refund/refundCancle",
				data:{delItems:delItems},
				success:function(){alert("환불 완료");location.reload();},
				error:function(){alert("실패~");}
			});
		}
		
	
	</script>
</head>
<body>
<form name="myform">
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
	<div class="container-fluid fadein" style="width:70%">
		<table class="table" style="margin:0 auto;width:90%">
			<tr class="table-borderless">
				<td colspan="2" class="pb-5 pt-5" >
					<h1 style="font-family:'ChosunNm'">REFUNDS</h1>
				</td>
			</tr>
		</table>
		<p><br/></p>
			<table class="text-center m-3 table" style="width:100%">
				<tr class="table-borderless text-left">
					<td colspan="6">
						<input type="button" class="btn btn-outline border" value="환불취소" onclick="fCheck()"/>
					</td>
				</tr>
				<tr class="bg-light">
					<th></th>
					<th>주문정보</th>
					<th colspan="2">상품정보</th>
					<th colspan="2">환불정보</th>
				</tr>
				<c:if test="${empty vos}">
					<tr>
						<td colspan="6">
							<h3 class="m-5">환불 정보가 없습니다.</h3>
						</td>
					</tr>
				</c:if>
			 	<c:forEach var="vo" items="${vos}">
			 		<tr>
			 			<td>
		 					<input type="checkbox" ${vo.refundSw==1?'':'disabled'} id="chk${vo.idx}" name="chk" value="${vo.idx}" class="chk"/>
			 			</td>
			 			<td>
				 			<label for="chk${vo.idx}">
				 				${vo.orderIdx}<br/>
				 				${fn:substring(vo.ODate,0,19)}
				 			</label>
			 			</td>
			 			<td colspan="2">
			 				<table class="table table-borderless">
								<c:forEach var="idx" items="${fn:split(vo.OIdxs,',')}">
			 						<c:forEach var="ovo" items="${oVos}">
			 							<c:if test="${ovo.idx==idx}">
						 					<tr>
						 						<td width="10%">
							 					 <img style="width:50px"  src="${ctp}/data/ckeditor/product/${ovo.FSName}">
							 					</td>
							 					<td class="text-left">
									 				${ovo.productName}
									 				<br/>${ovo.optionName}
							 					</td>
							 					<td width="20%">
							 						<fmt:formatNumber pattern="#,##0" value="${ovo.totalPrice}"/>원
							 					</td>
							 				</tr>
						 				</c:if>
					 				</c:forEach>
				 				</c:forEach>
			 				</table>
			 			</td>
			 			<td>
			 				<table class="table table-bordered">
			 					<tr>
			 						<td>쿠폰 사용 금액</td>
			 						<td>-<fmt:formatNumber pattern="#,##0" value="${vo.couponUse}"/>원</td>
			 					</tr>
			 					<tr>
			 						<td>사용포인트</td>
			 						<td>-<fmt:formatNumber pattern="#,##0" value="${vo.plusPoint}"/>원</td>
			 					</tr>
			 					<tr>
			 						<td>배송비 차감</td>
			 						<td>-<fmt:formatNumber pattern="#,##0" value="${vo.deliveryPrice}"/>원</td>
			 					</tr>
			 					<tr>
			 						<th>총 환불 금액</th>
			 						<th>
			 							<fmt:formatNumber pattern="#,##0" value="${vo.totalRefund}"/>원
										<c:if test="${vo.refundSw==0}"><br/><br/><div class="badge badge-danger">환불 취소</div></c:if>
										<c:if test="${vo.refundSw==1}"><br/><br/><div class="badge badge-warning">환불 신청</div></c:if>
										<c:if test="${vo.refundSw==2}"><br/><br/><div class="badge badge-primary">환불 승인</div></c:if>
			 							<c:if test="${vo.refundSw==3}"><div class="badge badge-success">환불 완료</div></c:if>
			 						</th>
			 					</tr>
			 				</table>
			 			</td>
			 		</tr>
			 	</c:forEach>
			 	<tr>
			 		<td colspan="6" class="m-0 p-0"></td>
			 	</tr>
			</table>
		
		<p><br/><br/></p>
		</div>
	<!-- 블록 페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVo.pag > 1}">
	      <li class="page-item"><a class="page-link text-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=1&part=${part}&search=${search}">첫페이지</a></li>
	    </c:if>
	    <c:if test="${pageVo.curBlock > 0}">
	      <li class="page-item"><a class="page-link text-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&part=${part}&search=${search}">이전블록</a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
	      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=${i}&part=${part}&search=${search}">${i}</a></li>
	    	</c:if>
	      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
	    		<li class="page-item"><a class="page-link text-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=${i}&part=${part}&search=${search}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
	      <li class="page-item"><a class="page-link text-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&part=${part}&search=${search}">다음블록</a></li>
	    </c:if>
	    <c:if test="${pageVo.pag < pageVo.totPage}">
	      <li class="page-item"><a class="page-link text-secondary" href="refundList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&part=${part}&search=${search}">마지막페이지</a></li>
	    </c:if>
	  </ul>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</form>
</body>
</html>
