<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
		$(document).ready(function(){
				$(".reply").hide();
			});
		function fCheck(idx){
			if($("#confirmBtn"+idx).val()=="답글") {$("#reply"+idx).slideDown(300);$("#confirmBtn"+idx).val("닫기")}
			else if($("#confirmBtn"+idx).val()=="닫기") {$("#reply"+idx).slideUp(300);$("#confirmBtn"+idx).val("답글")}
		}
		
		
		function boardInput(level,pidx){
			let content ="";
			if(level==0)content= myform.content.value;
			else content= $("#contents"+pidx).val();
			let mid = "${sMid}";
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
		function fUpdate(idx){
			if($("#updateBtn"+idx).val()=="수정") {$("#ureply"+idx).slideDown(300);$("#updateBtn"+idx).val("닫기")}
			else if($("#updateBtn"+idx).val()=="닫기") {$("#ureply"+idx).slideUp(300);$("#updateBtn"+idx).val("수정")}
		}
		function replyUpdate(idx){
			let content= $("#ucontents"+idx).val();
			if(content.trim()==""){alert("댓글 내용을 입력해주세요.");return;}
			$.ajax({
				type:"post",
				data : {idx:idx,content:content},
				url : "${ctp}/board/boardReplyUpdate",
				success:function(){
					location.reload();
				},
				error:function(){
					alert("댓글 수정 실패");
				}
			});
		}
		function fDelete(idx){
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
		function updateLike(flag,sw){
			$.ajax({
				type:"post",
				data:{idx:"${vo.idx}",flag:flag},
				url: "${ctp}/reviews/updateLike",
				success:function(res){
					if(res==0) {alert("좋아요(싫어요)를 먼저 취소해주세요.");}
					else location.reload();
				},
				error:function(){alert("실패");}
			});
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid fadein" style="width:80%">
	<div class="border" style="width:100%">
		<form name="myform" >
			<table class="table text-center table-borderless" style='width:80%;margin:0 auto'>
				<tr class="table-borderless">
					<td>
						<h1 class="p-3" style="font-family:ChosunNm"><b>${vo.title}</b></h1>				
					</td>
				</tr>
				<tr>
					<td class="bg-light pt-4">
						작성자 : <b>${vo.mid}</b>&nbsp;&nbsp;&nbsp; 작성일 : ${fn:substring(vo.WDate,0,19)}  &nbsp;&nbsp;&nbsp;조회수 : ${vo.views}
						<c:if test="${sMid==vo.mid}">
							<input type="button" value="수정" class="btn btn-outline-warning"  onclick="location.href='reviewsUpdate?idx=${vo.idx}';"/>
							<input type="button" value="삭제" class="btn btn-outline-danger" onclick="location.href='reviewsDelete?idx=${vo.idx}';"/>
						</c:if>
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
				<tr class="text-left">
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
			<table class="table" style='width:80%;margin:0 auto'>
				<tr>
					<td>다음글 : <a href="${ctp}/reviews/reviewsContent?idx=${vo.nextIdx}">${vo.nextTitle}</a></td>
				</tr>
				<tr class="table-borderless">
					<td>이전글 :<a href="${ctp}/reviews/reviewsContent?idx=${vo.prevIdx}"> ${vo.prevTitle}</a></td>
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
									<td width="80%">
										<font color="darkblue"><b>${replyVo.mid}</b></font><br/><br/>
										${replyVo.content}<br/>
										<font color="gray">${fn:substring(replyVo.RDate,0,19)}</font><br/>
										<input type="button" id="confirmBtn${replyVo.idx}" value="답글" class="btn btn-light border mt-3 mb-3" onclick="fCheck(${replyVo.idx})">
										<br/>
									</td>
									<td width="20%" class="text-right">
										<c:if test="${sMid==replyVo.mid}">
											<input type="button" onclick="fUpdate(${replyVo.idx})" class="btn" id="updateBtn${replyVo.idx}" value="수정"/> <!--수정하기 -->
											<input type="button" onclick="fDelete(${replyVo.idx})" value="x" class="btn"/> <!-- 삭제하기 -->
										</c:if>
									</td>
								</tr>
								<tr >
									<td colspan="2" class="m-0 p-0">
									<div class="reply p-3" style="width:100%" id="reply${replyVo.idx}">&nbsp;&nbsp;&nbsp;&nbsp;
										<textarea rows="3" name="contents" id="contents${replyVo.idx}" class="form-control" style="width:80%;display:inline"></textarea>
										<input type="button" class="btn btn-outline-success  m-0" onclick="boardInput(1,${replyVo.PIdx})" style="display:inline;vertical-align: top;" value="등록"/>
									</div>
									<div class="reply p-3" style="width:100%" id="ureply${replyVo.idx}">&nbsp;&nbsp;&nbsp;&nbsp;
										<textarea rows="3" name="ucontents" id="ucontents${replyVo.idx}" class="form-control" style="width:80%;display:inline">${replyVo.content}</textarea>
										<input type="button" class="btn btn-outline-success  m-0" onclick="replyUpdate(${replyVo.idx})" style="display:inline;vertical-align: top;" value="수정"/>
									</div>
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
											<input type="button" onclick="fUpdate(${replyVo.idx})" class="btn" id="updateBtn${replyVo.idx}" value="수정"/> <!--수정하기 -->
											<input type="button" onclick="fDelete(${replyVo.idx})" value="x" class="btn"/> <!-- 삭제하기 -->
										</c:if>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="p-0">
										<div class="reply p-3" style="width:100%" id="ureply${replyVo.idx}">&nbsp;&nbsp;&nbsp;&nbsp;
											<textarea rows="3" name="ucontents" id="ucontents${replyVo.idx}" class="form-control" style="width:80%;display:inline">${replyVo.content}</textarea>
											<input type="button" class="btn btn-outline-success  m-0" onclick="replyUpdate(${replyVo.idx})" style="display:inline;vertical-align: top;" value="수정"/>
										</div>
									</td>
								</tr>
								</c:if>
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
