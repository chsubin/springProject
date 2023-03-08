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
	.opac{
	opacity:40%;
	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid text-center p-0 m-0">
  <div class="text-center">
  	<div class="text-left" style="position:absolute;top:350px;left:500px">
  		<h1 style="font-family:'ChosunNm';">
    		대한민국 1% 명인과일을 <br/><br/>
    		<b>제철마다 <font color="darkblue">정기배송</font>으로</b> 즐기세요<br/><br/><br/>
  		</h1>
 		</div>
  	<img src="${ctp}/images/main/과일구독2.jpg" style="width:100%;"/>
	</div>
</div>
<p><br/></p>
<div class="container-fluid" style="width:80%">
 	<c:set var="i" value="0"/>
 	<c:forEach var="vo" items="${vos}">
 		<c:if test="${i%4==0}"><div class="row p-3"></c:if>
	 		<div class="col-sm-3">
	 			<a href="${ctp}/subscribe/subscribeProduct?idx=${vo.idx}"><img style="width:100%;" ${vo.sellSw=='NO'?'class=opac':''} src="${ctp}/data/ckeditor/product/${vo.FSName}"></a>
	 			<p class="productname pt-2"><c:if test="${vo.sellSw=='NO'}"><div class="badge badge-danger">판매종료</div></c:if>${vo.name}</p>
	 			<p>${vo.content}</p>
	 			<p><b><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></b>원</p>
	 		</div>
 		<c:set var="i" value="${i+1}"/>
 		<c:if test="${i%4==0}"></div></c:if>
 	</c:forEach>
 	<c:if test="${i%4!=1}"></div></c:if>

  
  
	</div>
</div>
<!-- 블록 페이지 시작 -->
<div class="text-center mt-5">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/subscribe/subscribeMain?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
