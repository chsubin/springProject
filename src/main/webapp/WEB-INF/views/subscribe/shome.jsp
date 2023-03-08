<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
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
		.jb-box:hover {
		  transform: scale( 1.05 );
		  transition: all 0.7s linear;
		}
		.butt:hover {
			background-color:orange;
			transition: all 0.2s linear;
		}

	</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid fadein" style="width:70%">
	<div class="row">
  	<div class="col"><img src="${ctp}/images/정기배송썸네일1.jpg" class="jb-box"></div>
		<div class="col p-3">
	  	<h4 style="font-family:'ChosunNm';font-size:1.4em">집앞까지 찾아가는 정기배송</h4>
	  	<p style="font-size:2em;color:darkblue">Single / Double / Premium</p>
	  	<p style="font-size:1.2em">
	  	고객이 선택한 1:1 맞춤형 과일<br/>
			과일마스터가 엄선한 제철과일을<br/>
			정성스럽게 포장하여,<br/>
			정기적으로 배송해 드립니다.<br/>
	  	</p>
	  	<div class="text-left" style="width:80%">
	  		<h4 class="p-4 mr-5 text-center butt" onclick="location.href='subscribeMain';">&nbsp;&nbsp;&nbsp;주문하기&nbsp;&nbsp;&nbsp;</h4>
	  	</div>
	  </div>
  </div>
</div>  
<div style="height:50px"></div>  
  
  
<div class="container-fluid fadein" style="width:80%">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item" style="width:50%">
      <a class="nav-link active btn btn-outline-light text-dark border" data-toggle="tab" href="#home"><h4>상세</h4></a>
    </li>
    <li class="nav-item"  style="width:50%">
      <a class="nav-link text-center  btn-outline-light text-dark border" data-toggle="tab" href="#menu1"><h4>환불/배송</h4></a>
    </li>
  </ul>
    <!-- Tab panes -->
  <div class="tab-content">
    <div id="home" class="container-fluid tab-pane active text-center"><br>
      ${vo.content}
    </div>
    <div id="menu1" class="container-fluid tab-pane fade border p-5"><br>
      <h5>${fn:replace(basisVo.deliveryDetail, newLine, '<br/>')}</h5>
    </div>
  </div>
</div>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
