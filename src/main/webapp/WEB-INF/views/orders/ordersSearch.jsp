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
			let orderIdx = myform.orderIdx.value;
			let name = myform.name.value;
			
			if(orderIdx.trim()==""){
				alert("주문번호를 입력해주세요.");
				return;
			}
			else if(name.trim()==""){
				alert("이름을 입력해주세요.");
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
  						//console.log(kakao_account);
  						//alert(kakao_account.email +" / "+kakao_account.profile.nickname);
  						myform2.email.value= kakao_account.email;
  						myform2.submit();
  						//location.href="${ctp}/member/memberKakaoLogin?email="+kakao_account.email;
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
				<td class="pl-5 pr-5 pt-5 pb-3"><input type="text" name="orderIdx" id="orderIdx" placeholder=" 주문번호를 입력해주세요. " value="" class="form-control bg-light" style="height:50px"></td>
			</tr>
			<tr>
				<td class="pl-5 pr-5 pb-3"><input type="text" name="name" id="name" placeholder=" 이름 " class="form-control bg-light" style="height:50px"></td>
			</tr>
			<tr>
				<td class="pl-5 pr-5 pb-3">
					<button type="button" onclick="fCheck()" class="btn form-control text-white" style="height:50px;background-color:darkblue">
						조 회
					</button>
				</td>
			<tr>
				<td class="text-center pb-3">
					<input type="button" class="btn btn-lg pl-5 btn-warning pr-5 mb-5" value="로그인 페이지로 돌아가기" onclick="location.href='${ctp}/member/memberLogin';"/>
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
