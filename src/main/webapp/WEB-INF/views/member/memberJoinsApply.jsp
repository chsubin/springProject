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
		<div class="col-md-8 fadein p-5"  style="height:100vh;overflow:auto">
		<c:set var="cnt" value="9" />
			<div class="row">
				<c:if test="${empty vos}"><h4 class="text-center">신청서가 없습니다.</h4></c:if>
				<c:forEach var="vo" items="${vos}">
					<div class="col-md-4">
						<table class="table bg-white table-borderless shadow mb-5" style="border:1px solid #ccc">
							<tr class="table table-borderless"><td colspan="2" class="text-center'"><h5><b>기업제휴 상담신청서</b>
								<c:if test="${vo.joinSw==1}"> <div class="badge badge-success">제휴기업</div></c:if>
								<c:if test="${vo.joinSw==-2}"> <div class="badge badge-warning">제휴종료</div></c:if>
								<c:if test="${vo.joinSw==-1}"> <div class="badge badge-danger">상담종료</div></c:if>
							 </h5>
							</td>
							</tr>
							<tr  class="table table-borderless">
								<td  class="p-3">${vo.name}</td>
							</tr>
							<tr>
								<td class="p-3">${vo.comname}</td>
							</tr>
							<tr>
								<td  class="p-3">${vo.tel}</td>
							</tr>
							<tr>
								<td  class="p-3">${vo.email}</td>
							</tr>
							<tr  class="table">
								<td class="p-3">${vo.part}</td>
							</tr>
							<tr>
								<td class="p-3 border">(상담 신청) ${vo.content}</td>
							</tr>
						<c:if test="${vo.joinSw==-1}">
							<tr>
								<td class="p-3 border">(상담 종료)</td>
							</tr>
						</c:if>
						<c:if test="${vo.joinSw==1||vo.joinSw==-2}">
							<tr>
								<td class="p-3 border">(상담 종료) 제휴기업으로 등록 </td>
							</tr>
						</c:if>
						</table>
					</div>
				</c:forEach>
			</div>

	
			<!-- 블록 페이지 시작 -->
			<div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVo.pag > 1}">
			      <li class="page-item"><a class="page-link text-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=1&joinSw=${joinSw}">첫페이지</a></li>
			    </c:if>
			    <c:if test="${pageVo.curBlock > 0}">
			      <li class="page-item"><a class="page-link text-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&joinSw=${joinSw}">이전블록</a></li>
			    </c:if>
			    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
			      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
			    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=${i}&joinSw=${joinSw}">${i}</a></li>
			    	</c:if>
			      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
			    		<li class="page-item"><a class="page-link text-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=${i}&joinSw=${joinSw}">${i}</a></li>
			    	</c:if>
			    </c:forEach>
			    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
			      <li class="page-item"><a class="page-link text-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&joinSw=${joinSw}">다음블록</a></li>
			    </c:if>
			    <c:if test="${pageVo.pag < pageVo.totPage}">
			      <li class="page-item"><a class="page-link text-secondary" href="memberJoinsApply?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&joinSw=${joinSw}">마지막페이지</a></li>
			    </c:if>
			  </ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>
