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
		.badge:hover{
		cursor:pointer;
		}
	 </style>
 <script>
 	'use strict';
 	function selectAll(){
 		$(".chk").prop("checked",true);
 	}
 	function selectReverse(){
	 		if($(".chk").prop("checked")){
	 			$(".chk").prop("checked",false);
	 		}
	 		else{
	 			$(".chk").prop("checked",true);
	 		}
 	}
  	$(function(){
  		$(".detail").hide();
  	});
	function showDetail(){
		if($("#detailBtn").val()=="보기"){$(".detail").slideDown(500);$("#detailBtn").val("닫기")}
		else if($("#detailBtn").val()=="닫기"){$(".detail").slideUp(500);$("#detailBtn").val("보기")}
		
	}
	function fStart(){
		let oIdx = "${vo.idx}";
		
		let ans = confirm("구독을 재개하시겠습니까?");
		if(!ans) return;
		
		$.ajax({
			type:"post",
			url : "${ctp}/subscribe/stopSub",
			data : {oIdx:oIdx,subSw:"OK"},
			success:function(){
				location.reload();
			},
			error : function(){
				location.reload();
			}
			
		});
	}
	function fStop(){
		let oIdx = "${vo.idx}";
		
		let ans = confirm("구독을 정지하시겠습니까?");
		if(!ans) return;
		
		$.ajax({
			type:"post",
			url : "${ctp}/subscribe/stopSub",
			data : {oIdx:oIdx,subSw:"NO"},
			success:function(){
				location.reload();
			},
			error : function(){
				location.reload();
			}
			
		});
	}
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>정기배송 주문 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3">
		<div class="container-fluid p-1 border shadow-sm" style="background-color:#fff">
			<table class="table pb-0 pt-0 mb-0 mt-0 table-borderless">
				<tr onclick="showDetail()">
					<td><h4 >청구 상세내용 확인하기</h4></td>
					<td class="text-right"><input type="button" class="btn btn-outline-dark" value="보기" id="detailBtn" /></td>
				</tr>
			</table>
			<div class="row detail"  >
				<div class="col-md-6 p-5 pt-0">
					<table class="table table-borderless ">
							<tr>
								<th>아이디 <input type="text" readonly name="mid" value="${sMid}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
							<tr>
								<th>이름 <input type="text" name="name" readonly value="${vo.name}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
							<tr>
								<th>이메일 주소<input type="text" name="email" readonly value="${vo.email}" style="height:50px" class="bg-light mt-3 form-control"/></th>
							</tr>
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
					<div class=" p-5 text-left border" style="width:100%">
						<table class="table table-borderless">
							<tr>
								<th class="text-center"><h4><b>상품</b></h4></th>
								<th class="text-right"><h4><b></b></h4></th>
							</tr>
								<tr>
									<td>
										<c:if test="${bucketSw==0}">
											<input type="hidden" name="products"  value="${bucketVo.productIdx}/${bucketVo.optionIdx}/${bucketVo.optionNum}/${bucketVo.optionDetail} /${bucketVo.totalPrice}"/>
										</c:if>
										<c:if test="${bucketSw!=0}">
											<input type="hidden" name="products"  value=""/>
										</c:if>
										${vo.productName}
											<br/>
											<img style="width:120px" src="${ctp}/data/ckeditor/product/${vo.FSName}"><br/>
												${vo.optionDetail}
										${vo.optionName} X ${vo.optionNum}
									</td>
									<td class="text-right">${bucketVo.totalPrice}
									</td>
								</tr>
							<tr class="table-bordred"><td colspan="2"><hr style="border:solid 1px gray"/></td></tr>
							<tr>
								<td>배송비</td>
								<td class="text-right">
								  <c:if test="${vo.totalPrice<basisVo.deliveryMinPrice}">	${basisVo.deliveryPrice}원</c:if>
								  <c:if test="${vo.totalPrice>=basisVo.deliveryMinPrice}">	0원</c:if>
								</td>
							</tr>
							<tr class="table">
								<td><h4><b> 반복 결제 금액 </b></h4></td>
								<td class="text-right">
									<h4><b> 
										<c:if test="${vo.totalPrice>=basisVo.deliveryMinPrice}">	${vo.totalPrice}원</c:if>
									  <c:if test="${vo.totalPrice<basisVo.deliveryMinPrice}">	${basisVo.deliveryPrice+vo.totalPrice}원</c:if>
									</b></h4>
								</td>
							</tr>
						</table>
					</div>
					<div class="p-3 text-center" style="width:100%" >
						<c:if test="${vo.subSw!='OK'}"><input type="button" value="구독재개" class=" btn btn-lg btn-success" onclick="fStart()"></c:if>
						<c:if test="${vo.subSw=='OK'}"><input type="button" value="구독정지" class=" btn btn-lg btn-danger" onclick="fStop()"></c:if>
						<input type="button" value="구독정보수정" class="btn btn-lg btn-warning" onclick="fUpdate()">
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid p-1 mb-3 border shadow-sm" style="background-color:#fff">
			<table class="table table-borderless">
				<tr>
					<td><h4 >정기배송 상품 발송 현황</h4></td>
					<td class="text-right"></td>
				</tr>
			</table>
			
			<div class="m-5">
				<table class="table table-hover table-bordered bg-white">
					<tr class="text-center bg-dark text-white">
						<th>발송일</th>
						<th>상품 구성</th>
						<th>주소</th>
						<th>비고</th>
					</tr>
					<c:if test="${empty subVos}">
						<tr>
							<td colspan="5">
								<h3> 발송내역이 없습니다. </h3>
							</td>
						</tr>
					</c:if>
					<c:forEach var="vo" items="${subVos}">
						<tr  class="text-center">
							<td>${fn:substring(vo.DDate,0,19)}</td>
							<td>${vo.content}</td>
							<td>${vo.address}</td>
							<td></td>
						</tr>
					</c:forEach>
				</table>	
			</div>
		</div>
		
		
		
	</div>
</form>
<p><br/><br/></p>
</body>
</html>