<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
 		let refundSw = myform.refundSw2.value;
 		let part = myform.part.value;
 		let search = myform.search.value;
 		
 		location.href="${ctp}/admin/refund/adminRefundList?startDate="+startDate+"&lastDate="+lastDate+"&refundSw="+refundSw+"&part="+part+"&search="+search;
 		
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
 	
 	$(function(){
 		$("#refundSw").change(function(){
 			let ans= confirm("선택하신 항목의 상태를 변경하시겠습니까?");
 	 		let chks ="";
 	 		let sw = $("#refundSw").val();
 	 		for(let i=0;i<myform.chk.length;i++){
 	 			if(myform.chk[i].checked){
 					chks+= myform.chk[i].value+"/";
 	 			}
 	 		}
 	 		if(chks==""){myform.chk[i].value+"/";}
 	 		if(chks=="") {alert("변경하실 항목을 선택해주세요.");return;}
 	 		$.ajax({
 	 			type: "post",
 	 			data: {idxs:chks,refundSw:sw},
 	 			url: "${ctp}/admin/refund/adminRefundSwUpdate",
 	 			success:function(){location.reload();},
 	 			error:function(){}
 	 		});
 		});
 	});
 	
 	
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
 		if(chks=="") {alert("변경하실 항목을 선택해주세요.");return;}
 		$.ajax({
 			type: "post",
 			data: {idxs:chks,orderSw:sw},
 			url: "${ctp}/admin/orders/adminOrderSwUpdate",
 			success:function(){location.reload();},
 			error:function(){}
 		});
 	}
	
	function fUpdate(idx){
		let url="${ctp}/admin/refund/adminRefundUpdate?idx="+idx;
		window.open(url,"nWin","width=500px,height=800px");
		
		}
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>환불/결제취소</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid p-3">
	
	<div class="container-fluid p-1 mb-3 border shadow-sm" style="background-color:#fff">
		<table class="table table-borderless">
			<tr>
				<th><h4><b>상세검색</b></h4></th>
				<td>환불요청일 : <input type="date" name="startDate" value="${startDate}"> - <input type="date"  name="lastDate"  value="${lastDate}"> </td>
				<td>상태 
					<select name="refundSw2">
						<option value="0" ${refundSw==0 ? 'selected' : ''}>환불취소</option>
						<option value="1" ${refundSw==1 ? 'selected' : ''}>환불신청</option>
						<option value="2" ${refundSw==2 ? 'selected' : ''}>환불승인</option>
						<option value="3" ${refundSw==3 ? 'selected' : ''}>환불완료</option>
					</select>
				</td>
				<td>
					<select name="part">
						<option value="" >검색카테고리</option>
						<option value="orderIdx" ${part=='orderIdx' ? 'selected' : ''}>주문번호</option>
						<option value="mid" ${part=='mid' ? 'selected' : ''}>주문자</option>
					</select>
					<input type="text" name="search" value="${search}">
				</td>
				<td><input type="button" class="btn btn-success" value="검색" onclick="fSearch()"/></td>
			</tr>
		</table>
	</div>
	<div class="container-fluid p-5  border shadow-sm" style="background-color:#fff">
		<table class="text-center m-3 table table-hover" style="width:100%">
			<tr class="table table-borderless">
				<td colspan="5" class="text-left">
					<div class="btn btn-light border" onclick="selectAll();">전체선택</div>
					<div class="btn btn-light border" onclick="selectReverse();">선택반전</div>
				</td>
				<td colspan="1" class="text-right">
					<select id="refundSw" class="form-control" style="height:30px">
						<option value="99" >상태</option>
						<option value="0" >환불취소</option>
						<option value="1" >환불신청</option>
						<option value="2" >환불승인</option>
						<option value="3" >환불완료</option>
					</select>
				</td>
			</tr>
			<tr class="bg-light">
				<th></th>
				<th>환불정보</th>
				<th>주문정보</th>
				<th colspan="2">상품정보</th>
				<th colspan="2">금액</th>
			</tr>
		 	<c:set var="su" value="0"  />
		 	<c:forEach var="vo" items="${vos}">
		 		<tr>
		 			<td><input type="checkbox" id="chk${vo.idx}" name="chk" value="${vo.idx}" class="chk"/></td>
		 			<td>
		 				<label for="chk${vo.idx}">
			 				${vo.RDate}<br/><br/>
							<c:if test="${vo.refundSw==0}"><div class="badge badge-danger">환불 취소</div></c:if>
							<c:if test="${vo.refundSw==1}"><div class="badge badge-warning">환불 신청</div></c:if>
							<c:if test="${vo.refundSw==2}"><div class="badge badge-primary">환불 승인</div></c:if>
							<c:if test="${vo.refundSw==3}"><div class="badge badge-success">환불 완료</div></c:if>
						</label>
		 			</td>
		 			<td>
		 				${vo.orderIdx}<br/>
		 				${vo.ODate}<br/>
		 				${vo.mid}<br/>
						<c:if test="${vo.orderSw==1}"><font color="red">1:결제완료</font></c:if>
						<c:if test="${vo.orderSw==2}"><font color="red">2:입금확인</font></c:if>
						<c:if test="${vo.orderSw==3}"><font color="red">3:배송준비중</font></c:if>
						<c:if test="${vo.orderSw==4}"><font color="red">4:배송중</font></c:if>
						<c:if test="${vo.orderSw==5}"><font color="blue">5:배송완료</font></c:if><br/>
		 			</td>
		 			<td colspan="2">
		 				<table class="table table-borderless">
							<c:forEach var="idx" items="${fn:split(vo.OIdxs,',')}">
		 						<c:forEach var="ovo" items="${oVos}">
		 							<c:if test="${ovo.idx==idx}">
					 					<tr onclick="location.href='${ctp}/admin/orders/adminOrdersContent?orderIdx=${ovo.orderIdx}';">
					 						<td>
						 					 	<img style="width:50px"  src="${ctp}/data/ckeditor/product/${ovo.FSName}">
						 					</td>
						 					<td class="text-left">
								 				${ovo.productName}
								 				<br/>${ovo.optionName}
						 					</td>
						 					<td width="15%">
						 						${ovo.totalPrice}
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
		 						<td>-${vo.couponUse}</td>
		 					</tr>
		 					<tr>
		 						<td>사용포인트</td>
		 						<td>-${vo.plusPoint}</td>
		 					</tr>
		 					<tr>
		 						<td>배송비 차감</td>
		 						<td>-${vo.deliveryPrice}</td>
		 					</tr>
		 					<tr>
		 						<th>총 환불 금액</th>
		 						<th>${vo.totalRefund}</th>
		 					</tr>
		 					<tr>
		 					 <td colspan="2" class="m-0 p-0"><input type="button" class="btn btn-outline-warning form-control" value="상세보기" onclick="fUpdate(${vo.idx})"/></td>
		 					</tr>
		 				</table>
		 				
		 			</td>
		 		</tr>
		 	</c:forEach>
		</table>
	
	<p><br/></p>

<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=1&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="adminRefundList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&startDate=${startDate}&lastDate=${lastDate}&refundSw=${refundSw}&part=${part}&search=${search}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
	</div>
	</div>
</form>
<p><br/><br/></p>
</body>
</html>