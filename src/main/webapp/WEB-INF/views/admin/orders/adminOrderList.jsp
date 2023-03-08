<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>adminInputProduct.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
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
		.cli {
			cursor:pointer;
		}
		
	 </style>
 <script>
 	'use strict';
 	function fSearch(){
 		let startDate= myform.startDate.value;
 		let lastDate= myform.lastDate.value;
 		let orderSw = myform.orderSw.value;
 		let part = myform.part.value;
 		let search = myform.search.value;
 		
 		location.href="${ctp}/admin/orders/adminOrderList?startDate="+startDate+"&lastDate="+lastDate+"&orderSw="+orderSw+"&part="+part+"&search="+search;
 		
 	}
 	function selectAll(){
 		$(".chk").prop("checked",true);
 	}
 	function selectReverse(){
	 		if($(".chk").prop("checked")){
	 			$(".chk").prop("checked",false);
	 		}
	 		else{
	 			$(".chk").prop("checked",true);
	 		}
 	}
 	
 	function selectUpdate(){
 		let ans= confirm("선택하신 항목의 상태를 변경하시겠습니까?");
 		if(!ans) return false;
 		let chks ="";
 		let sw=myform.osw.value;
 		for(let i=0;i<myform.chk.length;i++){
 			if(myform.chk[i].checked){
 				chks+= myform.chk[i].value+"/";
 			}
 		}
 		if(chks==""){chks = myform.chk.value+"/";}
 		if(chks=="") {alert("변경하실 항목을 선택해주세요.");return;}
 		$.ajax({
 			type: "post",
 			data: {idxs:chks,orderSw:sw},
 			url: "${ctp}/admin/orders/adminOrderSwUpdate",
 			success:function(){location.reload();},
 			error:function(){}
 		});
 	}
	
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>단품상품 주문 관리</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid p-3">
	
	<div class="container-fluid p-1 mb-3 border shadow-sm" style="background-color:#fff">
		<table class="table table-borderless">
			<tr>
				<th><h4><b>주문 상세 검색</b></h4></th>
				<td>주문일 : <input type="date" name="startDate" value="${startDate}"> - <input type="date"  name="lastDate"  value="${lastDate}"> </td>
				<td>  주문상태 
					<select name="orderSw">
						<option value="99" ${orderSw==99 ? 'selected' : ''}>주문상태 전체</option>
						<option value="-1" ${orderSw==-1 ? 'selected' : ''}>환불</option>
						<option value="0" ${orderSw==0 ? 'selected' : ''}>결제실패</option>
						<option value="1" ${orderSw==1 ? 'selected' : ''}>결제완료</option>
						<option value="2" ${orderSw==2 ? 'selected' : ''}>입금확인</option>
						<option value="3" ${orderSw==3 ? 'selected' : ''}>배송중</option>
						<option value="4" ${orderSw==4 ? 'selected' : ''}>배송요청</option>
						<option value="5" ${orderSw==5 ? 'selected' : ''}>배송완료</option>
					</select>
				</td>
				<td>
					<select name="part">
						<option value="" >검색카테고리</option>
						<option value="orderIdx" ${part=='orderIdx' ? 'selected' : ''}>주문번호</option>
						<option value="mid" ${part=='mid' ? 'selected' : ''}>주문자</option>
						<option value="productName" ${part=='productName' ? 'selected' : ''}>상품이름</option>
					</select>
					<input type="text" name="search" value="${search}">
				</td>
				<td><input type="button" class="btn btn-success" value="검색" onclick="fSearch()"/></td>
			</tr>
		</table>
	</div>
<div class="container-fluid p-5  border shadow-sm" style="background-color:#fff">
		<c:if test="${empty ordersVos}">
			<h4 class="m-5">주문내역이 없습니다.</h4>
		</c:if>
		<c:if test="${!empty ordersVos}">
			<table class="table table-hover table-bordered bg-white">
				<tr class="table table-borderless">
					<td colspan="4" class="text-left">
						<div class="btn btn-light border" onclick="selectAll();">전체선택</div>
						<div class="btn btn-light border" onclick="selectReverse();">선택반전</div>
					</td>
					<td colspan="4" class="text-right">
						<select name="osw" style="height:30px">
							<option value="1" >1:결제완료</option>
							<option value="2" >2:입금확인</option>
							<option value="3" >3:배송준비중</option>
							<option value="4" >4:배송중</option>
							<option value="5" >5:배송완료</option>
						</select>
						<div class="btn btn-outline-dark" onclick="selectUpdate()">상태변경</div>
					</td>
				</tr>
				<tr class="text-center border bg-dark text-white">
					<th>선택</th>
					<th>주문</th>
					<th colspan="2">상품</th>
					<th>옵션선택</th>
					<th>수량(개)</th>
					<th>금액</th>
					<td>상태</td>
				</tr>
				<c:forEach var="ordersVo" items="${ordersVos}">
					<tr class="text-center" >
						<td class="border-top">
							<input type="checkbox"  class="chk" name="chk"  value="${ordersVo.idx}"/>
						</td>
						<td class="border-top cli" onclick="location.href='${ctp}/admin/orders/adminOrdersContent?orderIdx=${ordersVo.orderIdx}';">
							<b>${ordersVo.orderIdx}</b><br/>
							${ordersVo.orderDate}<br/><br/>
							주문자 : ${ordersVo.mid}
						</td>
						<td class="border-top"><img style="width:50px;height:50px" src="${ctp}/data/ckeditor/product/${ordersVo.FSName}"></td>
						<td class="border-top">${ordersVo.productName}</td>
						<td class="border-top">${ordersVo.optionName}</td>
						<td class="border-top"><fmt:formatNumber value="${ordersVo.optionNum}" pattern="#,##0"/></td>
						<td class="border-top"><fmt:formatNumber value="${ordersVo.totalPrice}" pattern="#,##0"/>원</td>
						<td>
							<c:if test="${ordersVo.orderSw==-1}"><div class="badge badge-danger">환불</div></c:if>
							<c:if test="${ordersVo.orderSw==0}"><div class="badge badge-danger">결제실패</div></c:if>
							<c:if test="${ordersVo.orderSw==1}"><font color="red">1:결제완료</font></c:if>
							<c:if test="${ordersVo.orderSw==2}"><font color="red">2:입금확인</font></c:if>
							<c:if test="${ordersVo.orderSw==3}"><font color="red">3:배송준비중</font></c:if>
							<c:if test="${ordersVo.orderSw==4}"><font color="red">4:배송중</font></c:if>
							<c:if test="${ordersVo.orderSw==5}"><font color="blue">5:배송완료</font></c:if><br/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
<!-- 블록 페이지 시작 -->
		<div class="text-center">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVo.pag > 1}"> 
		      <li class="page-item"><a class="page-link text-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=1&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">첫페이지</a></li>
		    </c:if>
		    <c:if test="${pageVo.curBlock > 0}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">이전블록</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
		      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
		    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">${i}</a></li>
		    	</c:if>
		      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		    		<li class="page-item"><a class="page-link text-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">${i}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">다음블록</a></li>
		    </c:if>
		    <c:if test="${pageVo.pag < pageVo.totPage}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminOrderList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&startDate=${startDate}&lastDate=${lastDate}&orderSw=${orderSw}&part=${part}&search=${search}">마지막페이지</a></li>
		    </c:if>
		  </ul>
		</div>
	</div>
</div>
</form>
<p><br/><br/></p>
</body>
</html>