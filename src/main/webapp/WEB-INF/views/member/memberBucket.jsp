<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberBucket.jsp</title>
	 <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
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
	</style>
	<script>
		'use strict';
		function deleteSelect(){
			let deleteboxes ='';
			for(let i=0;i<myform.deleteBox.length;i++){
				if(myform.deleteBox[i].checked){
					deleteboxes+=myform.deleteBox[i].value+"/";
				}
			}
			if(deleteboxes=="") return false;
			$.ajax({
				type:"post",
				url:"${ctp}/member/deleteBucket",
				data:{deleteboxes:deleteboxes},
				success:function(){
					location.reload();
				},
				error:function(){
					location.reload();
				}
			});
		}
		function deleteAll(){
			let ans =confirm("장바구니에 선택된 상품을 모두 삭제하시겟습니까?");
			if(!ans) return false;
			let deleteboxes ='';
			for(let i=0;i<myform.deleteBox.length;i++){
				deleteboxes+=myform.deleteBox[i].value+"/";
			}
			$.ajax({
				type:"post",
				url:"${ctp}/member/deleteBucket",
				data:{deleteboxes:deleteboxes},
				success:function(){
					location.reload();
				},
				error:function(){
					location.reload();
				}
			});
		}
		
		function bucketUpdate(idx,optionNum,price,buho){
			if(buho==-1&&optionNum==1){
				return;
			}
			$.ajax({
				type:"post",
				url:"${ctp}/member/updateBucket",
				data:{idx:idx,price:price,buho:buho},
				success:function(){
					location.reload();
				},
				error:function(){
					location.reload();
				}
			});
		}
			
			function getCoupons(){
				let coupons = myform.coupons.value;
				if(coupons.trim()==""){alert("쿠폰 코드를 입력해주세요.");return;}
				
				$.ajax({
					type:"post",
					url : "${ctp}/member/getCoupons",
					data : {code:coupons},
					success:function(res){
						if(res=="0"){alert("이미 만료된 쿠폰입니다.")}
						else if(res=="1"){alert("해당하는 코드의 쿠폰이 없습니다.")}
						else {
							let reses = res.split("/");
							Swal.fire({
								title : reses[3],
								text : reses[0]+"원\n "+"(사용 기간 "+reses[1].substring(0,10)+"~"+reses[2].substring(0,10)+")",
								icon : "warning"
							});
						};
					},
					error : function(){
						alert("전송실패");
					}
				});
			}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid text-center " style="width:80%" >
	<div class="container-fluid border">
		<form name="myform">
			<div class="row">
				<div class="col-md-8">
					<table class="table">
						<tr class="table-borderless" >
							<td colspan="5" class="p-5">
								<h1 style="display:inline"></h1>&nbsp;&nbsp;
								<input type="button" value="선택삭제" onclick="deleteSelect()"  class="btn btn-lg border btn-light"/>
								<input type="button" value="전체삭제" onclick="deleteAll()"  class="btn btn-lg border btn-light"/>
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
									<input type="checkbox" class="chk" name="deleteBox" value="${vo.idx}"/>&nbsp;<br/>
									<img style="width:120px" src="${ctp}/data/ckeditor/product/${vo.FSName}">
								</td>
								<td>${vo.name}<c:if test="${vo.sellSw=='NO'}"><div class="badge badge-danger">판매종료</div></c:if> <br/><br/>${vo.optionName}
								 <br/><br/>${vo.optionDetail}
								</td>
								<td class="text-center"><fmt:formatNumber value="${vo.price+vo.optionPrice}" pattern="#,##0"/></td>
								<td class="text-center">
									<c:if test="${empty vo.optionDetail}">
									  <div class="border" style="display:inline-block">
	  								<div class="btn btn-light" onclick="bucketUpdate(${vo.idx},${vo.optionNum},${vo.price+vo.optionPrice},-1)">-</div>
	  									${vo.optionNum}
	  								<div class="btn btn-light" onclick="bucketUpdate(${vo.idx},${vo.optionNum},${vo.price+vo.optionPrice},1)">+</div>
	  								</div>
  								</c:if>
									<c:if test="${!empty vo.optionDetail}">
	  									${vo.optionNum}
  								</c:if>
								</td>
								<td class="text-center"><fmt:formatNumber value="${vo.totalPrice}" pattern="#,##0"/></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="col-md-4 pt-3"><br/><br/><br/>
					<h2 class="m-4" style="font-family:ChosunNm">장바구니 총계</h2>
					<div class="bg-light p-5 text-left" style="width:100%">
						<table class="table table-borderless">
							<tr>
								<td>구독상품</td>
								<td class="text-right">${sub}개</td>
							</tr>
							<tr>
								<td>반복합계</td>
								<td class="text-right"><fmt:formatNumber value="${subPrice}" pattern="#,##0"/>원</td>
							</tr>
							<tr class="table-bordered">
								<td colspan="2" class="m-0 p-0"></td>
							</tr>
							<tr>
								<td>상품</td>
								<td class="text-right"><fmt:formatNumber pattern="#,##0" value="${sumOfOptionNum}"/>개</td>
							</tr>
							<tr>
								<td>배송비</td>
								<td class="text-right">
								  <c:if test="${sumOfPrice<basisVo.deliveryMinPrice}"><fmt:formatNumber pattern="#,##0" value="${basisVo.deliveryPrice}"/>원</c:if>
								  <c:if test="${sumOfPrice>=basisVo.deliveryMinPrice}">	무료</c:if>
								</td>
							</tr>
							<tr>
								<td>총결제금액</td>
								<td class="text-right"><h3>
								  <c:if test="${sumOfPrice<basisVo.deliveryMinPrice}"><fmt:formatNumber pattern="#,##0" value="${basisVo.deliveryPrice+sumOfPrice}"/>원</c:if>
								  <c:if test="${sumOfPrice>=basisVo.deliveryMinPrice}"><fmt:formatNumber pattern="#,##0" value="${sumOfPrice}"/>원</c:if>
								</h3></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="btn btn-lg btn-outline-info form-control" onclick="location.href='${ctp}/member/memberOrders?sw=bucket'">결제하기</div>
								</td>
							</tr>
						</table>
					</div>
					<h2 class="m-4" style="font-family:ChosunNm">쿠폰 조회</h2>
					<div class="bg-light p-5 text-left" style="width:100%">
						<h5><b>쿠폰코드</b></h5>
						<input type="text" id="coupons" class="form-control">
						<input type="button" class="btn btn-lg btn-outline-success form-control" value="조회하기" onclick="getCoupons()" />
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<div style="height:50px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
