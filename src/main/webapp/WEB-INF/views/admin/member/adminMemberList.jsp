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
 	function levelUpdate(idx){
 		let level = $("#level"+idx).val();
 		alert(level+" "+idx);
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/member/levelUpdate",
 			data: {level:level,idx:idx},
 			success:function(){alert("등급이 변경되었습니다.");location.reload();},
 			error:function(){alert("등급 수정 실패")}
 		});
 		
 	}
 	$(function(){
 		$("#searchLevel").change(function(){
  		let searchLevel =	$("#searchLevel").val();
 			let part = myform.part.value;
 			let search = myform.search.value;
 			
  		location.href="adminMemberList?searchLevel="+searchLevel+"&part="+part+"&search="+search;
 		});
 	});
 	function fSearch(){
  		let searchLevel =	$("#searchLevel").val();
			let part = myform.part.value;
			let search = myform.search.value;
			
		location.href="adminMemberList?searchLevel="+searchLevel+"&part="+part+"&search="+search;
 	}
 	function fDelete(mid){
 		$.ajax({
 			type:"post",
 			url: "${ctp}/admin/member/adminMemberDelete",
 			data: {mid:mid},
 			success:function(){
 				location.reload();
 			},
 			error: function(){
 				alert("전송실패");
 			}
 		});
 	}
 	
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>회원 목록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">

	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<form name="myform">
		<table class="table" style='width:90%;margin:0 auto'>
			<tr class="table-borderless">
				<td colspan="9">
					<h2>회원리스트</h2>
				</td>
			</tr>
			<tr>
				<td> 
					<select name="searchLevel" id="searchLevel" class="form-control">
						<option value="99" ${searchLevel==99?'selected':''}>구분</option>
						<option value="0" ${searchLevel==0?'selected':''}>관리자</option>
						<option value="1" ${searchLevel==1?'selected':''}>운영자</option>
						<option value="2" ${searchLevel==2?'selected':''}>개인회원</option>
						<option value="3" ${searchLevel==3?'selected':''}>기업회원</option>
					</select>
				</td>
				<td colspan="3" class="text-right">
				</td>
				<td >
					<select name="part" class="form-control">
						<option value="" ${part==''?'selected':''}>구분</option>
						<option value="mid" ${part=='mid'?'selected':''}>아이디</option>
						<option value="name" ${part=='name'?'selected':''}>이름</option>
						<option value="address" ${part=='address'?'selected':''}>주소</option>
					</select>
				</td>
				<td  colspan="2">
					<input type="text" name="search" class="form-control" value="${search}">
				</td>
				<td>
					<input type="button" class="btn btn-success" value="검색" onclick="fSearch()">
				</td>
			</tr>
			<tr class="text-center">
				<th>구분</th>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>포인트</th>
				<th>상태</th>
				<th></th>
			</tr>
			<c:forEach var="vo" items="${vos}">
				<tr class="text-center">
					<td>
						<c:if test="${vo.level==0}">관리자</c:if>
						<c:if test="${vo.level==1}">운영자</c:if>
						<c:if test="${vo.level==2}">개인회원</c:if>
						<c:if test="${vo.level==3}">기업회원</c:if>
					</td>
					<td onclick=""  data-toggle="modal" data-target="#myModal${vo.idx}">${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.tel}</td>
					<td>${vo.email}</td>
					<td>${fn:substring(vo.startDate,0,11)}</td>
					<td>${vo.point}</td>
					<td>
						<c:if test="${vo.userDel!='OK'}"><font color="blue">활동중</font></c:if>
						<c:if test="${vo.userDel=='OK'}">
							<div class="btn btn-danger" onclick="fDelete('${vo.mid}');">탈퇴신청</div>
						</c:if>
					</td>
					<td>
							
							
  <!-- The Modal -->
  <div class="modal fade" id="myModal${vo.idx}">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 상세정보</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<table class="table">
        		<tr>
        			<th>구분</th>
        			<td>
								<select id="level${vo.idx}" name="level">
									<option value="0" ${vo.level==0?'selected':''}>관리자</option>
									<option value="1" ${vo.level==1?'selected':''}>운영자</option>
									<option value="2" ${vo.level==2?'selected':''}>개인회원</option>
									<option value="3" ${vo.level==3?'selected':''}>기업회원</option>
								</select>
								<input type="button" class="btn btn-dark btn-sm" value="등급변경" onclick="levelUpdate(${vo.idx})">
        			</td>
        			
        		</tr>
        		<tr>
        			<th>이메일</th>
        			<td>${vo.email}</td>
        		</tr>
        		<tr>
        			<th>이름</th>
        			<td>${vo.name}</td>
        		</tr>
        		<tr>
        			<th>주소</th>
        			<td>${vo.address}</td>
        		</tr>
        		<tr>
        			<th>연락처</th>
        			<td>${vo.tel}</td>
        		</tr>
        		<c:if test="${vo.level>=3}"> <!-- 기업회원 -->
	        		<tr>
	        			<th>법인명</th>	
	        			<td>${vo.comname}</td>
	        		</tr>
	        		<tr>
	        			<th>사업자 번호</th>	
	        			<td>${vo.comnumber}</td>
	        		</tr>
	        		<tr>
	        			<th>대표자</th>	
	        			<td>${vo.owner}</td>
	        		</tr>
	        		<tr>
	        			<th>업종</th>	
	        			<td>${vo.compart}</td>
	        		</tr>
        		</c:if>
        		<c:if test="${vo.level<3}">
        			<tr>
        				<th>성별</th>
        				<td>${vo.gender}</td>
        			</tr>
        			<tr>
        				<th>생일</th>
        				<td>${vo.birthday}</td>
        			</tr>
        		</c:if>
        		<tr>
        			<th>가입일</th>
        			<td>${fn:substring(vo.startDate,0,19)}</td>
        		</tr>
        		<tr>
        			<th>마지막 방문일</th>
        			<td>${fn:substring(vo.lastDate,0,19)}</td>
        		</tr>
        		<tr>
        			<th>수신동의</th>
        			<td>
        				<c:if test="${vo.receiveSw=='OK'}"><font color="blue">동의</font></c:if>
        				<c:if test="${vo.receiveSw=='NO'}"><font color="red">미동의</font></c:if>
        			</td>
        		</tr>
        	</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
							
							
							
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
<!-- 블록 페이지 시작 -->
<div class="text-center mt-5 mb-5">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=1&searchLevel=${searchLevel}&part=${part}&search=${search}">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVo.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&searchLevel=${searchLevel}&part=${part}&search=${search}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${i}&searchLevel=${searchLevel}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${i}&searchLevel=${searchLevel}&part=${part}&search=${search}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&searchLevel=${searchLevel}&part=${part}&search=${search}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="adminMemberList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&searchLevel=${searchLevel}&part=${part}&search=${search}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
			
	</div>
</div>
</body>
</html>