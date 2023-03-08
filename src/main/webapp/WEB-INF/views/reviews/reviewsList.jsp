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
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid fadein" style="width:70%">
	<table class="table" style="margin:0 auto;width:90%">
		<tr class="table-borderless">
			<td colspan="2" class="pb-5 pt-5" >
				<h1 style="font-family:'ChosunNm'">REVIEWS</h1>
			</td>
		</tr>
	</table>
	<p><br/></p>
 	<c:set var="i" value="0"/>
 	<div class="row">
	 	<c:forEach var="vo" items="${vos}">
		 		<div class="col-md-3 fadein">
		 			<a href="${ctp}/reviews/reviewsContent?idx=${vo.idx}">
		 				<c:if test="${!empty vo.FSName}"><img style="width:100%;height:400px" src="${ctp}/data/ckeditor/adboard/${fn:split(vo.FSName,'/')[0]}"></c:if>
		 				<c:if test="${empty vo.FSName}"><img style="width:100%;height:400px" src="${ctp}/data/ckeditor/product/${vo.productfSName}"></c:if>
		 			</a>
		 			<p class="productname pt-2">${vo.title}<br/>작성자:${vo.mid}</p>
		 			<p class="productname mb-5">상품 - ${vo.productName}</p>
		 		</div>
	 		<c:set var="i" value="${i+1}"/>
	 	</c:forEach>
	</div>
	
	
	<table class="text-center m-3" style="width:100%">
		<tr>
			<td></td>
			<td width="10%">
				<select class="form-control" id="part">
					<option value="" ${part==''?'selected':''}>구분</option>
					<option value="b.mid" ${part=='b.mid'?'selected':''}>작성자</option>
					<option value="p.name" ${part=='p.name'?'selected':''}>상품</option>
					<option value="b.title" ${part=='b.title'?'selected':''}>제목</option>
				</select>
			</td>
			<td width="20%" >
				<input type="text" class="form-control" id="search" value="${search}"/>
			</td>
			<td width="10%">
				<input type="button" class="btn btn-success form-control" value="검색" onclick="fSearch()"/>
			</td>
			<td></td>
		</tr>
	</table>
	</div>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=1&part=${part}&search=${search}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&part=${part}&search=${search}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=${i}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=${i}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&part=${part}&search=${search}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="reviewsList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&part=${part}&search=${search}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
