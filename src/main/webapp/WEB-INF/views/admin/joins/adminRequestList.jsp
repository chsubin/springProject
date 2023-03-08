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
 		let part = myform.part.value;
 		let search = myform.search.value;
 		
 		location.href="${ctp}/admin/joins/adminRequestList?startDate="+startDate+"&lastDate="+lastDate+"&part="+part+"&search="+search;
 		
 	}
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>배송 요청 내역</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid p-3">
	
	<div class="container-fluid p-1 mb-3 border shadow-sm" style="background-color:#fff">
		<table class="table table-borderless">
			<tr>
				<th><h4><b>상세검색</b></h4></th>
				<td>요청일자 <input type="date" name="startDate" value="${startDate}"> - <input type="date"  name="lastDate"  value="${lastDate}"> </td>
				<td>
					<select name="part">
						<option value="" >검색카테고리</option>
						<option value="j.comname" ${part=='j.comname' ? 'selected' : ''}>법인명</option>
						<option value="p.productName" ${part=='p.productName' ? 'selected' : ''}>상품</option>
						<option value="r.content" ${part=='r.content' ? 'selected' : ''}>요청사항</option>
					</select>
					<input type="text" name="search" value="${search}">
				</td>
				<td><input type="button" class="btn btn-success form-control" value="검색" onclick="fSearch()"/></td>
			</tr>
		</table>
	</div>
<div class="container-fluid p-5  border shadow-sm" style="background-color:#fff">
		<c:if test="${empty vos}">
			<h4 class="m-5">주문내역이 없습니다.</h4>
		</c:if>
		<c:if test="${!empty vos}">
			<table class="table table-hover table-bordered bg-white text-center">
				<tr>
					<th>법인명</th>
					<th>상품</th>
					<th>주문량</th>
					<th>요청사항</th>
					<th>요청일자</th>
				</tr>
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${vo.comname}</td>
						<td>${vo.productName}</td>
						<td>${vo.productNum}(${vo.productUnit})</td>
						<td>${vo.content}</td>
						<td>${vo.RDate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
<!-- 블록 페이지 시작 -->
		<div class="text-center">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVo.pag > 1}"> 
		      <li class="page-item"><a class="page-link text-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=1&startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">첫페이지</a></li>
		    </c:if>
		    <c:if test="${pageVo.curBlock > 0}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">이전블록</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
		      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
		    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">${i}</a></li>
		    	</c:if>
		      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		    		<li class="page-item"><a class="page-link text-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">${i}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">다음블록</a></li>
		    </c:if>
		    <c:if test="${pageVo.pag < pageVo.totPage}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminRequestList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&startDate=${startDate}&lastDate=${lastDate}&part=${part}&search=${search}">마지막페이지</a></li>
		    </c:if>
		  </ul>
		</div>
	</div>
</div>
</form>
<p><br/><br/></p>
</body>
</html>