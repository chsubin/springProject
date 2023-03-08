<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
		h4, h1, .fonts {
			font-family:'Noto Sans KR', sans-serif;
			font-weight:300;
  	}
  	.imgh:hover{
  		opacity: 50%;
  	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid text-center p-0 m-0 fadein">
  <div class="text-center">
  	<img src="${ctp}/images/introduce/카테고리5-브랜드소개페이지.jpg" style="width:100%;"/>
	</div>
	<div class="m-5 p-5">
		<h3>Our vision</h3>
		<h4>리얼후르츠의 비전</h4><br/><br/>
		<p class="fonts">리얼후르츠는 바쁜 현대인들을 위한 건강한 푸드컬처를 만들어 가기 위해 노력합니다.</p>
	</div>
  <div class="text-center text-white">
  	<div style="position:absolute;width:100%;margin-top:250px">
  		<h5>생산자와 소비자가 함께 나누고 싶은 리얼후르츠의 마음</h5><br/>
  		<p>
    		리얼후르츠는 기존 유통과정을 거치지 않고 과일산지와의 거래를 통하여, <br/>
    		농가와 소비자를 이을 수 있는 시스템을 지향하고 있습니다.<br/><br/><br/>
  		</p>
 		</div>
  	<img src="${ctp}/images/introduce/카테고리5-브랜드소개페이지2.jpg" style="width:100%;"/>
	</div>
	<div class=" p-5 m-5">
		<h3 class="fonts">What we do</h3><br/>
		<p class="fonts">
			이익과 편안함보다 정직한 가격과 까다로운 기준의 불편함을 추구하는 사람들.<br/>
			건강하고 맛있는 과일을 공급하는 사람들.
		</p>
		<div class="container pt-5">
			<div class="text-center card-deck p-5">
				<div class="card">
		      <div class="card-body text-center">
		      	<img src="${ctp}/images/introduce/카테고리5-브랜드소개아이콘1.jpg" class="imgh">
		      	<hr/>
		        <p class="card-text">
		        	경력 20년 이상의 과일 마스터 노하우로 품질 좋은 과일만을 엄선하여 드립니다.
		        </p>
		      </div>
		    </div>
				<div class="card">
		      <div class="card-body text-center">
		      	<img src="${ctp}/images/introduce/카테고리5-브랜드소개아이콘2.jpg" class="imgh">
		      	<hr/>
		        <p class="card-text">
		        	경력 20년 이상의 과일 마스터 노하우로 품질 좋은 과일만을 엄선하여 드립니다.
		        </p>
		      </div>
		    </div>
				<div class="card">
		      <div class="card-body text-center">
		      	<img src="${ctp}/images/introduce/카테고리5-브랜드소개아이콘3.jpg" class="imgh">
		      	<hr/>
		        <p class="card-text">
		        	경력 20년 이상의 과일 마스터 노하우로 품질 좋은 과일만을 엄선하여 드립니다.
		        </p>
		      </div>
		    </div>
				<div class="card">
		      <div class="card-body text-center">
		      	<img src="${ctp}/images/introduce/카테고리5-브랜드소개아이콘4.jpg" class="imgh">
		      	<hr/>
		        <p class="card-text">
		        	경력 20년 이상의 과일 마스터 노하우로 품질 좋은 과일만을 엄선하여 드립니다.
		        </p>
		      </div>
		    </div>
	    </div>
		</div>
	</div>
</div>
<p><br/></p>
<div class="container">
</div>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
