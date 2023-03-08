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
	
 	function fCheck(idx){
 		let content= $("#content").val();
 		
 		$.ajax({
			type:"post",
			url:"${ctp}/admin/joins/adminJoinsMemoUpdate",
			data:{idx:idx,content:content},
			success:function(){alert("상담결과를 등록하였습니다.");location.reload();},
			error:function(){}
 		});
 	}
 		
 		$(function(){
 			$("#joinSw").change(function(){
 				let joinSw= $("#joinSw").val();
 				location.href="adminJoinsApply?joinSw="+joinSw;
 			});
 		});
 		
 		function fReply(idx){
 			let ans = confirm("제휴를 재개하시겠습니까?");
 			$.ajax({
 				type:"post",
 				data:{idx:idx},
 				url:"adminjoinsReply",
 				success : function(){
 					location.reload();
 				},
 				error : function(){
 					alert("전송 오류");
 				}
 			});
 			
 		}
 		
 		
 		
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>제휴 신청서</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<div class=" p-5 text-right" style="width:100%" >
			<select name="joinSw" id="joinSw" style="height:50px">
				<option value="0"<c:if test="${joinSw==0}"> selected </c:if> >신청</option>
				<option value="99" <c:if test="${joinSw==99}"> selected </c:if> >처리완료</option>
			</select>
		</div>
		<c:set var="cnt" value="9" />
		<div class="row">
			<c:if test="${empty vos}"><h4 class="text-center">신청서가 없습니다.</h4></c:if>
			<c:forEach var="vo" items="${vos}">
				<div class="col-md-4">
					<table class="table bg-white table-borderless shadow" style="border:1px solid #ccc">
						<tr class="table table-borderless"><td colspan="2" class="text-center'"><h5><b>기업제휴 상담신청서</b>
							<c:if test="${vo.joinSw==1}"> <div class="badge badge-success">제휴기업</div></c:if>
							<c:if test="${vo.joinSw==-2}"> 
								<div class="badge badge-warning">제휴종료</div>
								<div class="btn btn-outline-info" onclick="fReply(${vo.idx})">제휴재개하기</div>
							</c:if>
						
						
						 </h5>
						</td>
						</tr>
						<tr  class="table table-borderless">
							<td  class="p-3">${vo.name}</td>
						</tr>
						<tr>
							<td class="p-3">${vo.comname}</td>
						</tr>
						<tr>
							<td  class="p-3">${vo.tel}</td>
						</tr>
						<tr>
							<td  class="p-3">${vo.email}</td>
						</tr>
						<tr  class="table">
							<td class="p-3">${vo.part}</td>
						</tr>
						<tr>
							<td class="p-3 border">(상담 신청) ${vo.content}</td>
						</tr>
						<c:if test="${joinSw==0}">
							<tr>
								<td class="p-3 border"><textarea rows="3" class="form-control" id="content" ${joinSw==0?'':'readonly'} >${vo.content}</textarea> </td>
							</tr>
							<tr>
								<td class="p-3" colspan="2">
									<input type="button" class="btn btn-outline-success" value="상담 종료" onclick="fCheck(${vo.idx})"/>
									<input type="button" class="btn btn-outline-info" value="제휴농가로 등록" onclick="location.href='${ctp}/admin/joins/adminJoinsInput?idx=${vo.idx}'"/>
								</td>
							</tr>
						</c:if>
						<c:if test="${vo.joinSw==-1}">
							<tr>
								<td class="p-3 border">(상담 종료)</td>
							</tr>
						</c:if>
						<c:if test="${vo.joinSw==1||vo.joinSw==-2}">
							<tr>
								<td class="p-3 border">(상담 종료) 제휴기업으로 등록 </td>
							</tr>
						</c:if>
					</table>
				</div>
			</c:forEach>
			
			
		</div>

	
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=1&joinSw=${joinSw}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&joinSw=${joinSw}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=${i}&joinSw=${joinSw}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=${i}&joinSw=${joinSw}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&joinSw=${joinSw}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="adminJoinsApply?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&joinSw=${joinSw}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
	</div>
</div>
<p><br/><br/></p>
</body>
</html>