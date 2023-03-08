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
 	
	function fCheck(){
	    //전송전에 '주소를 하나로 묶어서 전송처리'
	    let postcode = myform.postcode.value;
	    let roadAddress= myform.roadAddress.value;
	    let detailAddress = myform.detailAddress.value;
	    let extraAddress = myform.extraAddress.value;
	    if(postcode.trim()==""||roadAddress.trim()==""){
	    	alert("주소를 입력해주세요.");
	    	return;
	    }
	    myform.comaddress.value= postcode+" /"+roadAddress+" /"+detailAddress+" /"+extraAddress;		
	    
	    let photo = myform.photo.value;
	    if(photo==""){
	    	alert("사진을 입력해주세요.");
	    	return;
	    }
	    
	    myform.submit();
	}
 	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>제휴농가 등록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 border-bottom text-center border-left border-right shadow-sm" style="background-color:#fff">
		<div class="pl-5 pr-5 mr-5 ml-5">
			<form name="myform" method="post" enctype="multipart/form-data">
				<table class="table" >
					<tr>
						<th class="bg-light" width="13%"> 아이디 </th>
						<td><input type="text" name="mid" class="form-control" <c:if test="${!empty vo.mid}">readonly</c:if> value="${vo.mid}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 이메일 </th>
						<td><input type="email" name="email" class="form-control" value="${vo.email}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 농가 대표 사진 </th>
						<td><input type="file" name="photo" class="form-control-file" ></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 이름 </th>
						<td><input type="text" name="name" class="form-control" value="${vo.name}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 법인명 </th>
						<td><input type="text" name="comname" class="form-control" value="${vo.comname}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 연락처 </th>
						<td><input type="text" name="tel" class="form-control" value="${vo.tel}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 업종 </th>
						<td><input type="text" name="compart" class="form-control" value="${vo.compart}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%"> 상담 신청 내용 </th>
						<td><input type="text" name="content" class="form-control" value="${vo.content}"></td>
					</tr>
					<tr>
						<th class="bg-light" width="13%">설명 등록</th>
						<td>
							<textarea rows="30" name="memo"  id="CKEDITOR" class="form-control" required>${vo.memo}</textarea></td>
			        <script>
			        	CKEDITOR.replace("memo",{
			        		height : 500,
			        		filebrowserUploadUrl:"${ctp}/imageUpload",
			        		uploadUrl : "${ctp}/imageUpload"
			        	});
			        </script>
						</td>
					</tr>
					<tr>
						<c:set var="address" value="${fn:split(vo.comaddress,'/')}"/>
					  <c:set var="postcode" value="${address[0]}"/>
					  <c:set var="roadAddress" value="${address[1]}"/>
					  <c:set var="detailAddress" value="${address[2]}"/>
					  <c:set var="extraAddress" value="${address[3]}"/>
						<th rowspan="4" class="bg-light" width="13%"> 주소 </th>
						<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 검색" class="brn btn-dark"></td>
						<tr>
							<td><input type="text" name="roadAddress" id="sample6_address" value="${fn:substring(roadAddress,0,roadAddress.length()-1)}" size="50" placeholder="도로명 주소"  class="form-control bg-light"></td>
						</tr>
						<tr>
						<td>
							<input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:substring(detailAddress,0,detailAddress.length()-1)}" placeholder="상세주소" class="form-control bg-light" style="width:70%;display:inline">
							<input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="form-control bg-light" style="width:29%;display:inline">
						</td>
						</tr>
						<tr>
							<td><input type="text" name="postcode" id="sample6_postcode" value="${fn:substring(postcode,0,postcode.length()-1)}" placeholder="우편번호" class="form-control bg-light"></td>
						</tr>
						<tr>
						<th class="bg-light" width="13%"> 지도 등록 </th>
						<td>
							<table class="table">
								<tr>
									<td colspan="4"><input type="text" name="search" class="form-control" placeholder="검색어를 입력하세요." id="search"/></td>
								</tr>
								<tr>
									<th>위도</th>
									<td><input type="text" name="latitude" value="${vo.latitude}" class="form-control"  id="lat"/></td>
									<th>경도</th>
									<td><input type="text" name="longitude"  value="${vo.longitude}" class="form-control" id="lng"/></td>
								</tr>
							</table>
							<hr/>
							<div id="map" style="width:100%;height:600px;"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="등록하기" class=" btn btn-success" onclick="fCheck()">
							<input type="reset" value="다시쓰기" class="btn btn-warning">
						</td>
					</tr>
				</table>
				<input type="hidden" name="idx" value="${param.idx}"/>
				<input type="hidden" name="comaddress" value=""/>
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

	var latitude = 126.9786567;
	var longitude = 37.566826;
	var marker =""
	
	
	if("${vo.latitude}"!=""){
		latitude = "${vo.latitude}";
		longitude = "${vo.longitude}";
	}
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	    mapOption = {
	        center: new kakao.maps.LatLng( latitude, longitude), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	var map = new kakao.maps.Map(mapContainer, mapOption); 

	var ps = new kakao.maps.services.Places(); 

	
  	$(function(){
  		$("#search").change(function(){
  			var search=$("#search").val();
  			ps.keywordSearch(search, placesSearchCB);
  		});
  	});
    marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng("${vo.latitude}", "${vo.longitude}") 
    });
	
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

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