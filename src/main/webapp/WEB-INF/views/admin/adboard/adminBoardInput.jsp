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
 	
  	//상품 등록 유효성 검사
  	function fCheck(){
  		let title = myform.title.value;
  		let content = myform.content.value;
  		if(title.trim()=="") {alert("제목을 입력해주세요.");return;}
  		
  		myform.submit();
  	}
  	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<nav class="navbar navbar-expand-sm border shadow-sm" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="adminBoardList">공지사항 리스트 |</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">공지사항 등록</a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border-bottom border-left border-right shadow-sm" style="background-color:#fff">
		<form name="myform" method="post">
			<table class="table" style="margin:0 auto;width:80%">
				<tr>
					<th width="10%"><h4><b> 제목 : </b></h4></th>
					<td><input type="text" name="title" id="title" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="30" name="content"  id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
		        <script>
		        	CKEDITOR.replace("content",{
		        		height : 500,
		        		filebrowserUploadUrl:"${ctp}/imageUpload",
		        		uploadUrl : "${ctp}/imageUpload"
		        	});
		        </script>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><br/><br/>
						<input type="button" value="등록하기" onclick="fCheck()"  class="btn btn-warning">
						<input type="button" value="다시쓰기"  class="btn btn-secondary">
					</td>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}"/>
		</form>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>