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
	  // 전체선택
	  $(function(){
	  	$("#checkAll").click(function(){
	    		$(".chk").prop("checked", true);
	  	});
	  });
	  
	  // 선택항목 반전
	  $(function(){
	  	$("#reverseAll").click(function(){
	  		$(".chk").prop("checked", function(){
	  			return !$(this).prop("checked");
	  		});
	  	});
	  });
	  
	  // 선택항목 삭제하기(ajax처리하기)
	  function selectDelCheck() {
	  	let ans = confirm("선택된 모든 게시물을 삭제 하시겠습니까?");
	  	if(!ans) return false;
	  	let delItems = "";
	  	for(let i=0; i<myform.chk.length; i++) {
	  		if(myform.chk[i].checked == true) delItems += myform.chk[i].value + "/";
	  	}
			
	  	alert(delItems);
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/admin/extra/tempFileSelectDelete",
	  		data : {delItems : delItems},
	  		success:function() {
  				alert("선택된 파일을 삭제처리 하였습니다.");
  				location.reload();
	  		},
	  		error  :function() {
	  			alert("전송오류!!");
	  		}
	  	});
	  }
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>임시파일 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<nav class="navbar navbar-expand-sm border" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="adminFileList">CKEDITOR | </a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#"><h4 class="p-0 m-0">TEMP(리뷰 다운로드)</h4></a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<form name="myform">
			<table class="table" style='width:80%;margin:0 auto'>
				<tr class="table-borderless">
					<td colspan="4">
						<h2>임시파일 관리</h2>
					</td>
				</tr>
				<tr class="table-borderless">
					<td colspan="2">
						<input type="button" class="btn btn-light border" id="checkAll" value="전체선택"/>
						<input type="button" class="btn btn-light border" id="reverseAll" value="선택반전"/>
					</td>
					<td colspan="2" class="text-right">
						<input type="button" class="btn btn-danger border " id="checkAll" value="선택삭제" onclick="selectDelCheck()"/>
					</td>
				</tr>
				<tr class="text-center">
					<th>구분</th>
					<th>사진</th>
					<th>이름</th>
					<th>비고</th>
				</tr>
				<c:forEach var="file" items="${files}">
						<tr class="text-center">
							<td><c:if test="${fn:contains(file,'.')}"><input type="checkbox" class="chk" name="chk" id="chk${file}" value="${file}"/></c:if></td>
							<td>
								<c:if test="${fn:contains(file,'.')}">
									<label for="chk${file}" ><img src="${ctp}/data/ckeditor/adboard/temp/${file}" style="width:50px;height:50px"></label>
								</c:if>
								<c:if test="${!fn:contains(file,'.')}">
									<h1><i class='bx bxs-folder-open' ></i></h1>
								</c:if>
							</td>
							<td><label for="chk${file}" >${file}</label></td>
							<td>
							</td>
						</tr>
				</c:forEach>
			</table>
		</form>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
	</div>
</div>
<p><br/><br/></p>
</body>
</html>