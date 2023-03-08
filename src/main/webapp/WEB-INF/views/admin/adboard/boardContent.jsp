<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>boardContent.jsp</title>
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
	 'use strict;'
	
	 function deleteCheck(idx){
		 let ans = confirm("이벤트 게시글을 삭제하시겠습니까?");
		 if(!ans)return;
		 
		 location.href="${ctp}/admin/board/boardDelete?idx="+idx;
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
<div class="container-fluid  p-3 ">
	<nav class="navbar navbar-expand-sm border shadow-sm" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="#">이벤트 리스트 |</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="adminBoardInput">이벤트 등록</a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
			<table class="table text-center table-borderless" style='width:80%;margin:0 auto'>
				<tr class="table-borderless">
					<td>
						<h1 class="p-3" style="font-family:ChosunNm"><b>${vo.title}</b></h1>				
					</td>
				</tr>
				<tr>
					<td>
						<img src="${ctp}/images/main/none.png" class="w3-circle">
						<br/>${vo.mid}
						<br/>${vo.WDate}
						<input type="button" value="수정" class="btn btn-outline-warning"  onclick="location.href='boardUpdate?idx=${vo.idx}';"/>
						<input type="button" value="삭제" class="btn btn-outline-danger" onclick="location.href='boardDelete?idx=${vo.idx}';"/>
					</td>	
				</tr>
				<tr>
					<td><hr/>&nbsp;</td>
				</tr>
				<tr class="text-center">
					<td>${vo.content}</td>
				</tr>
				<tr>
					<td class="text-left pl-5 pr-5">
						<div class="bg-light p-3 mt-5 mb-3"><img src="${ctp}/images/main/none.png" class="rounded">&nbsp;&nbsp;<font color="gray">${vo.mid}</font></div>
					</td>
				</tr>
				<tr>
			</table>
			<table class="table" style='width:80%;margin:0 auto'>
				<tr>
					<td>다음글 : <a href="${ctp}/board/boardContent?idx=${vo.nextIdx}">${vo.nextTitle}</a></td>
				</tr>
				<tr class="table-borderless">
					<td>이전글 :<a href="${ctp}/board/boardContent?idx=${vo.prevIdx}"> ${vo.prevTitle}</a></td>
				</tr>
				<tr><td class="m-0 p-0"></td></tr>
			</table>
			<br/><br/>
			<table class="table" style='width:80%;margin:0 auto'>
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
										<input type="button" id="confirmBtn${replyVo.idx}" value="답글" class="btn btn-light border mt-3 mb-3" onclick="fCheck(${replyVo.idx})">
										<br/>
									</td>
									<td class="text-right" width="20%">
										<input type="button" onclick="fDelete(${replyVo.idx})" value="x" class="btn"/> <!-- 삭제하기 -->
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
							<c:if test="${!empty sMid}">
							</c:if>
						</table>
					</td>
				</tr>
			</table>
		
	</div>
</div>
<p><br/><br/></p>
</body>
</html>
