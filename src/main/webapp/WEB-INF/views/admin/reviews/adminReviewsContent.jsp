<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
	function fSearch(){
		let part = $("#part").val()
		let search = $("#search").val()
		
		location.href="adminReviewsList?part="+part+"&search="+search;
		
	}
	
	function fReplyDelete(idx){
		let ans ="댓글을 삭제하시겠습니까?";
		
		if(!ans) return;
		$.ajax({
			type:"post",
			url:"deleteReviewReply",
			data : {idx:idx},
			success:function(){location.reload()},
			error:function(){alert("댓글 삭제 실패")}
		});
	}
	function fDelete(idx){
		alert(idx);
		let ans = confirm("댓글을 삭제하시겠습니까?");
		if(!ans)return;
		$.ajax({
			type:"post",
			data:{idx:idx},
			url: "${ctp}/board/boardReplyDelete",
			success:function(){location.reload()},
			error:function(){alert("댓글 삭제 실패ㅜ")}
		});
	}
	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="p-5 m-0 border bg-white shadow" >
		<form name="myform" >
			<table class="table text-center table-borderless" >
				<tr class="table-borderless">
					<td>
						<h1 class="p-3" style="font-family:ChosunNm"><b>${vo.title}</b></h1>				
					</td>
				</tr>
				<tr>
					<td class="bg-light pt-4">
						작성자 : <b>${vo.mid}</b>&nbsp;&nbsp;&nbsp; 작성일 : ${vo.WDate}
						<input type="button" value="삭제" class="btn btn-outline-danger" onclick="location.href='adminReviewsDelete?idx=${vo.idx}';"/>
					</td>	
				</tr>
				<tr class="border-top text-left">
					<td>
						<img style="width:100px;" src="${ctp}/data/ckeditor/product/${vo.productfSName}"> <b>${vo.productName} - ${vo.optionName} 구매</b>
					</td>
				</tr>
				<tr class="text-left">
					<td><br/>
						<h4>${fn:replace(vo.content, newLine, '<br/>')}</h4><br/><br/>
					</td>
				</tr>
				<tr>
					<td>
						<c:if test="${!empty vo.FSName}">
							<c:forEach var="fSName" items="${fSNames}">
								<img style="width:300px" src="${ctp}/data/ckeditor/adboard/${fSName}">
							</c:forEach>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
						<h1>
							<c:if test="${likes!='likes'}"><span onclick="updateLike('likes',1)" style="background-color:darkblue;border-radius:40px;width:50px" >&nbsp;&nbsp;<font color="white"> ${vo.likes} <b><i class='bx bx-like' ></i></b>&nbsp;</font></span></c:if> 
							<c:if test="${likes=='likes'}"><span onclick="updateLike('likes',0)" style="background-color:darkblue;border-radius:40px;width:50px" >&nbsp;&nbsp;<font color="white"> ${vo.likes} <b><i class='bx bxs-like'></i></b>&nbsp;</font></span></c:if> 
							 <c:if test="${likes!='dislike'}"><span onclick="updateLike('dislike',1)" ><font color="darkblue"><b><i class='bx bx-dislike'></i></b></font></span>${vo.dislike}</c:if> 
							 <c:if test="${likes=='dislike'}"><span onclick="updateLike('dislike',0)" ><font color="darkblue"><b><i class='bx bxs-dislike'></i></b></font></span>${vo.dislike}</c:if> 
						</h1>
					</td>
				</tr>
				<tr><td>
					<c:if test="${!empty vo.FSName}">
						<table class="table-borderless">
							<c:forEach var="fName" items="${fNames}" varStatus="st">
								<tr>
									<td><b><c:if test="${st.count==1}"> 첨부파일 <a href="${ctp}/reviews/reviewsTotalDown?idx=${vo.idx}" class="btn btn-outline-info">전체다운</a></c:if></b></td>
									<td class="text-left">
										${st.count}. <a href="${ctp}/data/ckeditor/adboard/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</td></tr>
				<tr>
			</table>
			<table class="table" >
				<tr>
					<td>다음글 : <a href="${ctp}/admin/reviews/adminReviewsContent?idx=${vo.nextIdx}">${vo.nextTitle}</a></td>
				</tr>
				<tr class="table-borderless">
					<td>이전글 :<a href="${ctp}/admin/reviews/adminReviewsContent?idx=${vo.prevIdx}"> ${vo.prevTitle}</a></td>
				</tr>
				<tr><td class="m-0 p-0"></td></tr>
			</table>
			<br/><br/>
			<table class="table" >
				<tr class="table-borderless">
					<td><h4><b>댓글</b></h4></td>
				</tr>
				<tr class="table">
					<td  style="border:1px solid white">
						<table class="table border-top border-bottom">
							<c:forEach var="replyVo" items="${replyVos}">
								<c:if test="${replyVo.level==0}">
								<tr  class="table border-top border-bottom">
									<td>
										<font color="darkblue"><b>${replyVo.mid}</b></font><br/><br/>
										${replyVo.content}<br/>
										<font color="gray">${replyVo.RDate}</font><br/>
										<br/>
									</td>
									<td class="text-right" width="20%">
										<c:if test="${sMid==replyVo.mid}">
											<input type="button" onclick="fDelete(${replyVo.idx})" value="x" class="btn"/> <!-- 삭제하기 -->
										</c:if>
									</td>
								</tr>
								</c:if>
								<c:if test="${replyVo.level!=0}">
								<tr class="bg-light table border-top border-bottom" >
									<td>
										<h4 style="display:inline">ㄴ</h4><font color="darkblue">&nbsp;&nbsp;<b>${replyVo.mid}</b></font><br/><br/>
										&nbsp;&nbsp;&nbsp;&nbsp;${replyVo.content}<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray">${replyVo.RDate}</font><br/><br/>
									</td>
									<td class="text-right" width="20%">
										<c:if test="${sMid==replyVo.mid}">
											<input type="button" onclick="fDelete(${replyVo.idx})" value="x" class="btn"/> <!-- 삭제하기 -->
										</c:if>
									</td>
								</tr>
								</c:if>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
		</form>
			
		<p><br/></p>
	</div>
</div>
</body>
</html>