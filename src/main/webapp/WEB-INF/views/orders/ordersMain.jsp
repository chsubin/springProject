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
	.opac{
	opacity:40%;
	}
	</style>
	<script>
		'use strict';
		
		$(function(){
			if($("#orderBy").change(function(){
				let orderBy = $("#orderBy").val();
				location.href ="ordersMain?codeSmall=${codeSmall}&orderBy="+orderBy;
				
			}));
		});
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid fadein text-center p-0 m-0">
  <div class="text-center">
  	<div class="text-left" style="position:absolute;top:300px;left:200px">
  		<h4>|시즌확정|</h4><br/>
  		<h1>
    		건강해지는, 리얼후르츠가 보장하는 <br/><br/>
    		<b>지금먹기 딱 맛있는 제철과일!</b><br/><br/><br/>
  		</h1>
 		</div>
  	<img src="${ctp}/images/orders/단품상품-테스트-완성1.jpg" style="width:100%;"/>
	</div>
</div>
<p><br/></p>
<div class="container-fluid fadein" style="width:80%">
	<c:if test="${!empty cateVo}">
		<div class="row p-5">
	  	<div class="col-sm-4 text-right">
	  	<h2 class="m-3 mr-5" style="font-family:font-family:'Noto Sans KR', sans-serif;font-weight:500;"><b>${cateVo.smallName}</b></h2>
	  	</div>
	  	<div class="col" style="border-left:2px solid gray">
		 	 <h6>${cateVo.content}</h6>
	  	</div>
	  </div>
  </c:if>
	<ul class="nav nav-pills justify-content-center actio">
  	<c:forEach var="categoryVo" items="${categoryVos}">
	    <li class="nav-item">
	      <c:if test="${codeSmall==categoryVo.codeSmall}">
	      	<a class="nav-link" href="${ctp}/orders/ordersMain?codeSmall=${categoryVo.codeSmall}">&nbsp;<div class="btnActive p-3">&nbsp;${categoryVo.smallName}&nbsp;</div>&nbsp;</a>
	      </c:if>
	      <c:if test="${codeSmall!=categoryVo.codeSmall}">
	      	<a class="nav-link" href="${ctp}/orders/ordersMain?codeSmall=${categoryVo.codeSmall}">&nbsp;<div class="btnNone p-3" >&nbsp;${categoryVo.smallName}&nbsp;</div>&nbsp;</a>
	      </c:if>
	    </li>
  	</c:forEach>
  </ul>
 	<table class="table table-borderless text-right">
 		<tr>
 			<td></td>
 			<td width="20%">
 				<select class="form-control" id="orderBy">
 					<option value="">등록순</option>
 					<option value="p.price" ${orderBy=='p.price'?'selected':''}>가격순</option>
 					<option value="orders" ${orderBy=='orders'?'selected':''}>인기순</option>
 					<option value="reviews" ${orderBy=='reviews'?'selected':''}>리뷰많은순</option>
 				</select>
 			</td>
 		</tr>
 	</table>
	<p><br/></p>
 	<c:set var="i" value="0"/>
 	<c:forEach var="vo" items="${vos}">
 		<c:if test="${i%4==0}"><div class="row m-3" ></c:if>
	 		<div class="col-sm-3 fadein">
	 			<a href="${ctp}/orders/ordersProduct?idx=${vo.idx}"><img style="width:100%;"   ${vo.sellSw=='NO'?'class=opac':''} src="${ctp}/data/ckeditor/product/${vo.FSName}"></a>
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
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=1&codeSmall=${codeSmall}&orderBy=${orderBy}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&codeSmall=${codeSmall}&orderBy=${orderBy}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=${i}&codeSmall=${codeSmall}&orderBy=${orderBy}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=${i}&codeSmall=${codeSmall}&orderBy=${orderBy}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&codeSmall=${codeSmall}&orderBy=${orderBy}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/orders/ordersMain?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&codeSmall=${codeSmall}&orderBy=${orderBy}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
