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
		.btnNone {
			color:darkblue;
			border:1px solid gray;
		}
		.btnActive {
			background-color:darkblue;
			color:white;
		}
		.btnNone:hover {
			background-color:darkblue;
			color:white;
		}
		
	</style>
	<script>
		let totalPrice=0;
		
  	function setTotalPrice(){
	  	totalPrice=0;
	  	let sw=0;
	  	for(let i=0;i<document.getElementsByName("optionPrices").length; i++) {
	  		totalPrice+=Number(document.getElementsByName("optionPrices")[i].innerHTML);
	  		sw=1;
	  	}
	  	let point= totalPrice*0.01;
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
	  	if(totalPrice==0)$("#totalPrice").html('');
	  	$("#point").html(numberWithCommas(point));
	  	myform.totalPrice.value=totalPrice;
  	}
  	
  	$(function(){
  		$("#option").change(function(){
  			let str = document.getElementById("orders").innerHTML;
  			let option = $(this).val();
  			if(option=="0") return;
  			let options = option.split("/");
  			let price = Number(options[1])+Number("${vo.price}");
  			let su = $("#ordersOption"+options[0]).val();
  			if(su!=0){alert("이미 선택된 옵션입니다.");return;}
  			str+="<table id='options"+options[0]+"' width='100%' class=' table table-bordered' >"
  			str+="<tr>"
  			str+="<td class='text-left'>"
  			str+="${vo.name}&nbsp;"+options[2]
  			str+="</td>"
  			str+="<td class='text-right'>"
  			str+='<div class="border" style="display:inline-block">';
  			str+='<div class="btn btn-light" onclick="updateNumOfOption('+options[0]+',-1)">-</div>'
  			str+='&nbsp;&nbsp;<span id="numOfOption'+options[0]+'">1</span>&nbsp;&nbsp;'
  			str+='<div class="btn btn-light" onclick="updateNumOfOption('+options[0]+',1)">+</div>'
  			str+='</div>&nbsp;&nbsp;'
  			str+="<span name='optionPrices' id='optionPrice"+options[0]+"' style='width:30%'>"+price+"</span>원&nbsp;"
  			str+='<div class="btn btn-secondary border" onclick="deleteOption('+options[0]+')">X</div>'
  			str+="</td>"
  			str+="</tr>"
  			str+="</table>"
  			$("#orders").html(str);
  			$("#ordersOption"+options[0]).val("1");
  			setTotalPrice();
  		});
  	});
  	function deleteOption(idx){
  		$("#options"+idx).remove();
  		$("#ordersOption"+idx).val("0");
  		setTotalPrice();
  	}
  	function updateNumOfOption(idx,buho) {
  		let su = Number($("#numOfOption"+idx).html())+Number(buho);
  		if(su==0) return false;
			$("#numOfOption"+idx).html(su);
			$("#ordersOption"+idx).val(su);
			let price=$("#ordersOptionPrice"+idx).val();
			price=(Number(price)+Number("${vo.price}"))*su;
			$("#optionPrice"+idx).html(price);
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
	function numberNoCommas(x){
		return x.replace(",","");
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid" style="width:80%">
	<p><br/></p>
	<div class="row mt-2">
		<div class="col pl-5 text-right">
			<img style="width:90%" src="${ctp}/data/ckeditor/product/${vo.FSName}">
		</div>
		<div class="col pr-5 pt-2">
			<h2>${vo.name}</h2>
			<h4>${vo.content}</h4>
			<h3><b><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></b>원</h3>
			<form name="myform" method="post">
				<table class="table table-borderless">
					<tr>
						<td width="20%">판매혜택</td>
						<td>회원적립금: <b>+<span id="point">${vo.point}</span>원</b></td>
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
						<td class="pb-5"><fmt:formatNumber value="${basisVo.deliveryPrice}" pattern="#,##0"/>원/<fmt:formatNumber value="${basisVo.deliveryMinPrice*0.0001}" pattern="#,##0"/>만원 이상 무료배송</td>
					</tr>
					<c:if test="${!empty optionVos}">
						<tr class="border-top">
							<td class="pt-3">옵션 선택 </td>
							<td class="text-right  pt-3">
								<select name="option" id="option" ${vo.sellSw=='NO'?'disabled':''} class="form-control">
									<option value="0">옵션 선택</option>
									<c:forEach var="optionVo" items="${optionVos}">
										<option value="${optionVo.idx}/${optionVo.optionPrice}/${optionVo.optionName}">${optionVo.optionName} / +${optionVo.optionPrice}원</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<c:if test="${vo.sellSw=='NO' }">
							<tr>
								<td colspan="2">
									<h3 class="text-center">판매가 종료된 상품입니다.</h3>
								</td>
							</tr>
						</c:if>
						<tr>
							<td colspan="2">
								<div id="orders"></div>
								<div id="totalPrice"></div>
							</td>
						</tr>
					</c:if>	
				</table>
				<input type="hidden" name="productIdx" value="${vo.idx}"/>
				<c:forEach var="optionVo" items="${optionVos}">
					<input type="hidden" name="optionIdxs" value="${optionVo.idx}"/>
					<input type="hidden" name="optionNums" id="ordersOption${optionVo.idx}" value="0"/>
					<input type="hidden" name="optionPrices" id="ordersOptionPrice${optionVo.idx}" value="${optionVo.optionPrice}"/>
				</c:forEach>
				<input type="hidden" name="totalPrice" />
				<input type="hidden" name="subSw" />
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
