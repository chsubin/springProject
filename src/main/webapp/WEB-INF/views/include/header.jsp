<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>header.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Noto+Serif+KR:wght@600&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;500;700&display=swap" rel="stylesheet">
  <style>
  	.headernav{
  		font-family:'Noto Sans KR', sans-serif;
  		font-weight:300;
  		font-size:1.1em;
  	}
  	.headernav a{
  		font-family:'Noto Sans KR', sans-serif;
  		font-weight:300;
  		font-size:1.0em;
  	}
  	.headericon{
  	 position:relative;
  	}
  	.cli{
  		cursor:pointer;
  	}

  </style>
</head>
<body>
<div class="container-fluid mt-1 p-3 text-center" id="allSearch" style="width:80%">
	<input type="text" id="productSearch"	placeholder="상품이름을 입력하세요." style="height:40px;width:500px;border-top:0px;border-left:0px;border-right:0px;border-bottom:1px solid #ccc"/>
	 <font size="5em"><i class='bx bx-search-alt cli' onclick="fTitleSearch()"></i></font><h1 style="display:inline;color:#555" onclick="hide()" class="cli"> X</h1>
</div>
<div class="container-fluid mt-1" style="height:20px;width:80%">
  <ul class="nav headernav justify-content-end">
    <li class="nav-item">
    	<c:if test="${empty sLevel}">
	      <a class="nav-link" href="${ctp}/member/memberLogin">
			  	<font class="headericon" size="4em"><i class='bx bx-log-in'></i></font>
	      	 &nbsp;로그인
	      </a>
      </c:if>
    	<c:if test="${!empty sLevel}">
	      <a class="nav-link" href="${ctp}/member/memberLogout">
			  	<font class="headericon" size="4em"><i class='bx bx-log-out'></i></font>
	      	 &nbsp;로그아웃
	      </a>
      </c:if>
    </li>
  	<c:if test="${empty sLevel}">
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" data-toggle="dropdown" >
			  	<font class="headericon" size="4em"><i class='bx bxs-user-plus'></i></font>
	      	&nbsp;회원가입
	      </a>
	      <div class="dropdown-menu text-center">
	        <a class="dropdown-item" href="${ctp}/member/memberJoin" >개인회원</a>
	        <a class="dropdown-item" href="${ctp}/member/memberComJoin">기업회원</a>
	      </div>
	    </li>
    </c:if>
  	<c:if test="${sLevel==2||sLevel==3}">
	    <li class="nav-item">
	      <a class="nav-link"  href="${ctp}/member/memberMain" >
			  	<font class="headericon" size="4em"><i class='bx bxs-user'></i></font>
	      	&nbsp;MyPage
	      </a>
	    </li>
    </c:if>
  	<c:if test="${sLevel==0||sLevel==1}">
  		 <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" data-toggle="dropdown" >
			  	<font class="headericon" size="4em"><i class='bx bxs-user'></i></font>
	      	&nbsp;My
	      </a>
	      <div class="dropdown-menu text-center">
	        <a class="dropdown-item" href="${ctp}/member/memberMain" >MyPage</a>
	        <a class="dropdown-item" href="${ctp}/admin/adminMain">관리자화면</a>
	      </div>
	    </li>
    </c:if>
    <li class="nav-item">
    	<div class="pt-2">
		  	&nbsp;&nbsp;<font class="headericon pt-3" size="4em"><i class='bx bxs-cart-alt' onclick="location.href='${ctp}/member/memberBucket';"></i></font>
		  	&nbsp;<font class="headericon pt-3" size="4em"><i class='bx bx-search-alt-2' class="cli btn" onclick="fAllSearch()"></i></font>
	  	</div>
	  </li>	
  </ul>
</div>
<hr/>
<div class="container text-center">
  <!-- <h3 class="text-center" style="font-family:'Noto Sans KR', sans-serif;"></h3> -->
  <img src="${ctp}/images/logo-1.png" onclick="location.href='${ctp}/'"/>
</div>
<br/>
</body>
  <script>
  	'use strict';
  	
		$("#allSearch").hide();
  		
  	function fAllSearch(){
  		$("#allSearch").slideDown();
  		$("#allSearch").focus();
  	}
  	function hide(){
  		$("#allSearch").slideUp();
  	}
  	
  	function fTitleSearch(){
  		let productSearch = $("#productSearch").val();
  		if(productSearch.trim()==""){alert("검색어를 입력해주세요.");}
  		location.href="${ctp}/searchProductList?search="+productSearch;
  	}
  
  </script>
</html>