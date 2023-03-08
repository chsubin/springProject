<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	'use strict';
  window.Kakao.init("91755d6e69519d43f059b293cab99a32");
  
	function kakaoLogout() {
		Kakao.isInitialized();
		//다음에 로그인시에 동의항목 체크하고 로그인 할 수 있도록 로그아웃시키기
		Kakao.API.request({
      url: '/v1/user/unlink',
    })
		Kakao.Auth.logout(function() {
			console.log(Kakao.Auth.getAccessToken(), "토큰 정보가 없습니다.(로그아웃되셨습니다.)");
		});
	}
	kakaoLogout();
	location.href="${ctp}/";
</script>
