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
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>배송정보 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border-bottom border-left border-right shadow-sm" style="background-color:#fff">
		<form name="myform" method="post">
			<table class="table">
				<tr>
					<th class="bg-light" width="20%"> 배송비 </th>
					<td><input type="text" name="deliveryPrice" id="deliveryPrice" placeholder="숫자로만 입력해주세요." value="${vo.deliveryPrice}" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 배송비 무료 최소금액 </th>
					<td><input type="text" name="deliveryMinPrice" id="deliveryMinPrice" placeholder="숫자로만 입력해주세요."  value="${vo.deliveryMinPrice}" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 배송상세설명 </th>
					<td>
						<textarea rows="30" name="deliveryDetail"  id="deliveryDetail" class="form-control" required>${vo.deliveryDetail}</textarea></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" class="btn btn-dark" value="수정"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>