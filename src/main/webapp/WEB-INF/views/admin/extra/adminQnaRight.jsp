<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>adminInputProduct.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
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
				  <c:forEach var="vo" items="${qVos}">
				  	<c:if test="${!empty vo.question}">
				  		<div class="pr-5" >
								<div style="border: 1px solid #ddd;border-radius:20px/20px;background-color: #f1f1f1;" class=" shadow-sm fadein mr-5 p-4 m-2">
									<h6><input type="radio"> ${vo.question}</h6>  		
									<h6 >${vo.questionDate}</h6>  		
						  	</div>
					  	</div>
				  	</c:if>
				  	<c:if test="${!empty vo.answer}">
				  		<div class="pl-5">
								<div style="border: 1px solid #ccc;border-radius:20px/20px;background-color: #ddd;" class="shadow-sm fadein ml-5 p-4 m-2">
									<h6> ${vo.answer}</h6>  		
									<h6 class="text-right">${vo.answerDate}</h6> 		
						  	</div>
					  	</div>
				  	</c:if>
				  </c:forEach>
</html>