<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberBucket.jsp</title>
	 <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/resources/js/woo.js"></script>
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
	<script>
		'use strict';
		
		function fCheck(){
			
		    let postcode = myform.postcode.value;
		    let roadAddress= myform.roadAddress.value;
		    let detailAddress = myform.detailAddress.value;
		    let extraAddress = myform.extraAddress.value;
		    if(postcode.trim()==""||roadAddress.trim()==""){
		    	alert("주소를 입력해주세요.");
		    	return;
		    }
		    myform.address.value= postcode+" /"+roadAddress+" /"+detailAddress+" /"+extraAddress;
		    
			myform.submit();
		}
		function getCoupons(){
			let coupons = myform.coupons.value;
			if(coupons.trim()==""){alert("쿠폰 코드를 입력해주세요.");return;}
			
			$.ajax({
				type:"post",
				url : "${ctp}/orders/getCoupons",
				data : {code:coupons},
				success:function(res){
					if(res=="0"){alert("해당하는 코드의 쿠폰이 없습니다.")}
					else {
						let str = res+"원";
						if($("#couponsDetail").html()!="0원"){return;}
						if(Number($(".sumOfPrice").html())<res){alert("총 결제금액보다 쿠폰 사용 금액이 많습니다.");return;}
						$("#couponsDetail").html("-"+str);
						$(".sumOfPrice").html($(".sumOfPrice").html()-res);
						myform.code.value=coupons;
						$("#coupons").attr("readonly",true);
					};
				},
				error : function(){
					alert("전송실패");
				}
			});
		}
		function getPoints(){
			let point = myform.point.value;
			let sumOfPrice = $(".sumOfPrice").html();
			const regNum=/^[0-9]*$/gm;
			if($("#pointDetail").html()!="0원"){return;}
			if(!point.match(regNum)){alert("포인트를 숫자로 입력해주세요.");return;}
			else if(Number(point)>Number(sumOfPrice)){alert("총 결제금액보다 사용 포인트가 많습니다.");return;}
			else if(Number(point)>"${point}"){alert("소유 포인트보다 많은 포인트를 입력하셨습니다.");return;};
			
			let str = point+"원";
			$("#pointDetail").html("-"+str);
			$(".sumOfPrice").html($(".sumOfPrice").html()-point);
			myform.usepoint.value=point;
			$("#point").attr("readonly",true);
			
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid text-center border fadein" style="width:80%" >
	<div class="container-fluid"style="width:80%" >
		<form name="myform" method="post" action="${ctp}/member/ordersOk">
			<div class="row">
				<div class="col-md-6 p-5">
					<table class="table table-borderless">
						<tr class="table-borderless" >
							<th><h4><b>청구 상세 내용</b></h4></th>
						</tr>
						<c:if test="${!empty sMid}">
							<tr>
								<th>아이디 <input type="text" readonly name="mid" value="${sMid}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
							<tr>
								<th>이름 <input type="text" name="name" readonly value="${vo.name}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
							<tr>
								<th>이메일 주소<input type="text" name="email" readonly value="${vo.email}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
						</c:if>
						<c:if test="${empty sMid}">
							<tr>
								<th>이름 <input type="text" name="name" value="${vo.name}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
							<tr>
								<th>이메일 주소<input type="text" name="email" value="${vo.email}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
						</c:if>
						<tr>
							<th>도로명 주소
								<input type="text" name="postcode" id="sample6_postcode" value="${fn:substring(fn:split(vo.address,'/')[0],0,fn:length(fn:split(vo.address,'/')[0])-1)}" style="height:50px" class="bg-light mt-3 form-control"/>
								<input type="text" name="roadAddress" id="sample6_address" size="50" value="${fn:substring(fn:split(vo.address,'/')[1],0,fn:length(fn:split(vo.address,'/')[1])-1)}"  style="height:50px" class="bg-light mt-3 form-control"/>
								<input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:substring(fn:split(vo.address,'/')[2],0,fn:length(fn:split(vo.address,'/')[2])-1)}" style="height:50px" class="bg-light mt-3 form-control"/>
								<input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:substring(fn:split(vo.address,'/')[3],0,fn:length(fn:split(vo.address,'/')[3]))}"  style="height:50px" class="bg-light mt-3 form-control"/>
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"  style="height:50px" class="btn btn-dark mt-3  form-control"/>
							</th>
						</tr>
						<tr>
							<th>전화번호<input type="text" name="tel" value="${vo.tel}" style="height:50px" class="bg-light mt-3 form-control"/></th>
						</tr>
					</table>
				</div>
				<div class="col-md-6 pt-3">
					<h2 class="m-4" style="font-family:ChosunNm">고객님의 주문</h2>
					<div class=" p-5 text-left border" style="width:100%">
						<table class="table table-borderless">
							<tr>
								<th class="text-center"><h4><b>상품</b></h4></th>
								<th class="text-right"><h4><b>총계</b></h4></th>
							</tr>
							<c:forEach var="bucketVo" items="${bucketVos}">
								<tr>
									<td>
										<c:if test="${bucketSw==0}">
											<input type="hidden" name="products"  value="${bucketVo.productIdx}/${bucketVo.optionIdx}/${bucketVo.optionNum}/${bucketVo.optionDetail} /${bucketVo.totalPrice}"/>
										</c:if>
										<c:if test="${bucketSw!=0}">
											<input type="hidden" name="products"  value=""/>
										</c:if>
										<c:if test="${bucketVo.sellSw=='NO'}"><div class="badge badge-danger">판매종료</div></c:if>${bucketVo.name}
										<c:if test="${!empty bucketVo.optionDetail}">
											<br/>
											<img style="width:120px" src="${ctp}/data/ckeditor/product/${bucketVo.FSName}"><br/>
												${bucketVo.optionDetail}
										</c:if>
										${bucketVo.optionName} X ${bucketVo.optionNum}
									</td>
									<td class="text-right">${bucketVo.totalPrice}
									</td>
								</tr>
							</c:forEach>
							<tr class="table-bordred"><td colspan="2"><hr style="border:solid 1px gray"/></td></tr>
							<tr>
								<td>쿠폰</td>
								<td class="text-right">
									<div id="couponsDetail">0원</div>
								</td>
							</tr>
							<tr>
								<td>포인트</td>
								<td class="text-right">
									<div id="pointDetail">0원</div>
								</td>
							</tr>
							<tr>
								<td>배송비</td>
								<td class="text-right">
								  <c:if test="${sumOfPrice<basisVo.deliveryMinPrice}">	${basisVo.deliveryPrice}원</c:if>
								  <c:if test="${sumOfPrice>=basisVo.deliveryMinPrice}">	0원</c:if>
								</td>
							</tr>
							<tr class="table">
								<td><h4><b> 총 결제금액 </b></h4></td>
								<td class="text-right">
									<h4><b>
										<c:if test="${sumOfPrice>=basisVo.deliveryMinPrice}">	<span class="sumOfPrice">${sumOfPrice}</span></c:if>
									  <c:if test="${sumOfPrice<basisVo.deliveryMinPrice}">	<span class="sumOfPrice">${basisVo.deliveryPrice+sumOfPrice}</span></c:if>
								 		 원
									</b></h4>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="btn btn-lg btn-outline-info form-control" onclick="fCheck()">결제하기</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="bg-light p-5 text-left" style="width:100%">
						<h5><b>쿠폰코드</b></h5>
						<input type="text" class="form-control" name="coupons" id="coupons">
						<input type="button" class="btn btn-lg btn-outline-success form-control" value="사용하기" onclick="getCoupons()"/>
					</div>
					<c:if test="${!empty sMid}">
						<div class="bg-light p-5 text-left" style="width:100%">
							<h5><b>가용 포인트&nbsp;&nbsp;&nbsp;</b>(${point}점)</h5>
							<input type="text" class="form-control" name="point" id="point">
							<input type="button" class="btn btn-lg btn-outline-success form-control" value="사용하기" onclick="getPoints()"/>
						</div>
					</c:if>
				</div>
			</div>
			<input type="hidden" name="bucketSw" value="${bucketSw}"/>
			<input type="hidden" name="address"/>
			<input type="hidden" name="code"/>
			<input type="hidden" name="usepoint" />
		</form>
	</div>
</div>
<div style="height:50px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
