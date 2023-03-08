<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<table class="table table-borderless">
	<tr>
		<td width="20%"><img src="${ctp}/images/logo-1.png" style="width:120px" onclick="location.href='${ctp}/'"/></td>
		<td class="pt-4" ><h2 style="font-family:'ChosunNm'">My Page</h2></td>
	</tr>
</table>
<table class="table table-bordered bg-light text-center">
	<tr class="text-center">
		<td colspan="3"><h2><i class='bx bxs-user-rectangle'></i>&nbsp; <b>${sMid}</b> 님</h2>
			<br/>${vo.mid}님 안녕하세요.
			<br/>${vo.email}
		</td>
	</tr>
	<tr>
		<td><span onclick="location.href='${ctp}/member/memberPwdUpdate'" class="cli">비밀번호 변경</span></td>
		<td ><span onclick="memberDelete()" class="cli">회원 탈퇴</span></td>
	</tr>
</table>
<table class="table table-hover table-borderless">
	<tr>
		<td class="cli" onclick="location.href='${ctp}/member/memberUpdate'"><h3>내 정보</h3></td>
	</tr>
	<tr>
		<td class="cli" onclick="location.href='${ctp}/member/memberOrderList'"><h3>내 주문내역</h3></td>
	</tr>
	<tr>
		<td class="cli" onclick="location.href='${ctp}/member/memberSubList'"><h3>내 구독상품</h3></td>
	</tr>
	<tr>
		<td class="cli" onclick="location.href='${ctp}/member/memberReviewsList'"><h3>내가 작성한 리뷰</h3></td>
	</tr>
	<tr>
		<td class="cli" onclick="location.href='${ctp}/refund/refundList'"><h3>환불 신청 내역</h3></td>
	</tr>
	<c:if test="${sLevel==3}">
		<tr>
			<td class="cli" onclick="location.href='memberJoinsApply'"><h3>제휴 기업 신청</h3></td>
		</tr>
	</c:if>
	<c:if test="${sLevel<2}">
		<tr>
			<td class="cli" onclick="location.href='${ctp}/admin/adminMain'"><h3>관리자 메뉴</h3></td>
		</tr>
	</c:if>
</table>
<div class="mt-5 pt-5"  style="width:100%;position:absolute;bottom:20px;" class="text-right">
	<div class="btn btn-lg btn-light border text-dark" onclick="location.href='${ctp}/'"><h4><i class='bx bxs-store'></i> 샵으로 </h4></div>
	<div class="btn btn-lg btn-light border text-dark" onclick="location.href='${ctp}/member/memberMain'"><h4><i class='bx bx-home' ></i> MyPage </h4></div>
	<div class="btn btn-lg  btn-light border text-dark" onclick="location.href='${ctp}/member/memberLogout'"><h4><i class='bx bx-log-out'></i>로그아웃</h4></div>
</div>
<form name="myform" method="post" action="${ctp}/member/memberDelete">
</form>

<script>
	function memberDelete(){
		let ans=confirm("정말로 탈퇴하시겠습니까?");
		if(!ans)return;
		myform.submit();
	}

</script>
