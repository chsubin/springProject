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
		.badge:hover{
		cursor:pointer;
		}
	 </style>
 <script>
 	'use strict';
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<nav class="navbar navbar-expand-sm border shadow-sm" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="#">이벤트 리스트 |</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="adminBoardInput">이벤트 등록</a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<table class="table" style='width:80%;margin:0 auto'>
			<tr class="table-borderless">
				<td colspan="4">
					<h2>EVENT</h2>
				</td>
			</tr>
			<tr class="text-center bg-light">
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
			<c:forEach var="vo" items="${vos}">
				<tr  class="text-center">
					<td>
						${curScrStartNo}
					</td>
					<td>${vo.mid}</td>
					<td>
						<a href="${ctp}/admin/board/boardContent?idx=${vo.idx}"> ${vo.title} <c:if test="${vo.replyCount>0}">[${vo.replyCount}]</c:if></a>
						<c:if test="${vo.hour_diff<1}"><div class="badge badge-danger">N</div></c:if>
					</td>
					<td >
						<c:if test="${vo.hour_diff<12}">${vo.hour_diff}시간 전</c:if>
						<c:if test="${vo.hour_diff>=12&&hour_diff<24}">${fn:substring(vo.WDate,10,19)}</c:if>
						<c:if test="${vo.day_diff>=1}">${fn:substring(vo.WDate,0,10)}</c:if>
					</td>
					<td >
						${vo.views}
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
			</c:forEach>
			<tr class="m-0 p-0"><td colspan="4"></td></tr>
		</table>

		<div class="text-center">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVo.pag > 1}">
		      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
		    </c:if>
		    <c:if test="${pageVo.curBlock > 0}">
		      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
		      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
		    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
		    	</c:if>
		      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
		    </c:if>
		    <c:if test="${pageVo.pag < pageVo.totPage}">
		      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adboard/adminBoardList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
		    </c:if>
		  </ul>
		</div>
		
	</div>
</div>

<p><br/><br/></p>
</body>
</html>