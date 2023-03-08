<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		<form>
			<div class="row">
				<div class="col-sm-6">
					<table class="table">
						<tr class="table-borderless" >
							<td colspan="5" class="p-5">
								<h1 style="display:inline"><input type="checkbox" value=""/> </h1>&nbsp;&nbsp;
								<input type="button" value="선택삭제" class="btn btn-lg border btn-light"/>
								<input type="button" value="전체삭제" class="btn btn-lg border btn-light"/>
							</td>
						</tr>
						<tr class="text-center">
							<td colspan="2">상품</td>
							<td>가격</td>
							<td>수량</td>
							<td>총계</td>
						</tr>
						<c:forEach var="vo" items="${vos}">
							<tr>
								<td>
									<input type="hidden" name="products" value="${vo.productIdx}/${vo.optionIdx}/${optionPrice}/${vo.totalPrice}/${vo.optionNum}"/>
									<input type="checkbox" value=""/>&nbsp;<br/>
									<img style="width:150px" src="${ctp}/data/ckeditor/product/${vo.FSName}">
								</td>
								<td class="p-5">${vo.name}<br/><br/>${vo.optionName}
								 <br/><br/>${vo.optionDetail}
								</td>
								<td class="text-center p-5"><fmt:formatNumber pattern="#,##0" value="${vo.price+vo.optionPrice}"/></td>
								<td class="text-center p-5">${vo.optionNum}</td>
								<td class="text-center p-5"><fmt:formatNumber pattern="#,##0" value="${vo.totalPrice}"/></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="col-sm-4"><input type="submit" value="주문"/>
				</div>
			</div>
		</form>
</div>
<div style="height:30px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
