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
	 </style>
 <script>
 	'use strict';
 	
 	function fRequest(){
 		let requestNum ="";
 		let requestDetail ="";
 		let requestIdx ="";
 		
 		for(let i=0;i<myform.requestBox.length;i++){
 			if(myform.requestBox[i].checked){
 				if(myform.requestDetail[i].value==""||myform.requestNum[i].value==""){alert("빈칸을 채워주세요.");return;}
 				requestIdx += myform.requestBox[i].value+"/";
 				requestDetail += myform.requestDetail[i].value+"/";
 				requestNum += myform.requestNum[i].value+"/";
 			}
 		}
 		
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/joins/requestJoin",
 			data : {requestIdx:requestIdx,requestNum:requestNum,requestDetail:requestDetail},
 			success : function(){alert("상품 주문이 완료되었습니다.");location.reload();},
 			error : function(){alert("주문 실패")},
 		});
 	}
 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>배송 요청</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid  p-3">
		<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
				<table class="table">
					<tr class="text-center">
						<th colspan="3">제휴농가</th>
						<th colspan="2">상품</th>
					</tr>
					<c:forEach var="vo" items="${vos}">
						<tr  class="text-center">
							<td class="text-left"><img style="width:100px;height:100px" src="${ctp}/data/ckeditor/adjoins/${vo.FSName}"></td>
							<td>${vo.comname}</td>
							<td>${vo.compart}</td>
							<td>
								<table class="table">
								<c:forEach var="productVo" items="${productVos}">
									<c:if test="${productVo.joinsIdx==vo.idx}">
										<tr>
											<td>
											<input type="checkBox" name="requestBox" id="requestBox${productVo.idx}" value="${productVo.idx}"/><label for="requestBox${productVo.idx}">&nbsp;&nbsp;${productVo.productName}</label>							
											</td>
											<td>
											 <input type="number" class="form-control" name="requestNum" id="requestNum${productVo.idx}"/>							
											</td>
											<td class="text-left">
											  ${productVo.productUnit}							
											</td>
											<td class="text-right">
											  요청사항						
											</td>
											<td>
											 <input type="text" id="requestDetail${productVo.idx}" name="requestDetail" class="form-control"/>							
											</td>
										</tr>
									</c:if>
								</c:forEach>
								</table>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" class="text-center"><input type="button" class="btn btn-success" onclick="fRequest()" value="주문하기"/></td>
					</tr>
				</table>
			<p><br/></p>
				<!-- 블록 페이지 시작 -->
			<div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVo.pag > 1}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsRequest?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
			    </c:if>
			    <c:if test="${pageVo.curBlock > 0}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsRequestpageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
			    </c:if>
			    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
			      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
			    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminJoinsRequest?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
			    	</c:if>
			      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
			    		<li class="page-item"><a class="page-link text-secondary" href="adminJoinsRequest?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
			    	</c:if>
			    </c:forEach>
			    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsRequest?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
			    </c:if>
			    <c:if test="${pageVo.pag < pageVo.totPage}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsRequest?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
			    </c:if>
			  </ul>
			</div>
		</div>
	</div>
</form>
<p><br/><br/></p>
</body>
</html>