<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>환불 신청 완료</title>
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
  	
  	function fLoca(){
  		opener.location.href = "${ctp}/member/memberMain";
  		window.close();
  	}
  </script>
</head>
<body class=" bg-light">
<form name="myform" method="post">
	<p><br/></p>
	<div class="container-fluid message">
	  <h1 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/main/상담.JPG" style="width:80px"/>&nbsp;&nbsp; 환불 신청 완료</b></h1>
	  <div class="bg-white text-center p-5" >
	  	<h2>환불 신청이 완료되었습니다.</h2>
	  	<img src="${ctp}/images/정기배송썸네일1.jpg" style="width:100%" class="jb-box">
	  	<c:if test="${!empty sMid}">
	  		<input type="button" class="btn btn-lg btn-success p-3" value="환불신청내역 보러가기" onclick="fLoca()"/>
	  	</c:if>
	  </div>
	</div>
	<p><br/></p>
	<input type="hidden" name="delItems" value="${param.del}"/>
</form>
</body>
</html>