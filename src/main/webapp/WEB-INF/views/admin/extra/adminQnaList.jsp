<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>adminQnaList.jsp</title>
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
		.contain {
  border: 2px solid #dedede;
  background-color: #f1f1f1;
  border-radius: 5px;
  padding: 10px;
  margin: 10px 0;
}

.darker {
  border-color: #ccc;
  background-color: #ddd;
}
.cli{
	cursor:pointer;
}
		
	 </style>
 <script>
 	'use strict';
 	 //setTimeout("location.reload()", 1000*10);
	 	function answerInput(){
	 		let answer = myform.answer.value;
	 		let questionId = "${param.questionId}";
	 		
	 		$.ajax({
	 			type:"post",
	 			url:"${ctp}/admin/extra/qnaAnswerInput",
	 			data:{answer:answer,questionId:questionId,answerId:"${sMid}"},
	 			success:function(){location.reload()},
	 			error:function(){location.reload()}
	 		});
	 		
	 	}
	 	function fDelete(questionId){
	 		alert(questionId);
	 		$.ajax({
	 			type:"post",
	 			url:"qnaExit",
	 			data:{questionId:questionId},
	 			success:function(){location.reload()},
	 			error:function(){alert("실패")}
	 		});
	 	}
 		function fDeleteBy(idx){
 			alert(idx);
 			
 			$.ajax({
 				type:"post",
 				url:"qnaDelete",
 				data:{idx:idx},
 				success:function(){
 					location.reload();
 				},
 				error:function(){alert("전송오류")}
 			});
 			
 		}
 		function fResister(){
 			let idx = myform.question.value;
 			let answer = myform.answer.value;
 			let ans = confirm("자주 묻는 질문으로 등록하시겠습니까?");
 			if(!ans) return;
 			if(answer.trim()==""){
 				alert("답변을 작성해주세요.");
 				return;
 			}
 			$.ajax({
 				type:"post",
 				data:{idx:idx,answer:answer},
 				url:"qnaUpdateLevel",
 				success:function(){
 					alert("자주묻는 질문으로 등록되었습니다.");
 				},
 				error:function(){
 					alert("등록실패");
 				}
 				
 				
 			});
 		}
 	function locationFAQ(){
  		let url="adminQnaFAQ"
  		window.open(url,"nWin","width=500px,height=800px");
 	}
 	
 	
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>1:1 문의</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid  p-3">
		<div class="row m-0 shadow-sm" style="height:700px;background-color:#fff" >
			<div id="leftWindow" class="border col-sm-4 bg-light shadow-sm" style="overflow:auto;height:85vh">
		 		<div style="width:93%;" class="text-right m-3 p-3" >
		 			<!-- 검색 | 설정 | --> 
		 			<a href="javascript:locationFAQ()">FAQ 관리</a> 
		 			|<button class="btn border" onclick='location.reload();'><i class='bx bx-loader' ></i></button>
		 		</div>
				<table class="table" style="width:93%">
					<c:forEach var="midVo" items="${vos}">
						<tr>
							<td>
								<a class="btn-lg btn" href="${ctp}/admin/extra/adminQnaList?questionId=${midVo.questionId}">${midVo.questionId} 
								</a>
							  <c:if test="${midVo.ASw=='n'}"> <div class="badge badge-danger">N</div></c:if>
							</td>
							<td class="text-right">
								${midVo.QDate}
							</td>
						</tr>
					</c:forEach>
					<tr><td class="p-0 m-0"></td></tr>
				</table>
		  </div>
		  <div id="rightWindow"  class="border bg-white col-sm-8 p-0 m-0" style="height:85vh">
		  	<div class="shadow">
		  		<h4 class="m-0 p-3 bg-dark text-white"  >${param.questionId}<c:if test="${empty param.questionId}">공지사항</c:if></h4>
		  	</div>
		  	<div class="p-2" style="overflow:auto;height:540px" >
				  <c:forEach var="vo" items="${qVos}">
				  	<c:if test="${!empty vo.question}">
				  		<div class="pr-5" >
								<div style="border: 1px solid #ddd;border-radius:20px/20px;background-color: #f1f1f1;" class=" shadow-sm fadein mr-5 p-4 m-2">
									<h6><input type="radio" name="question" value="${vo.idx}"/> ${vo.question}</h6>  		
									<h6 >${vo.questionDate} <span class="border bg-white cli" onclick="fDeleteBy(${vo.idx})"  style="color:gray">&nbsp;X&nbsp;</span> </h6>  		
						  	</div>
					  	</div>
				  	</c:if>
				  	<c:if test="${!empty vo.answer&&empty vo.question}">
				  		<div class="pl-5">
								<div style="border: 1px solid #ccc;border-radius:20px/20px;background-color: #ddd;" class="shadow-sm fadein ml-5 p-4 m-2">
									<h6> ${vo.answer}</h6>  		
									<h6 class="text-right">${vo.answerDate} <span class="border bg-white cli" onclick="fDeleteBy(${vo.idx})" style="color:gray">&nbsp;X&nbsp;</span></h6> 		
						  	</div>
					  	</div>
				  	</c:if>
				  </c:forEach>
			  </div>
			  
			  
			  <div class="border" style="width:100%;position:absolute;bottom:0px;background-color:#fff" >
				  <table class="table">
				  	<tr>
				  		<td>
				  			<input type="button" class="btn btn-danger" value="채팅방 나가기" onclick="fDelete('${param.questionId}')">
				  			<input type="button" class="btn btn-success" value="자주묻는질문으로 등록하기" onclick="fResister()">
				  		</td>
				  	</tr>
				   </table>
			  	<textarea rows="3" name="answer" class="form-control" placeholder="답변을 작성해주세요." ></textarea>
			  	<div style="width:100%" class="text-right p-2 bg-light"><input type="button" class="btn btn-light border" value="전송" onclick="answerInput()"/></div>
			  </div>
		  </div>
		 </div>
	</div>
</form>
</body>
</html>