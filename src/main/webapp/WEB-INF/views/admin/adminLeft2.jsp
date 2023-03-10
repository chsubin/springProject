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
	  <br/>${sMid}???, ???????????????.<br/><br/><hr/>
	</div>
  <div class="panel-group text-center table-hover" id="accordion">
    <div class="panel panel-default bg-light ">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">??????????????????</a>
        </div>
      </div>
      <div id="collapse1" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/adboard/adminBoardList" target="adminContent">???????????????</a></div>
        <div class="panel-body pt-2"><a href="${ctp}/admin/reviews/adminReviewsList" target="adminContent">??????????????? ??????</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">????????????</a>
        </div>
      </div>
      <div id="collapse2" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/category/adminCategory" target="adminContent">??????????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/product/adminProductList" target="adminContent">?????? ??????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/orders/adminSubList" target="adminContent">???????????? ????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/orders/adminOrderList" target="adminContent">???????????? ????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/refund/adminRefundList" target="adminContent">??????/????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminQnaList" target="adminContent">1:1??????</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">???????????? ??????</a>
        </div>
      </div>
      <div id="collapse3" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsApply" target="adminContent">?????? ???????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsInput" target="adminContent">???????????? ??????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsList" target="adminContent">???????????? ??????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminJoinsRequest" target="adminContent">?????? ?????? ??????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/joins/adminRequestList" target="adminContent">?????? ?????? ??????</a></div>
      </div>
    </div>
    <div class="panel panel-default bg-light">
      <div class="panel-heading text-white ">
        <div class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">????????????</a>
        </div>
      </div>
      <div id="collapse4" class="panel-collapse collapse">
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminBasisUpdate" target="adminContent">???????????? ??????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/member/adminMemberList" target="adminContent">???????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/member/adminMemberAnalize" target="adminContent">????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/coupons/adminCouponInput" target="adminContent">????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminAnalize" target="adminContent">???????????????</a></div>
        <div class="panel-body pt-2 pb-2"><a href="${ctp}/admin/extra/adminFileList" target="adminContent">??????????????????</a></div>
      </div>
    </div>
  </div>
  <br/><br/>
  <div class="bg-light mb-1 borderbox"><a href="javascript:logoutCheck()" class="btn bg-light"><b>????????????</b></a></div>
  <div class="bg-light borderbox"><a href="${ctp}/" target="_top" class="btn bg-light"><b> ??? ??? ??? </b></a></div>
</div>
</body>
</html>