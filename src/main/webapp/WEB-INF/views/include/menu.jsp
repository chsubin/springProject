<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>menu.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Noto+Serif+KR:wght@700&display=swap" rel="stylesheet">
   <style>
		.navrow a:hover {
			text-decoration:none;
			color:darkblue;
		}
		.navrow {
  		font-family:'Noto Sans KR', sans-serif;
  		font-weight:700;
  		font-size: 1.1em;
  		color:black;
  	}
		.ss {
			color:gray;
			font-family: serif;
			font-weight:lighter;
		}
  	.butt:hover {
			background-color:orange;
			transition: all 0.2s linear;
		}
		.butt {
			background-color:darkblue;
			color:white;
			transition: all 0.2s linear;
		}
		nav{
			z-index: 5;
		}
		.sidenav {
  width: 120px;
  position: fixed;
  z-index: 9990;
  top: 270px;
  left: 10px;
  overflow-x: hidden;
  padding: 8px 0;
}
  </style>
  
</head>
<body>
<br/>
<div class="container-fluid container-nav text-center  sticky-top" style="height:60px;background-color:white">
	<div class="container-fluid" style="width:80%" >
	  <nav class="row navbar navrow border-top border-bottom p-3 sticky-top" style="height:60px">
	  	<span class="ss">|</span> 
	  	<a class="col" href="${ctp}/subscribe/shome">정기배송</a> <span class="ss">|</span> 
	  	<a class="col" href="${ctp}/orders/ordersMain">쇼핑하기</a> <span class="ss">|</span> 
	  	<a class="col" href="${ctp}/board/boardList">이벤트</a> <span class="ss">|</span> 
	  	<a class="col" href="${ctp}/reviews/reviewsList">리뷰</a> <span class="ss">|</span> 
	  	<a class="col" href="${ctp}/introduce/introduce">리얼후르츠</a> <span class="ss">|</span> 
	  	<a class="col" href="${ctp}/business/businessMain">비즈몰</a> <span class="ss">|</span>  
	  </nav>
  </div>
</div>

<div class="sidenav border shadow bg-light pt-0" style="width:100px">
	<table class="text-center table mt-0">
		<tr>
			<td style="background-color:darkblue">
				<font size="2em" style="color:white">최근 본 상품</font>
			</td>
		</tr>
		<tr>
			<c:if test="${empty sProductVos}">
				<tr>
					<td><br/><br/><br/>최근 본 상품이 없습니다.<br/><br/><br/></td>
				</tr>
			</c:if>
			<c:set var="i" value="${sProductCnt-1}"/>
			<c:forEach items="${sProductVos}" var="vo">
				<tr>
					<td class="p-3">
						<img src="${ctp}/data/ckeditor/product/${sProductVos[i].FSName}" onclick="location.href='${ctp}/${sProductVos[i].flag}/${sProductVos[i].flag}Product?idx=${sProductVos[i].idx}';" style="width:100%"><br/>
					</td>
				</tr>	
				<c:set var="i" value="${i-1}"/>
			</c:forEach>
  </table>
</div>

<div class="qna " style="position:fixed;right:50px;bottom:50px;"><img src="${ctp}/images/main/상담.JPG" style="border:4px solid darkblue;width:60px;" onclick="question()" class="w3-circle shadow-sm"></div>
		<script>
	  	function question(){
	  		let url="${ctp}/qna/qnaMain"
	  		window.open(url,"nWin","width=500px,height=800px");
	  	}
		
	</script>
</body>
</html>