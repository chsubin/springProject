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
		'use strict';
		function boardInput(level,pidx){
			let content ="";
			if(level==0)content= myform.content.value;
			else content= $("#contents"+pidx).val();
			let mid = "${sMid}";
			alert(level);
			$.ajax({
				type:"post",
				data :{boardIdx:"${vo.idx}",level:level,mid:mid,content:content,pIdx:pidx},
				url: "${ctp}/board/boardReplyInput",
				success:function(){
					location.reload();
				},
				error: function(){
					alert("댓글 작성 실패");
				}
			});
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid" style="width:80%">
	<div class="border" style="width:100%">
		<form name="myform">
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
				<tr class="table-borderless">
					<td>
						<table class="table table-borderless">
							<c:forEach var="replyVo" items="${replyVos}">
								<tr>
									<td colspan="2">
										<table class="table">
											<c:if test="${replyVo.level!=0}"><tr class="bg-light"></c:if>
											<c:if test="${replyVo.level==0}"><tr></c:if>
												<td>
													<c:if test="${replyVo.level!=0}">&nbsp;ㄴ</c:if>${replyVo.mid}<br/>
													${replyVo.content}
												</td>
												<td class="text-right">
													${replyVo.RDate} 
													<input type="button" class="btn btn-success" value="답글"/>
												</td>
											</tr>
											<c:if test="${replyVo.level==0}">
												<tr>
													<td colspan="2"><textarea rows="2" name="contents" id="contents${replyVo.idx}" class="form-control" style="width:80%;display:inline"></textarea>
													<input type="button" class="btn btn-success" onclick="boardInput(1,${replyVo.PIdx})" style="width:18%;display:inline" value="등록"/></td>
												</tr>
											</c:if>
										</table>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty sMid}">
								<tr>
									<td width="90%">
										<textarea rows="3" name="content" class="form-control"></textarea>
									</td>
									<td>
										<input type="button" class="btn btn-success form-control" onclick="boardInput(0,0)" value="등록"/>
									</td>
								</tr>
							</c:if>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<br/><br/><br/>
  </div>
</div>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
