<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
		.btna {
			background-color:darkblue;
		}

	</style>
	<script>
		'use strict';
		let totalPrice=0;
		let idx=0;
		
	/*   	function setTotalPrice(){
		  	totalPrice=0;
		  	let sw=0;
		  	for(let i=0;i<document.getElementsByName("optionPrices").length; i++) {
		  		totalPrice+=Number(document.getElementsByName("optionPrices")[i].innerHTML);
		  		sw=1;
		  	}
		  	let point = totalPrice*0.01;
		  	alert(point);
		  	let str='';
		  	str+='<div class="mt-2" style="width:100%">';
		  	str+='<h3 class="p-3 text-right">총 합계금액 : <b>'+totalPrice+"</b>원</h3>";
		  	str+='</div>';
		  	$("#totalPrice").html(str);
		  	if(totalPrice==0)$("#totalPrice").html('');
		  	$("#point").html(point);
		  	myform.totalPrice.value=totalPrice;
	  	} */
		
		
		
		function optionInput(optionIdx,optionName,optionPrice){
			idx++;
			let detailoption = myform.detailoption.value;
			if(detailoption.length<3){
				alert("필수입력칸을 3자 이상으로 채워주세요");return;
			}
			let str ="";
			let price = Number(optionPrice)+Number("${vo.price}");
			str+="<table id='options"+idx+"' width='100%' class='table-bordered' >"
			str+="<tr>"
			str+="<td class='text-left'>"
			str+="${vo.name}&nbsp;"+optionName;
			str+=" / 알레르기 과일 : "+detailoption;
			str+="</td>"
			str+="<td class='text-right'>"
			str+='<div class="border" style="display:inline-block">';
			str+='</div>&nbsp;&nbsp;'
			str+="<span name='optionPrices' id='optionPrice"+idx+"' style='width:30%'>"+price+"</span>원&nbsp;"
			str+='<div class="btn btn-secondary border" onclick="deleteOption('+idx+')">X</div>'
			str+='<input type="hidden" name="optionDetails" value="'+detailoption+'"/>';
			str+='<input type="hidden" name="optionIdxs" value="'+optionIdx+'"/>';
			str+='<input type="hidden" name="optionPricess" value="'+optionPrice+'"/>';
			str+="</td>"
			str+="</tr>"
			str+="</table>"
			$("#orders").append(str);
			setTotalPrice();
		}
	  	function setTotalPrice(){
		  	totalPrice=0;
		  	let sw=0;
		  	for(let i=0;i<document.getElementsByName("optionPrices").length; i++) {
		  		totalPrice+=Number(document.getElementsByName("optionPrices")[i].innerHTML);
		  		sw=1;
		  	}
		  	let point = totalPrice*0.01;
		  	let str='';
		  	str+='<div class="mt-2" style="width:100%">';
		  	str+='<h3 class="p-3 text-right">총 합계금액 : <b>'+numberWithCommas(totalPrice)+"</b>원</h3>";
		  	str+='</div>';
		  	str+='<div class="mt-2 row" style="width:100%">';
		  	str+= '<div class="col p-3">'
		  	str+='<h2 class="btn btna form-control btn-lg" style="background-color:darkblue;color:white;height:50px" onclick="fCheck(1)">장바구니</h2>'
		  	str+= '</div>'
		  	str+= '<div class="col p-3">'
		  	str+='<h2 class="btn btna form-control btn-lg" style="background-color:darkblue;color:white;height:50px" onclick="fCheck(2)">바로구매</h2>'
		  	str+= '</div>'
		  	str+='</div>';
		  	$("#totalPrice").html(str);
		  	$("#point").html(numberWithCommas(point));
		  	if(totalPrice==0)$("#totalPrice").html('');
		  	myform.totalPrice.value=totalPrice;
	  	}
	  	function deleteOption(idx){
	  		$("#options"+idx).remove();
	  		setTotalPrice();
	  	}
		
	  	function fCheck(sw){
	  		myform.subSw.value=sw;
	  		myform.submit();
	  	}

		// 천단위마다 쉼표처리
	    function numberWithCommas(x) {
	      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid" style="width:80%">
	<div class="row mt-2">
		<div class="col text-right">
			<img style="width:90%" src="${ctp}/data/ckeditor/product/${vo.FSName}">
		</div>
		<div class="col pt-2">
			<h2>${vo.name}</h2>
			<h3><b><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></b>원</h3>
			<form name="myform" method="post">
				<table class="table table-borderless">
					<tr>
						<td width="30%">판매혜택</td>
						<td>회원적립금: <b>+<span id="point">${vo.point}</span></b></td>
					</tr>			
					<tr>
						<td>원산지</td>
						<td>${vo.contry}</td>
					</tr>			
					<tr>
						<td>판매단위</td>
						<td>${vo.selloption}</td>
					</tr>			
					<tr>
						<td>배송방법</td>
						<td>${vo.delivery}</td>
					</tr>			
					<tr>
						<td class="pb-5">배송비</td>
						<td class="pb-5">${vo.deliveryPrice}원/4만원 이상 무료배송</td>
					</tr>
					<tr class="border-top">
						<td class="pt-3">알레르기 과일<b>(필수)</b></td>
						<td class="text-right  pt-3">
							<input type="text" name="detailoption" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>배송 주기</td>
						<td>
							<c:forEach var="optionVo" items="${optionVos}">
								<input type="radio" name="option" onclick="optionInput('${optionVo.idx}','${optionVo.optionName}','${optionVo.optionPrice}')" value="${optionVo.idx}">${optionVo.optionName} &nbsp;&nbsp;&nbsp;
							</c:forEach> 
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="orders"></div>
							<div id="totalPrice"></div>
						</td>
					</tr>
				</table>
				<input type="hidden" name="productIdx" value="${vo.idx}"/>
				<input type="hidden" name="totalPrice" />
				<input type="hidden" name="subSw" value="0" />
				<input type="hidden" name="mid" value="${sMid}" />
			</form>
		</div>
	</div>
  <p><br/></p>
  <div class="container-fluid">
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
      ${vo.detail}
    </div>
    <div id="menu1" class="container-fluid tab-pane fade border p-5"><br>
      <h5>${fn:replace(basisVo.deliveryDetail, newLine, '<br/>')}</h5>
    </div>
  </div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
