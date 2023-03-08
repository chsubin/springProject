<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>boardList.jsp</title>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid fadein" style="width:80%">
	<div class="border" style="width:100%">
		<table class="table text-center" style='width:80%;margin:0 auto'>
			<tr class="table-borderless text-left">
				<td colspan="4" class="p-3 pt-5">
					<h1 style="font-family:ChosunNm">EVENT</h1>
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
				<tr class="text-center">
					<td>
						${curScrStartNo}
					</td>
					<td>${vo.mid}</td>
					<td>
						<a href="${ctp}/board/boardContent?idx=${vo.idx}"> ${vo.title} <c:if test="${vo.replyCount>0}">[${vo.replyCount}]</c:if></a>
						<c:if test="${vo.hour_diff<24}"><div class="badge badge-danger">N</div></c:if>
					</td>
					<td>
						<c:if test="${vo.hour_diff<12}">${vo.hour_diff}시간 전</c:if>
						<c:if test="${vo.hour_diff>=12&&hour_diff<24}">${fn:substring(vo.WDate,10,19)}</c:if>
						<c:if test="${vo.day_diff>=1}">${fn:substring(vo.WDate,0,10)}</c:if>
					</td>
					<td>
						${vo.views}
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
			</c:forEach>
			<tr class="m-0 p-0"><td colspan="4"></td></tr>
		</table>

		<div class="text-center p-5">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVo.pag > 1}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
	    </c:if>
	    <c:if test="${pageVo.curBlock > 0}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
	      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
	    	</c:if>
	      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
	    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
	    </c:if>
	    <c:if test="${pageVo.pag < pageVo.totPage}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
	    </c:if>
	  </ul>
  	</div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
