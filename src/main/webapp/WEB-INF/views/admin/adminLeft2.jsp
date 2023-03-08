<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;500;700&display=swap" rel="stylesheet">
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
    * {
      font-size: 1em;
      font-family:'ChosunNm', sans-serif;
    }
    
  .accordion, .panel-title {
  background-color: #fff;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
 /*  border: none; */
  border-top: 1px solid #FFF;
  border-bottom: 1px solid #FFF;
  text-align: left;
  outline: none;
  font-size: 1.4em;
	font-weight:500;
  transition: 0.4s;
  font-weight: bolder;
}
.panel-body{
  font-size: 1.3em;
	font-weight:300;
	background-color: white;
}

	.borderbox{
		border: 1px solid gray;
	}

.active, .accordion:hover {
  background-color: #ccc; 
}
  </style>
  <script>
    function logoutCheck() {
    	parent.location.href = "${ctp}/member/memberLogout";
    }
  </script>
</head>
<body class="border" style="background-color:#fff" >
<div class="container text-center p-0 mr-2" style="width:100%; -ms-overflow-style: none;">
	<div style="width:100%;background-color:lightblue" class="shadow-sm">
		<br/>
	  <img src="${ctp}/images/main/none.png" style="width:100px" class="w3-circle"/>
	  <br/>${sMid}님, 안녕하세요.<br/><br/><hr/>
	</div>
  <div class="panel-group text-center table-hover" id="accordion">
    <div class="panel panel-default bg-light ">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">커뮤니케이션</a>
        </div>
      </div>
      <div id="collapse1" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/adboard/adminBoardList" target="adminContent">이벤트관리</a></div>
        <div class="panel-body pt-2"><a href="${ctp}/admin/reviews/adminReviewsList" target="adminContent">리뷰게시판 관리</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">상품관리</a>
        </div>
      </div>
      <div id="collapse2" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/category/adminCategory" target="adminContent">상품분류등록</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/product/adminProductList" target="adminContent">상품 관리</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/orders/adminSubList" target="adminContent">정기배송 주문관리</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/orders/adminOrderList" target="adminContent">단품상품 주문관리</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/refund/adminRefundList" target="adminContent">환불/결제취소</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminQnaList" target="adminContent">1:1문의</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">제휴농가 관리</a>
        </div>
      </div>
      <div id="collapse3" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsApply" target="adminContent">농가 제휴신청서</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsInput" target="adminContent">제휴농가 등록</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsList" target="adminContent">제휴농가 조회</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsRequest" target="adminContent">상품 배송 요청</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminRequestList" target="adminContent">배송 요청 내역</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white ">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">기타관리</a>
        </div>
      </div>
      <div id="collapse4" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminBasisUpdate" target="adminContent">배송정보 관리</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/member/adminMemberList" target="adminContent">회원리스트</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/member/adminMemberAnalize" target="adminContent">회원통계</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/coupons/adminCouponInput" target="adminContent">쿠폰관리</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminAnalize" target="adminContent">사이트분석</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminFileList" target="adminContent">임시파일관리</a></div>
      </div>
    </div>
  </div>
  <br/><br/>
  <div class="bg-light mb-1 borderbox"><a href="javascript:logoutCheck()" class="btn bg-light"><b>로그아웃</b></a></div>
  <div class="bg-light borderbox"><a href="${ctp}/" target="_top" class="btn bg-light"><b> 홈 으 로 </b></a></div>
</div>
</body>
</html>