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
		.badge:hover{
		cursor:pointer;
		}
	 </style>
 <script>
 	'use strict';
  function fCheck(){
	  let qcontent = $("#questionInput").val();
	  let answerSw= $("#questionAnswerSw").val();
	  let idx="${vo.idx}";
	  alert(idx);
	  	$.ajax({
	  		type:"post",
	  		url:"serveyAnswerInput",
	  		data:{qcontent:qcontent,answerSw:answerSw,sIdx:idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
  }
  function answerInput(idx){
    let acontent =$("#answerInput"+idx).val();
  	$.ajax({
  		type:"post",
  		url:"serveyAnswerInputOK",
  		data:{sIdx:"${vo.idx}",qIdx:idx,acontent:acontent},
  		success: function(){location.reload();},
  		error: function(){alert("오류!!");}
  	});
  }
  function answerDelete(idx){
	  	$.ajax({
	  		type:"post",
	  		url:"serveyAnswerDeleteOK",
	  		data:{idx:idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
  }
  function questionUpdate(idx){
	  let qcontent = $("#qcontent"+idx).val();
	  	$.ajax({
	  		type:"post",
	  		url:"serveyQuestionUpdateOK",
	  		data:{idx:idx,qcontent:qcontent},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
  }
  function questionDelete(idx){
	  	$.ajax({
	  		type:"post",
	  		url:"serveyQuestionDeleteOK",
	  		data:{idx:idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("답변을 먼저 삭제해주세요.");}
	  	});
  }
 	
 	
 </script>
</head>
<body class="bg-light">
<form name="myform" method="post">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>설문조사 관리</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid p-3">
		<div class="container-fluid p-5 mb-3 border shadow-sm" style="background-color:#fff">
			<table class="table table-borderless">
				<tr>
					<td colspan="2">
						<h2>설문조사 관리</h2>
					</td>
				</tr>
				<tr>
					<td>설문조사명</td>
					<td><input type="text" name="title" value="${vo.title}" class="form-control"/></td>
				</tr>
				<tr>
					<td>부제</td>
					<td><input type="text" name="content" value="${vo.content}" class="form-control"/></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><input type="text" name="memo" value="${vo.memo}" class="form-control"/></td>
				</tr>
				<tr>
					<td>기간설정</td>
					<td>시작일시 <input type="date" name="startDate" value="${fn:substring(vo.startDate,0,10)}" class="form-control" style="display:inline;width:33%"/> 
					- 마감일시 <input type="date" name="endDate" value="${fn:substring(vo.endDate,0,10)}" class="form-control" style="display:inline;width:33%"/>
					<input type="submit" class="btn btn-outline-success"  value="수정" style="display:inline;width:18%"/></td> 
				</tr>
				<tr>
					<td><br/></td>
				</tr>
				<tr class="border-top">
					<td>설문항목 관리</td>
					<td>
						<table class="table table-borderless">
					  	<c:set var="cnt" value="1"/>
						  <c:forEach var="questionVo" items="${questionVos}">
						  	<tr>
						  		<th>
						  			${cnt}. <input type="text" class="form-control" style="width:80%;display:inline" id="qcontent${questionVo.idx}" value="${questionVo.qcontent}"/>
						  			<input type="button" class="btn btn-warning" value="수정" onclick="questionUpdate(${questionVo.idx})"/>
						  			<input type="button" class="btn btn-danger" value="삭제" onclick="questionDelete(${questionVo.idx})"/>
					  			</th>
					  		</tr>
						  	<c:forEach var="answerVo" items="${answerVos}">
						  		<c:if test="${questionVo.idx==answerVo.QIdx}">
							  		<tr>
							  			<td>
							  				&nbsp;&nbsp;&nbsp;
							  				<input type="text"  value="${answerVo.acontent}" class="form-control" style="width:30%;display:inline"/>
						  					<span class="border" style="color:gray" onclick="answerDelete(${answerVo.idx})">x</span>
							  			</td>
							  		</tr>
						  		</c:if>
						  	</c:forEach>
					  		<c:set var="cnt" value="${cnt+1}"/>
					  		<c:if test="${questionVo.answerSw!=0}">
					  			<tr>
					  				<td>
					  					&nbsp;&nbsp;&nbsp;<input type="text" class="form-control" id="answerInput${questionVo.idx}" style="width:30%;display:inline"/>
					  					<span class="border" style="color:gray" onclick="answerInput(${questionVo.idx})">+</span>
					  				</td>
					  			</tr>
					  		</c:if>
					  		<c:if test="${questionVo.answerSw==0}">
					  				<tr><td>&nbsp;&nbsp;&nbsp;서술형 설문조사 입니다.</td></tr>
					  			</c:if>
						  </c:forEach>
						</table>
						<c:if test="${!empty questionVos}"><hr/></c:if>
						<select class="form-control" id="questionAnswerSw" name="questionAnswerSw" style="display:inline;width:20%">
							<option value="2">선택형(복수응답 불가)</option>
							<option value="1">선택형(복수응답 가능)</option>
							<option value="0">서술형</option>
						</select>
						<input type="text" id="questionInput" name="questionInput" class="form-control" style="display:inline;width:60%"/>
						<input type="button" class="form-control btn btn-dark"  onclick="fCheck()"  value="+새 설문항목 추가" style="display:inline;width:18%"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<p><br/></p>
	<input type="hidden" name="idx" value="${vo.idx}"/>
	</form>
</body>
</html>