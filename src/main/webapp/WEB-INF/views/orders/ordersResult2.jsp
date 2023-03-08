<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberBucket.jsp</title>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid text-center" style="width:80%" >
	<div class="container-fluid border">
		  <h2 class="text-left p-5" style="font-family:'ChosunNm'">결제 정보</h2>
			  <table class="table border">
			    <tr>
			      <th>주문자</th>
			      <td><input type="text" name="buyer_name" value="${ovo.name}" class="form-control"/></td>
			    </tr>
		  		<tr>
			      <th>이메일</th>
			      <td><input type="text" name="buyer_email" value="${ovo.email}" class="form-control"/></td>
			    </tr>
			    <tr>
			      <th>연락처</th>
			      <td><input type="text" name="buyer_tel" value="${ovo.tel}" class="form-control"/></td>
			    </tr>
			    <tr>
			      <th>주소</th>
			      <td><input type="text" name="buyer_addr" value="${ovo.address}" class="form-control"/></td>
			    </tr>
			  </table>
	  	<c:forEach var="vo" items="${orderVos}">
			  <table class="table border">
				    <tr>
				      <th>결제 금액</th>
				      <td><input type="number" name="amount" value="${vo.totalPrice}" class="form-control"/></td>
				    </tr>
				    <tr>
				      <th>구매 물품</th>
				      <td>
				      	<input type="text" name="name" value="${vo.productName}" class="form-control"/>
				      	<img style="width:120px" src="${ctp}/data/ckeditor/product/${vo.FSName}">
				      </td>
				    </tr>
			  </table>
	    </c:forEach>
		  <p class="text-center">
		    <a href="${ctp}/study/merchant" class="btn btn-success">계속쇼핑하기</a>
		  </p>
	</div>
</div>
<div style="height:50px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
