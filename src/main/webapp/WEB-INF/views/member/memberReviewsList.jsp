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
		.cli{
			cursor:pointer;
		}
		.imgHover:hover {
		  transform: scale( 4.00 );
		  transition: all 0.7s linear;
		}
		.imgHover {
		width:50px;
		}
	</style>
	<script>
		function locationOrder(orderIdx){
			location.href="${ctp}/member/ordersResult?orderIdx="+orderIdx;
		}
	
	</script>
</head>
<body>
<div class="container-fluid " style="width:80%;" >
	<div class="row bg-light" >
		<div class="col-md-4 border shadow bg-white" style="height:100vh"  >
			<jsp:include page="memberMenu.jsp"/>
		</div>
		<div class="col-md-8 fadein"  style="height:100vh;overflow:auto">
			<h4 class="m-5"><b>내가 작성한 리뷰</b></h4>
			<c:if test="${empty reviewsVos}">
				<h4 class="m-5">리뷰 내역이 없습니다.</h4>
			</c:if>
			<c:if test="${!empty reviewsVos}">
				<table class="table table-hover table-bordered bg-white text-center">
					<tr class="text-center border bg-dark text-white">
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
					<c:forEach var="vo" items="${reviewsVos}">
						<tr>
							<td>
								${curScrStartNo}
							</td>
							<td>${vo.mid}</td>
							<td>
								<a href="${ctp}/reviews/reviewsContent?idx=${vo.idx}"> ${vo.title} <c:if test="${vo.replyCount>0}">[${vo.replyCount}]</c:if></a>
								<c:if test="${vo.day_diff<1}"><div class="badge badge-danger">N</div>
								</c:if>
								<c:if test="${vo.FSName!=''}"> <br/><br/>
									<c:forEach var="fSName" items="${fn:split(vo.FSName,'/')}">
										<img class="imgHover" src="${ctp}/data/ckeditor/adboard/${fSName}">
									</c:forEach>
								</c:if>
							</td>
							<td>
								<c:if test="${vo.hour_diff<12}">${vo.hour_diff}시간 전</c:if>
								<c:if test="${vo.hour_diff>=12&&vo.day_diff<1}">${fn:substring(vo.WDate,10,19)}</c:if>
								<c:if test="${vo.day_diff>=1}">${fn:substring(vo.WDate,0,10)}</c:if>
							</td>
							<td>
								${vo.views}
							</td>
						</tr>
						<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
					</c:forEach>
				</table>
				<div style="height:50px"></div>
			</c:if>
			
<!-- 페이징처리  -->			
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberReviewsList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
		</div>
	</div>
</div>
</body>
</html>
