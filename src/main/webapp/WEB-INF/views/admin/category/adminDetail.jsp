<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품분류등록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3" >
	<nav class="navbar navbar-expand-sm border shadow-sm" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="${ctp}/admin/category/adminCategory">소분류 등록 | </a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${ctp}/admin/category/adminDetail"><h4 class="p-0 m-0">정기배송 상세페이지</h4></a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<form method="post">
			<table class="table">
				<tr>
					<th class="bg-light">상세페이지 수정</th>
				</tr>
				<tr>
        <td class="p-0"><textarea rows="30" name="content"  id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
        <script>
        	CKEDITOR.replace("content",{
        		height : 500,
        		filebrowserUploadUrl:"${ctp}/imageUpload",
        		uploadUrl : "${ctp}/imageUpload"
        	});
        </script>
				</tr>
				<tr class="text-center">
					<td><input type="submit" class="btn btn-success" value="수정등록"/>
					<input type="reset" class="btn btn-danger" value="다시쓰기"/></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<p><br/></p>
</body>
</html>