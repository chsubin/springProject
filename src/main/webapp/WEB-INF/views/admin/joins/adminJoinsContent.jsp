<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>adminInputProduct.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
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

 	function joinProductInput(idx){
 		let productName = myform.productName.value;
 		let productUnit = myform.productUnit.value;
 		
 		if(productName.trim()==""){alert("상품 이름을 작성해주세요.");return;}
 		else if(productUnit.trim()==""){alert("상품 단위를 작성해주세요.");return;}
 		
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/joins/adminJoinProductInput",
 			data : {joinsIdx:idx,productName:productName,productUnit:productUnit},
 			success:function(){location.reload()},
 			error:function(){alert("상품등록 실패")}
 		});
 		
 	}
 	function productUpdate(idx){
 		let optionName = $("#optionName"+idx).val();
 		let optionPrice = $("#optionPrice"+idx).val();
 		if(optionName.trim()==""||optionPrice.trim()==""){alert("빈칸을 입력해주세요.");return;}
 		
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/joins/adminJoinsProductUpdate",
 			data : {idx:idx,productName:optionName,productUnit:optionPrice},
 			success:function(){alert("수정되었습니다.");location.reload()},
 			error : function(){alert("수정 실패")}
 		});
 	} 
 	function productDelete(idx){
 		let ans = confirm("선택하신 상품을 삭제하시겠습니까?");
 		if(!ans) return;
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/joins/adminJoinsProductDelete",
 			data : {idx:idx},
 			success:function(){alert("삭제되었습니다.");location.reload()},
 			error : function(){alert("삭제 실패")}
 		});
 	}
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>제휴농가 상세정보</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border-bottom text-center border-left border-right shadow-sm" style="background-color:#fff">
		<div class="">
			<form name="myform" method="post">
				<div class="row">
					<div class="col-md-2">
						<img style="width:100%" src="${ctp}/data/ckeditor/adjoins/${vo.FSName}">
						<div class="btn btn-warning form-control" onclick="location.href='adminJoinsInput?idx=${vo.idx}'">수정하기</div>
						<div class="btn btn-danger form-control" onclick="location.href='adminJoinsExit?idx=${vo.idx}'">제휴종료</div>
					</div>
					<div class="col-md-7">
						<table class="table">
							<tr class="text-center">
								<tr>
									<th>아이디</th>
									<td>${vo.mid}</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${vo.email}</td>
								</tr>
								<tr>
									<th>대표자</th>
									<td>${vo.name}</td>
								</tr>
								<tr>
									<th>법인명</th>
									<td>${vo.comname}</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td>${vo.tel}</td>
								</tr>
								<tr>
									<th>업종</th>
									<td>${vo.compart}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>${vo.comaddress}</td>
								</tr>
								<tr>
									<td colspan="2">
										<table style="width:100%">
											<tr>
												<td>등록된 거래상품</td>
												<td>
													<c:forEach var="optionVo" items="${productVos}">
														상품 이름 : <input type="text" value="${optionVo.productName}" name="optionName${optionVo.idx}" id="optionName${optionVo.idx}" style="display:inline;width:30%"  class="form-control"/>,
														상품 단위:<input type="text" value="${optionVo.productUnit}" name="optionPrice${optionVo.idx}" id="optionPrice${optionVo.idx}" style="display:inline;width:30%" class="form-control" />
														<input type="button" value="수정" class="btn btn-warning" onclick="productUpdate(${optionVo.idx})"/>
														<input type="button" value="삭제" class="btn btn-danger" onclick="productDelete(${optionVo.idx})" />
														<br/>
													</c:forEach>
												</td>
											</tr>
											<tr>
												<td>거래상품 추가하기</td>
												<td>
													상품 이름 : <input type="text" name="productName" id="optionName" style="display:inline;width:30%"  class="form-control"/>,
													상품 단위 :<input type="text" name="productUnit" id="optionPrice" style="display:inline;width:30%" class="form-control" />
													<input type="button" value="등록" class="btn btn-success" onclick="joinProductInput(${vo.idx})"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>
						</table>
					</div>
					<div class="col-md-3">
						<div id="map" style="width:100%;height:500px;"></div>
						<h4> 위치도 </h4>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>

	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c&libraries=services"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91755d6e69519d43f059b293cab99a32&libraries=services"></script>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng("${vo.latitude}", "${vo.longitude}"), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 

	
  	$(function(){
  		$("#search").change(function(){
  			var search=$("#search").val();
  			ps.keywordSearch(search, placesSearchCB);
  		});
  	});

	var marker =""
    marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng("${vo.latitude}", "${vo.longitude}") 
    });
	
	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}

	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	        alert(place.place_name);
			    $("#lat").val(place.y);
			    $("#lng").val(place.x);
	    });
	}
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    $("#lat").val(latlng.getLat());
	    $("#lng").val(latlng.getLng());
	    
	});
	</script>