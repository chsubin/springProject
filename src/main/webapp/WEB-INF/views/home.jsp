<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
	 <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
 	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;500;700&display=swap" rel="stylesheet">
 	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
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
		.subtitle {
		  font-family:'Noto Sans KR', sans-serif;
  		font-weight:500;
  		font-size:1.7em;
		}
		/* 슬라이드 */
		#slider {
   overflow:hidden;
   position:relative;
   width:100%;  /* 이미지 보여지는 뷰 부분*/
   height:500px;
		}
		.image-box {
		   width:2500px; /* 원본+클론의 총 합*/
		   height:100%;
		   display:flex;
		   flex-wrap:nowrap;
		   animation: bannermove 50s linear infinite;
		}
		@keyframes bannermove {
		  0% {
		      transform: translate(0, 0);
		  }
		  50% {
		      transform: translate(-50%, 0);
		  }
		}
		/* 버튼 */
	.bt .btn {
  border: 2px solid black;
  color: black;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}
	.td1{
		background-color: rgba( 0, 0, 0, 0.5 );
	}
	.td1 h1,h2,h3,h4,h5,h6{
		font-family:'Noto Sans KR', sans-serif;
  	font-weight:100;
		color:white;
	}
	.td1{
		font-family:'Noto Sans KR', sans-serif;
  	font-weight:100;
		color:white;
	}
	.font1 {
		font-size:1.5em;
	}
	.font2 {
		font-size:2em;
  	font-weight:500;
	}
	.rowop:hover{
		opacity: 1;
	}

	</style>
	<script>
/* 	$(function(){
		
		Swal.fire({
			title : "설문조사",
			text : "가장 좋아하는 과일을 선택해주세요.",
			imageUrl : "${ctp}/images/정기배송썸네일1.jpg",
			imageWidth: 315, 
			imageHeight: 300
		});
	});	
 */	
 let url="";
 	$(function(){
 		<c:forEach var="vo" items="${serveyVos}">
  		url="${ctp}/qna/basicServey?idx=${vo.idx}";
	  	window.open(url,"servey${vo.idx}","width=500px,height=800px");
 		</c:forEach>
 		
 		
 		
 	});
 
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid p-0 m-0" style="width:100%;height:600px">
	<div id="demo" class="carousel slide" data-ride="carousel" style="background-image: url(${ctp}/images/main/배경.jpg);">
	
		<!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	  </ul>
	
	  <!-- The slideshow -->
	  <div class="carousel-inner">
	    <div class="carousel-item active text-right">
	    	<div class="text-center" style="position:absolute;top:100px;left:200px;width:800px">
	    		<h1>
		    		건강해지는, 리얼후르츠 <font color="red">과일</font> 정기배송!<br/><br/>
		    		우리가족 맞춤형 <font color="orange">과일</font> 정기배송!<br/><br/><br/>
	    		 <button type="button" class="btn btn-light btn-lg"  onclick="location.href='${ctp}/subscribe/subscribeMain';">보러가기 > </button>
	    		</h1>
	    	</div>
	    	<img src="${ctp}/images/main/정기배송.png"/>
	    </div>
		  <div class="carousel-item">
		  	<div class="text-left bt" style="position:absolute;top:100px;left:220px;width:800px">
	    		<h1>
		    		부모님께 건강한<br/>
		    		<b>몀품과일 선물세트</b><br/><br/>
	    		</h1>
	    		<h3 class="text-dark">알찬 구성의 리얼후르츠의 명품 과일을 선물하세요.</h3><br/><br/>
    		 <button type="button" class="btn btndefault btn-lg" onclick="location.href='${ctp}/orders/ordersMain?codeSmall=12';">보러가기 > </button>
	    	</div>
	    	<img src="${ctp}/images/main/부모님배너2.jpg"  width="100%" height="600"/>
		   </div>
	   </div>
	   
	     <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#demo" data-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </a>
		  <a class="carousel-control-next" href="#demo" data-slide="next">
		    <span class="carousel-control-next-icon"></span>
		  </a>
	   
	</div>
</div>
<br/><br/><br/>
	<div class="container-fluid" style="width:80%;" >
		<div style="width:100%;height:500px;background-image: url(${ctp}/images/main/메인버튼.jpg);background-size:cover;">
			<table class="table" style="height:500px">
				<tr>
					<td class="table-bordered  td1 text-white" width="45%">
						<h1 class="display-3 text-center">REAL FRUIT BOX</h1><br/>
						<p class="text-right" style="font-size:1.3em">달콤하고 맛있는 나만의 건강간식!<br/>
								제철과일박스를 정기적으로 만나보세요!</p><br/><br/><br/>
						<div class="row rowop">
							<div class="col pl-5">
								<span class="font1">나만의 과일상자</span><br/>
								<span class="font2">과일 정기배송</span>
							</div>
							<div class="col-sm-3">
								<br/>
								<div class="btn btn-lg btn-outline-light" onclick="location.href='${ctp}/subscribe/subscribeMain';">&nbsp;구매하기&nbsp;</div>
							</div>
						</div>		
					</td>
					<td rowspan="2"></td>
				<tr>
				<tr>
					<td class="table-bordered td1 text-white" width="45%">
						<div class="row rowop">
							<div class="col  pl-5">
							<span class="font1">달콤하고 맛있는 리얼후르츠</span><br/>
							<span class="font2">한번구매&선물하기</span></div>
							<div class="col-sm-3">
								<br/>
								<div class="btn btn-lg btn-outline-light" onclick="location.href='${ctp}/orders/ordersMain';">&nbsp;구매하기&nbsp;</div>
							</div>
						</div>		
					</td>
				<tr>
			</table>
  	</div>
  	<br/><br/><br/>
  	<div>
  		<span class="subtitle">단품 추천 | </span> <a href="${ctp}/orders/ordersMain"> 보러가기 </a>
  		<br/>
  		
			<div class="slider" id="slider">
				<div class="slide-track image-box">
					<c:forEach var="vo" items="${vos}">
						<div class="slide bg-light" style="padding:30px;">
							<img src="${ctp}/data/ckeditor/product/${vo.FSName}"  style="width:300px" alt="" />
							<p class="productname pt-2"><b>${vo.name}</b></p>
						</div>
					</c:forEach>
				</div>
  		</div>
  		
  	</div>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
