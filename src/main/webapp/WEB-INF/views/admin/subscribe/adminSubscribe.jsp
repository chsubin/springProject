<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
	 <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid">
	
	  <ul class="nav headernav justify-content-end m-2">
    <li class="nav-item">
	    <a class="nav-link" href="${ctp}/member/memberLogout">
		  	<font class="headericon" size="4em"></font>
	    	 리얼후르츠 관리자 접속시간 : 
	    </a>
    </li>
		<li class="nav-item dropdown">
      <a class="nav-link" >
		  	<font class="headericon" size="4em"></font>
      	HOME
      </a>
    </li>
    <li class="nav-item">
	    <a class="nav-link btn btn-sm btn-outline-primary" href="${ctp}/admin/adminContent">
		  	<font class="headericon" size="4em"></font>
	    	  HOME
	    </a>
    </li>
  </ul>
	<p><br/></p>
	<h2 class="text-center  "><b> 정기배송 상품 관리 </b></h2>
	<p><br/></p>
		<nav class="navbar navbar-expand-sm border">
		  <ul class="navbar-nav">
		    <li class="nav-item active">
		      <a class="nav-link" href="#">상품등록</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">| 상품수정</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">| 상세설명</a>
		    </li>
		  </ul>
		</nav>
		<div class="container-fluid p-5 border">
			<h3>정기배송 상품 등록</h3><br/><br/>
			<table class="table">
				<tr>
					<th class="bg-light"> 상품 제목 </th>
					<td><input type="text" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품 간단 설명 </th>
					<td><input type="text"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품 상세 설명 </th>
					<td><input type="text"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품 사진 </th>
					<td><input type="file"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품 가격 </th>
					<td><input type="text"  class="form-control form-file"></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><br/><br/>
						<input type="button" value="상품등록"  class="btn btn-warning">
						<input type="button" value="다시쓰기"  class="btn btn-secondary">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>