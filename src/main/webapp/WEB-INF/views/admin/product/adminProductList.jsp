<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		.badge:hover{
		cursor:pointer;
		}
	 </style>
 <script>
 	'use strict';
 	
  	$(function(){
  		$("#codeLarge").change(function(){
  			let codeLarge = $(this).val();
  			$.ajax({
  				type : "post",
  				url : "${ctp}/admin/product/catogory",
  				data : {codeLarge:codeLarge},
  				success : function(smallVos){
  					let str='/ 소분류 : <select name="codeSmall" id="codeSmall"><option value="0">분류 선택</option>';
  					for(let i=0;i<smallVos.length;i++){
  						if(smallVos==null) break;
	  					str +='<option value="'+smallVos[i].codeSmall+'">'+smallVos[i].smallName+'</option>';
  					}
  					str +='</select>';
  					$("#str").html(str);
  				},
  				error : function(){
  				}
  			});
  		});
  	});
 		function fSearch(){
 			let codeLarge=myform.codeLarge.value;
 			let codeSmall=myform.codeSmall.value;
 			
 			location.href="adminProductList?pageSize=${pageVo.pageSize}&pag=1&codeLarge="+codeLarge+"+&codeSmall="+codeSmall
 			
 		}
		function deleteSelect(){
			let deleteboxes ='';
			for(let i=0;i<myform.deleteBox.length;i++){
				if(myform.deleteBox[i].checked){
					deleteboxes+=myform.deleteBox[i].value+"/";
				}
			}
			if(deleteboxes=="") return false;
			$.ajax({
				type:"post",
				url:"${ctp}/admin/product/deleteProduct",
				data:{deleteboxes:deleteboxes},
				success:function(){
					location.reload();
				},
				error:function(){
					alert("이미 주문이 들어온 상품은 삭제하실 수 없습니다.");
					location.reload();
				}
			});
		}
		function deleteAll(){
			let ans =confirm("상품을 모두 삭제하시겟습니까?");
			if(!ans) return false;
			let deleteboxes ='';
			for(let i=0;i<myform.deleteBox.length;i++){
				deleteboxes+=myform.deleteBox[i].value+"/";
			}
			$.ajax({
				type:"post",
				url:"${ctp}/admin/deleteProduct",
				data:{deleteboxes:deleteboxes},
				success:function(){
					location.reload();
				},
				error:function(){
					alert("이미 주문이 들어온 상품은 삭제하실 수 없습니다.");
					location.reload();
				}
			});
		}
		
		function sellEnd(idx,sellSw){
			let ans = confirm("판매상태를 변경하시겠습니까?");
			if(!ans) return;
			$.ajax({
				type:"post",
				url:"productSellSwUpdate",
				data:{idx:idx,sellSw:sellSw},
				success:function(){location.reload();},
				error:function(){alert("전송실패 ㅠ")}
			});
		}
		
		
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 목록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<form name="myform">
			<table class="table">
				<tr class="table-borderless">
					<td colspan="3">
						<input type="button" value="선택삭제" class="btn btn-light border" onclick="deleteSelect()"/>
						<input type="button" value="전체삭제" class="btn btn-light border" onclick="deleteAll()"/> 
					</td>
					<td colspan="4" class="text-right">
						대분류 : 
						<select name="codeLarge" id="codeLarge">
							<option value="0">분류 선택</option>
							<c:forEach var="largeVo" items="${largeVos}">
								<option value="${largeVo.codeLarge}" <c:if test="${largeVo.codeLarge==codeLarge}">selected</c:if> >${largeVo.largeName}</option>
							</c:forEach>
						</select> 
						<span id="str"> / 소분류 : 
							<select id="codeSmall" name="codeSmall">
								<option value="0">분류 선택</option>
								<c:forEach var="smallVo" items="${smallVos}">
									<option value="${smallVo.codeSmall}" <c:if test="${smallVo.codeSmall==codeSmall}">selected</c:if> >${smallVo.smallName}</option>
								</c:forEach>
							</select>
						</span>
						<input type="button" class="btn btn-info" value="검색" onclick="fSearch()"/>
					</td>
				</tr>
				<tr class="text-center">
					<th></th>
					<th>상품코드</th>
					<th>대분류</th>
					<th>소분류</th>
					<th>상품이름</th>
					<th>가격</th>
					<th></th>
				</tr>
				<c:forEach var="vo" items="${vos}">
					<tr  class="text-center">
						<td class="text-left"><input type="checkbox" name="deleteBox" value="${vo.idx}"/><br/><br/><img style="width:100px;height:100px" src="${ctp}/data/ckeditor/product/${vo.FSName}"></td>
						<td>${vo.code}</td>
						<td>${vo.largeName}</td>
						<td>${vo.smallName}</td>
						<td class="text-left">${vo.name}</td>
						<td><fmt:formatNumber value="${vo.price}" pattern="#,##0"/>원</td>
						<td>
							<a href="adminUpdateProduct?idx=${vo.idx}" class="m-1 badge-lg badge badge-warning">수정하기</a><br/>
							<a href="adminOption?idx=${vo.idx}" class="m-1 badge-lg badge badge-success">옵션관리</a><br/>
						 	<c:if test="${vo.sellSw=='OK'}"> <a href="javascript:sellEnd('${vo.idx}','NO')" class="m-1 badge-lg badge badge-danger">판매종료</a><br/></c:if>
						 	<c:if test="${vo.sellSw!='OK'}"><a href="javascript:sellEnd('${vo.idx}','OK')" class="m-1 badge-lg badge badge-info">판매재개</a><br/></c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=1&codeLarge=${codeLarge}&codeSmall=${codeSmall}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&codeLarge=${codeLarge}&codeSmall=${codeSmall}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=${i}&codeLarge=${codeLarge}&codeSmall=${codeSmall}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=${i}&categoryLarge=${categoryLarge}&categorySmall=${categorySmall}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&codeLarge=${codeLarge}&codeSmall=${codeSmall}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="adminProductList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&codeLarge=${codeLarge}&codeSmall=${codeSmall}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
	</div>
</div>
<p><br/><br/></p>
</body>
</html>