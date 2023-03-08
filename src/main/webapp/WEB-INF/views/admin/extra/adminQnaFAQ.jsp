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
		.cli {cursor:pointer}
  </style>
  
  <script>
  	'use strict';
  	
  	
  	$(function() {
  		$("#message").scrollTop(1000000);
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
  	
  	$(function(){
  		$(".answer").hide();
  	});
  	function showAnswer(idx){
  		if($("#answer"+idx).is(':visible')){
	  		$("#answer"+idx).slideUp(300);
  		}
  		else {
	  		$("#answer"+idx).slideDown(300);
  			
  		}
  	}
  	function fCheck(idx){
  		let answer =  $("#answerInput"+idx).val();
  		if(answer.trim==""){
  			alert("답변을 작성해주세요.");
  			return;
  		}
  		$.ajax({
  			type:"post",
  			data:{idx:idx,answer:answer},
  			url:"${ctp}/admin/extra/qnaUpdateLevel",
  			success:function(){
  				alert("답변을 수정했습니다.");
  				location.reload();
  			},
  			error:function(){
  				alert("오류");
  			}
  		});
  	}
  	function fDelete(){
  		let idxs="";
  		alert(myform.chk[0].value);
   		for(let i=0;i<myform.chk.length;i++){
  			if(myform.chk[i].checked){
	  			idxs+= myform.chk[i].value;
	  			idxs+= "/";
  			}
  		} 
   		$.ajax({
   			type:"post",
   			data:{idxs:idxs},
   			url:"${ctp}/admin/extra/qnaFAQDelete",
   			success:function(){
   				location.reload();
   			},
   			error:function(){
   				alert("실패");
   			}
   		});
   		
  	}
  	
  	
  </script>
</head>
<body class=" bg-light">
<form name="myform" >
	<p><br/></p>
	<div class="container-fluid message">
	  <h1 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/main/상담.JPG" style="width:80px"/>&nbsp;&nbsp; FAQ 관리</b></h1>
	  <hr/>
		<h4><b>자주묻는질문</b></h4>
	  <div id="message" class="border bg-white" style="height:600px;overflow:auto">
	  	<table class="table">
			  <c:forEach var="vo" items="${vos}">
			  	<tr>
			  		<td  class="p-4"><b><input type="checkbox" name="chk" value="${vo.idx}"/><span onclick="showAnswer(${vo.idx})" class="cli">  ${vo.question}</span></b></td>
			  	</tr>
			  	<tr>
			  		<td class="m-0 p-0" style="background-color:#ddd">
			  			<div id="answer${vo.idx}" class="pl-3 pr-3 answer" style="width:100%">
			  				<br/>
				  			<div  style="width:100%">
				  			<textarea rows="3" class="form-control" id="answerInput${vo.idx}">${vo.answer}</textarea>
				  			</div>
				  			<div  style="width:100%" class="text-right p-3">
				  				${vo.answerDate}
				  				<input value="수정" type="button" onclick="fCheck(${vo.idx})">
				  			</div>
			  			</div>
			  		</td>
			  	</tr>
			  </c:forEach>
			  <tr><td class="m-0 p-0"></td></tr>
		  </table>
	  </div>
	  <input type="button" class="btn btn-danger form-control" value="삭제하기" onclick="fDelete()"/>
	</div>
	<p><br/></p>
</form>
</body>
</html>