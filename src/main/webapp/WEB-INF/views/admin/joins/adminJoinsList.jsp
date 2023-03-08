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
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>제휴농가 목록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<div class="row">
			<c:forEach var="vo" items="${vos}">
				<div class="col-md-3 p-5">
					<div class="border p-3 shadow" style="background-color:Linen">
						<img style="width:100%" src="${ctp}/data/ckeditor/adjoins/${vo.FSName}" onclick="location.href='${ctp}/admin/joins/adminJoinsContent?idx=${vo.idx}';">
						<h4><b>${vo.comname}</b></h4>
						<p><b>${vo.compart}</b></p>
						<p>${fn:substring(vo.startDate,0,11)}</p>
					</div>
				</div>
			</c:forEach>
		</div>
			<!-- 블록 페이지 시작 -->
		<div class="text-center">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVo.pag > 1}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
		    </c:if>
		    <c:if test="${pageVo.curBlock > 0}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
		      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
		    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
		    	</c:if>
		      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		    		<li class="page-item"><a class="page-link text-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
		    </c:if>
		    <c:if test="${pageVo.pag < pageVo.totPage}">
		      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
		    </c:if>
		  </ul>
		</div>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>