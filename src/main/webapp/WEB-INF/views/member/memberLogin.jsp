<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
	 <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
   <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
		input {
			font-family:'Noto Sans KR', sans-serif;
			font-weight: 300;
		}
	</style>
	<script>
		'use strict';
		
		function fCheck(){
			let mid = myform.mid.value;
			let pwd = myform.pwd.value;
			
			if(mid.trim()==""){
				alert("아이디를 입력해주세요.");
				return;
			}
			else if(pwd.trim()==""){
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			myform.submit();
		}
		
  	window.Kakao.init("91755d6e69519d43f059b293cab99a32");
  	//카카오로그인
  	function kakaoLogin() {
  		window.Kakao.Auth.login({
  			scope: 'profile_nickname, account_email',
  			success:function(autoObj) {
  				console.log(Kakao.Auth.getAccessToken(),"로그인 OK");
  				console.log(autoObj);
  				window.Kakao.API.request({
  					url : '/v2/user/me',
  					success:function(res) {
  						const kakao_account = res.kakao_account;
  						myform2.email.value= kakao_account.email;
  						myform2.submit();
  					}
  				});
  			}
  		});
  	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div style="height:50px;"></div>
<div class="container text-center fadein" >
	<form name="myform" method="post">
		<table class="table table-borderless border form-group" style="width:60%;margin:0 auto" >
			<tr>
				<td class="pl-5 pr-5 pt-5 pb-3"><input type="text" name="mid" id="mid" placeholder=" 사용자명 (아이디) " value="${mid}" class="form-control bg-light" style="height:50px"></td>
			</tr>
			<tr>
				<td class="pl-5 pr-5 pb-3"><input type="password" name="pwd" id="pwd" placeholder=" 비밀번호 " class="form-control bg-light" style="height:50px"></td>
			</tr>
			<tr>
				<td class="pl-5 pr-5 pb-3">
					<button type="button" onclick="fCheck()" class="btn form-control text-white" style="height:50px;background-color:darkblue">
						로 그 인
					</button>
				</td>
			<tr>
				<td class="text-center pb-3">
					<input type="checkbox" name="idCheck" value="on"/> 아이디 저장하기<br/><br/>
					<img src="${ctp}/images/카카오로그인.png" onclick="kakaoLogin()"/><br/><br/>
					<input type="button" class="btn btn-light border btn-lg pl-5 pr-5" value="비회원 주문 조회" onclick="location.href='${ctp}/orders/ordersSearch';"/>
				</td>
			</tr>
			<tr>
				<td class="text-center bg-light pt-4 pb-4" style="color:darkblue">
					<a href="${ctp}/member/memberIdSearch"><i class='bx bx-key'></i> (아이디)비밀번호를 잊으셨나요?</a>
				</td>
			</tr>
		</table>
	</form>
	<form name="myform2" method="post" action="${ctp}/member/memberKakaoLogin">
		<input type="hidden" name="email"/>
	</form>
</div>

<div style="height:50px;"></div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
