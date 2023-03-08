<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1대1 문의</title>
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
		.cli {
			cursor:pointer;
		}
		.cli:hover {
			background-color:#ccc;
		}
  </style>
  <script>
  	'use strict';
  	
  	
  	$(function() {
  		$("#message").scrollTop(1000000);
			$("#faq").hide();
	  		$(".answer").hide();
  	 });
  	
  	function inputQNA(){
  		let part= myform.part.value;
  		let content = myform.content.value;
  		if(content.trim()==""){
  			alert("내용을 입력해주세요.");
  			return false;
  		}
  		
	  	$.ajax({
	  		type:"post",
	  		url:"${ctp}/qna/qnaInput",
	  		data:{questionId:"${sMid}",part:part,question:content},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  	
  	}
  	function showBox(box){
  		if($("#"+box).is(':visible')){
	  		/* $("#"+box).hide(300); */
  		}
  		else {
	  		$(".box").hide(300);
	  		$("#"+box).show(300);
  			
  		}
  		
  	}
  	function showAnswer(idx){
  		if($("#answer"+idx).is(':visible')){
	  		$("#answer"+idx).hide(300);
  		}
  		else {
	  		$("#answer"+idx).show(300);
  			
  		}
  	}
  	
  	
  	
  </script>
</head>
<body class=" bg-light">
<form name="myform" >
	<p><br/></p>
	<div class="container-fluid p-0 m-0 message">
	  <h1 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/main/상담.JPG" style="width:80px"/>&nbsp;&nbsp; 1대1 문의</b></h1>
	  <div class="p-0">
			<span class="p-3 cli m-0" onclick="showBox('list')" ><b>1대1 문의</b></span>
			<span class="p-3 cli m-0" onclick="showBox('faq')" ><b>자주 묻는 질문</b></span>
			<div style="width:100%" class="box p-3" id="list" class="p-3" >
			  <div id="message" class="border bg-white" style="height:420px;overflow:auto">
				  <c:forEach var="vo" items="${vos}">
				  </c:forEach>
				  <c:forEach var="vo" items="${vos}">
				  	<c:if test="${!empty vo.answer}">
				  		<div class="" style="width:100%">
								<div style="border: 1px solid #ddd;border-radius:20px/20px;background-color: #f1f1f1;" class=" shadow-sm fadein mr-5 p-4 m-2">
									<h6><b>리얼후르츠</b></h6>  		
									<h6>${vo.answer}</h6>  		
									<h6 >${vo.answerDate}</h6>  		
						  	</div>
					  	</div>
				  	</c:if>
				  	<c:if test="${!empty vo.question}">
				  		<div class="" style="width:100%">
								<div style="border: 1px solid #ccc;border-radius:20px/20px;background-color: #ddd;" class="shadow-sm fadein ml-5 p-4 m-2">
									<h6> ${vo.question}</h6>  		
									<h6 class="text-right">${vo.questionDate}</h6> 		
						  	</div>
					  	</div>
				  	</c:if>
				  </c:forEach>
			 	 </div>
			   <h4 class="p-2"> 문의사항 등록</h4>
			  <div class="p-0">
					<div style="width:100%" id="inputBox"  >
						<select class="form-control" name="part">
							<option>구독</option>
							<option>결제취소/환불</option>
							<option>배송</option>
						</select>
						<textarea rows="2" name="content" class="form-control" ><c:if test="${empty sMid}">로그인이 필요한 화면입니다.</c:if></textarea>
						<c:if test="${!empty sMid}"><input type="button" value="등록" class="btn btn-success form-control" onclick="inputQNA()"/></c:if> 
						<c:if test="${empty sMid}"><input type="button" value="등록" class="btn btn-secondary form-control" disabled="disabled" /></c:if>
					</div>
				</div>
			</div>
			</div>
		</div>
	  <div class=" p-0">
			<div style="width:100%" class="box p-3" id="faq"  >
		  <div id	="message" class="border bg-white" style="height:600px;overflow:auto">
		  	<table class="table">
				  <c:forEach var="vo" items="${faqVos}">
				  	<tr>
				  		<td onclick="showAnswer(${vo.idx})" class="cli p-4"><b>${vo.question}</b></td>
				  	</tr>
				  	<tr>
				  		<td class="m-0 p-0" style="background-color:#ddd">
				  			<div id="answer${vo.idx}" class="pl-3 pr-3 answer" style="width:100%">
				  				<br/>
					  			<div  style="width:100%">
					  				ㄴ ${vo.answer}
					  			</div>
					  			<div  style="width:100%" class="text-right p-3">
					  				${vo.answerDate}
					  			</div>
				  			</div>
				  		</td>
				  	</tr>
				  </c:forEach>
				  <tr><td class="m-0 p-0"></td></tr>
			  </table>
			</div>
		</div> 
	</div>
	<p><br/></p>
</form>
</body>
</html>