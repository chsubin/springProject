<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>businessMain.jsp</title>
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
	<script>
		'use strict';
		
		function fCheck(){
			let name = myform.name.value; const nameregx =/^[가-힣]{2,20}$/g;
			let tel = myform.tel.value;const regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/gm
			let email = myform.email.value;
			let comname = myform.comname.value;
			let content =myform.content.value;
			
			if(!name.match(nameregx)){alert("이름은 2~20자의 한글로 입력해주세요.");myform.name.focus();return;}
			else if(!tel.match(regTel)){alert("전화번호는 형식에 맞추어주세요.(010-0000-0000)");myform.tel.focus();return;}
			else if(email.length<2||email.length>40){alert("이메일은 2~40자로 입력해주세요.");myform.email.focus();return;}
			else if(comname.trim()=="") {alert("회사이름을 입력해주세요.");myform.comname.focus();return;}
			else if(content.trim()=="") {alert("내용을 입력해주세요.");myform.content.focus();return;}
			else if(!myform.okay.checked){alert("개인정보 제공에 동의해주세요.");return;}
			else if("${sLevel}"!=3){alert("기업회원만 가능합니다.");return;}
			myform.submit();
			
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<img src="${ctp}/images/main/비즈몰1.jpg" style="width:100%" class="fadein"/>
<div class="text-center fadein" style="position:absolute;top:300px;right:780px">
	<h4 class="text-left">|기업제휴 신청하기|</h4><br/>
	<h1 class="pt-5">
		대한민국 1% 명인의 과일, <br/><br/>
		<b><font color="darkblue">친환경 농가</font>와 비즈니스를 <font color="red">함께</font>합니다.</b><br/><br/><br/>
	</h1>
</div>
<div class="container-fluid text-center fadein" style="width:100%" >
<p><br/></p>
	<div class="container-fluid " style="width:60%">
		<form name="myform" method="post">
			<div class="row mt-5">
				<div class="col-md-6 text-center" >
					<h2 class="mt-5 mb-5 pt-5" style="font-family:'Noto Sans KR', sans-serif;font-weight:300"><b>어떤 과일을 재배하는 농가이신가요?</b></h2>
					<h2 style="font-family:'Noto Sans KR', sans-serif;font-weight:300">제휴 기업 상담신청서를 작성해주세요.</h2>
					<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
					<h4 class="text-center">기업제휴 문의
					<hr/>
					1566-1212
					</h4>
				</div>
				<div class="col-md-6">
					<table class="table bg-white" style="border:1px solid #ccc">
						<tr class="table table-borderless"><td colspan="2" class=" p-3 pl-5"><h3><b>기업제휴 상담신청서</b></h3>
							<c:if test="${sLevel!=3}"><font color="red">* 기업회원으로 로그인하셔야 제출가능합니다.</font></c:if>
							</td>
						</tr>
						<tr  class="table table-borderless">
							<td rowspan="4"  class="p-3 pl-5"><h6>연락정보</h6></td>
							<td  class="p-3"><input type="text" placeholder="성함" value="${vo.name}" name="name"  class="form-control borderless p-3"></td>
						</tr>
						<tr>
							<td class="p-3"><input type="text"  placeholder="회사(기관)명" value="${vo.comname}" name="comname"  class="form-control p-3"></td>
						</tr>
						<tr>
							<td  class="p-3"><input type="text" placeholder="전화번호(예시 :010-1234-5678)" value="${vo.tel}" name="tel" class="form-control p-3"></td>
						</tr>
						<tr>
							<td  class="p-3"><input type="text" placeholder="이메일(예시:busineess@bestf.co.kr)" value="${vo.email}" name="email" class="form-control p-3"></td>
						</tr>
						<tr  class="table table-borderless">
							<td rowspan="3"  class="p-3 pl-5"><h6>상담정보</h6></td>
							<td class="p-3">
								<select class="form-control" name="part">
									<option>농가 제휴 신청</option>
								</select>
								</td>
						</tr>
						<tr>
							<td class="p-3">
								<textarea rows="5" class="form-control" name="content" placeholder="상담내용을 적어주세요."></textarea>
							</td>
						</tr>
						<tr>
							<td class="p-3">
								<input type="checkbox" name="okay" id="okay" value="okay"/>개인정보 수집/이용에 동의*
							</td>
						</tr>
						<tr>
							<td class="p-3" colspan="3">
								<input type="button" class="btn btn-lg btn-success form-control" value="제출하기" onclick="fCheck()"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" name="mid" value="${sMid}"/>
		</form>
	</div>
	<div class='bg-light mt-5'>
		<div class="" style="width:90%;height:800px;margin: 0 auto">
			<h3 class="text-left p-5">전국 협력 제휴농가</h3>
			<div class="row">
				<div class="col-md-8">
					<div id="map" style="width:100%;height:600px;"></div>
				</div>
				<div class="col-md-4">
					<div style="width:100%;height:600px;overflow:auto">
						<h5><font color="red">*이미지를 클릭하여 브랜드 스토리를 확인하세요.</font></h6>
						<table class="table bg-white">
							<c:forEach var="joinvo" items="${joinVos}">
								<tr>
									<td><img src="${ctp}/data/ckeditor/adjoins/${joinvo.FSName}" style="width:100px" data-toggle="modal" data-target="#myModal${joinvo.idx}"/></td>
									<td>${joinvo.comname}</td>
									<td>${joinvo.tel}
										<!-- The Modal -->
										<div class="modal fade" id="myModal${joinvo.idx}">
										  <div class="modal-dialog modal-xl">
										    <div class="modal-content">
										    
										      <!-- Modal Header -->
										      <div class="modal-header">
										        <h4 class="modal-title">브랜드 스토리</h4>
										        <button type="button" class="close" data-dismiss="modal">&times;</button>
										      </div>
										      
										      <!-- Modal body -->
										      <div class="modal-body text-center">
										        ${joinvo.memo}
										      </div>
										      
										      <!-- Modal footer -->
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
										      </div>
										      
										    </div>
										  </div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div style="height:50px;"></div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c&libraries=services"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91755d6e69519d43f059b293cab99a32&libraries=services"></script>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(35.62611229068307, 127.43940550292956), // 지도의 중심좌표
	        level:13 // 지도의 확대 레벨
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
		
	
		<c:forEach var="joinVo" items="${joinVos}">
		
	    marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng("${joinVo.latitude}", "${joinVo.longitude}") 
	    });
	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">${joinVo.comname}</div>');
	        infowindow.open(map, marker);
	        alert("${joinVo.idx}");
	    });
	    
	    var iwContent = '<div style="padding:5px;font-size:12px">${joinVo.comname}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new kakao.maps.LatLng("${joinVo.latitude}", "${joinVo.longitude}"), //인포윈도우 표시 위치입니다
	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			// 인포윈도우를 생성하고 지도에 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
			    map: map, // 인포윈도우가 표시될 지도
			    position : iwPosition, 
			    content : iwContent,
			    removable : iwRemoveable
			});
	    
    </c:forEach>
	
	
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
	</script>


</body>
</html>
