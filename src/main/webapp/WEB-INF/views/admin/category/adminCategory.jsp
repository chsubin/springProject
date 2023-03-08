<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		.cli:hover{
		 cursor:pointer;
		}
	 </style>
	 <script>
	 	'use strict';
	 		function fLgCheck(idx){
 			  $("#codeLarge"+idx).prop('checked', true);
	 		}
	 		function fSmCheck(codeLarge,codeSmall,smallName,content){
 				$("#codeLarge"+codeLarge).prop('checked', true);
 				$("#smallName").val(smallName);
 				$("#content").val(content);
 			  $("#codeSmall"+codeSmall).prop('checked', true);
	 		}
	 	
	 	
	 	 function fCheck(){
	 		 let codeLarge = myform.codeLarge.value;
	 		 let smallName = myform.smallName.value;
	 		 let content = myform.content.value;
	 		 
	 		 if(smallName.trim()==""){
	 			 alert("소분류 제목을 입력해주세요.");
	 			 myform.smallName.focus();
	 			 return false;
	 		 }
	 		 else if(content.trim()==""){
	 			 alert("소분류 제목을 입력해주세요.");
	 			 myform.content.focus();
	 			 return false;
	 		 }
	 		 
	 		 $.ajax({
	 			 type:"post",
	 			 url:"${ctp}/admin/category/categoryInput",
	 			 data : {
	 				 codeLarge:codeLarge,
	 				 smallName:smallName,
	 				 content:content
	 			 },
	 			 success:function(res){
	 				 location.reload();
	 			 },
	 			 error:function(){
	 				 location.reload();
	 			 }
	 		 });
	 	 }
	 	 function fUpdate(){
	 		 let ans =confirm("선택하신 카테고리를 수정하시겠습니까?");
	 		 if(!ans) return false;
	 		 let codeLarge = myform.codeLarge.value;
	 		 let smallName = myform.smallName.value;
	 		 let codeSmall= myform.codeSmall.value;
	 		 let content = myform.content.value;
	 		 
	 		 if(smallName.trim()==""){
	 			 alert("소분류 제목을 입력해주세요.");
	 			 myform.smallName.focus();
	 			 return false;
	 		 }
	 		 else if(content.trim()==""){
	 			 alert("소분류 제목을 입력해주세요.");
	 			 myform.content.focus();
	 			 return false;
	 		 }
	 		 
	 		 $.ajax({
	 			 type:"post",
	 			 url:"${ctp}/admin/category/categoryUpdate",
	 			 data : {
	 				 codeLarge:codeLarge,
	 				 codeSmall:codeSmall,
	 				 smallName:smallName,
	 				 content:content
	 			 },
	 			 success:function(res){
	 				 location.reload();
	 			 },
	 			 error:function(){
	 				 location.reload();
	 			 }
	 		 });
	 		
	 		
	 	}
	 	 
	 	 
	 	function fDelete(codeSmall){
	 		let ans=confirm("선택하신 카테고리를 삭제하시겠습니까?");
	 		if(!ans) return;
	 		 $.ajax({
	 			 type:"post",
	 			 url:"${ctp}/admin/category/categoryDelete",
	 			 data : {
	 				 codeSmall:codeSmall,
	 			 },
	 			 success:function(res){
	 				 location.reload();
	 			 },
	 			 error:function(){
	 				alert("카테고리에 들어있는 상품을 먼저 삭제해주세요.");
	 				 location.reload();
	 			 }
	 		 });
	 	}
	 	 
	 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품분류등록</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid  p-3" >
		<nav class="navbar navbar-expand-sm border shadow-sm" style="background-color:#fff">
		  <ul class="navbar-nav">
		    <li class="nav-item active">
		      <a class="nav-link" href="${ctp}/admin/category/adminCategory"><h4 class="p-0 m-0">소분류 등록</h4></a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="${ctp}/admin/category/adminDetail">| 정기배송 상세페이지</a>
		    </li>
		  </ul>
		</nav>
		<div class="container-fluid p-5 border-bottom border-left border-right shadow-sm" style="background-color:#fff">
			<div class="row" style="background-color:#fff;width:80%;margin:0 auto" >
				<div class="col-md-4">
					<div class="border p-3">
						<h3 class="text-center">카테고리</h3>
						<table class="table table-borderless table-hover">
							<c:forEach var="largeVo" items="${largeVos}">
								<tr>
									<td  class="cli" onclick="fLgCheck(${largeVo.codeLarge})">
										<h6><b>${largeVo.largeName}</b></h6>
									</td>
									<td class="text-right"></td>
								</tr>
								<c:forEach var="smallVo" items="${smallVos}">
									<c:if test="${largeVo.codeLarge==smallVo.codeLarge}">
										<tr><td class="cli" onclick="fSmCheck('${smallVo.codeLarge}','${smallVo.codeSmall}','${smallVo.smallName}','${smallVo.content}')">
											<input type="radio" name="codeSmall" id="codeSmall${smallVo.codeSmall}" value="${smallVo.codeSmall}"/>&nbsp;└${smallVo.smallName}
										</td>
											<td class="text-right pt-4">
												<h5 style="display:inline"><i class='bx bx-edit'></i></h5>
												<h5 style="display:inline" class="cli" onclick="fDelete(${smallVo.codeSmall})"><i class='bx bx-x'></i></h5>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="col-md-8 ">
	
					<table class="table table-borderless">
						<tr>
							<th >상품 대분류</th>
							<td>
								<c:forEach var="largeVo" items="${largeVos}">
									<input type="radio" value="${largeVo.codeLarge}" id="codeLarge${largeVo.codeLarge}" name="codeLarge" />${largeVo.largeName}&nbsp;&nbsp;
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>소분류 제목</th>
							<td><input type="text" name="smallName" id="smallName" class="form-control"></td>
						</tr>
						<tr>
							<th>소분류 간단 설명</th>
							<td><textarea rows="5" name="content" id="content" class="form-control"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center"><br/><br/>
								<input type="button" value="신규등록" onclick="fCheck()"  class="btn btn-success">
								<input type="button" value="수정하기" onclick="fUpdate()"  class="btn btn-warning">
								<input type="reset" value="취소"  class="btn btn-secondary">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>