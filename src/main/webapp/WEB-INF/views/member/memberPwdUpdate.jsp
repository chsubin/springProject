<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberPwdUpdate.jsp</title>
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
			  $('[data-toggle="tooltip"]').tooltip();   
			});
		
		
		function fCheck(){
			let oldPwd = myform.oldPwd.value;
			let newPwd = myform.newPwd.value;
			let pwdConfirm = myform.pwdConfirm.value;
			
			if(oldPwd.trim()==""||newPwd.trim()==""||pwdConfirm.trim()==""){
				alert("빈칸을 모두 채워주세요.");
				return;
			}
			else if(newPwd!=pwdConfirm){
				alert("비밀번호 확인이 일치하지 않습니다.");
				return;
			}
			/* const pwdregx=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g; */
			const pwdregx=/^[0-9]{4,20}$/g;
			if(!newPwd.match(pwdregx)){alert("비밀번호는 8~20자, 하나이상의 영문 대/소문자,숫자,특수문자를 입력해주세요.");myform.newPwd.focus();return;}
			
			myform.submit();
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid text-center" style="width:80%" >
	<form name="myform" method="post">
		<div class="container-fluid  p-5" >
			<table class="table table-borderless" style="width:80%;margin:0 auto">
				<tr>
					<td ><h2 style="font-family:ChosunNm">비밀번호 변경</h2></td>
				</tr>
				<tr class="text center">
					<td class="p-5">
					<table class=" border"  style="width:100%;margin:0 auto">
						<tr>
							<td width="25%" class="pl-5 pr-5 pt-5"><h5>기존 비밀번호</h5></td>
							<td class="pl-5 pr-5  pt-5"><input type="password" name="oldPwd" class="form-control"></td>
						</tr>
						<tr>
							<td width="25%" class="pl-5 pr-5"><h5>새 비밀번호 <a href="#" data-toggle="tooltip" title="8~20자 이내 영문/숫자 조합(특수문자 입력 필수)"> ❓</a></h5></td>
							<td class="pl-5 pr-5"><input type="password" name="newPwd" class="form-control"></td>
						</tr>
						<tr>
							<td width="25%" class="pl-5 pr-5 pb-5"><h5>비밀번호 확인</h5></td>
							<td class="pl-5 pr-5  pb-5"><input type="password" name="pwdConfirm" class="form-control"></td>
						</tr>
						<tr>
							<td colspan="2" class="pl-5 pr-5  pb-5">
								<input type="button" value="수정하기" onclick="fCheck()" class="form-control btn btn-lg btn-info"><br/><br/>
								<c:if test="${!empty sMid}">
									<input type="button" value="마이페이지로 가기" onclick="location.href='${ctp}/member/memberMain';" class="form-control btn btn-lg btn-warning" >
								</c:if>							
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" name="mid" value="${sMid}"/>
	</form>
</div>
<div style="height:50px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
