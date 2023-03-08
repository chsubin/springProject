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
 <script>
 	'use strict';
 	let str2='';
 	let idx="";
 	
  	$(function(){
  		$("#codeLarge").change(function(){
  			let codeLarge = $(this).val();
  			$.ajax({
  				type : "post",
  				url : "${ctp}/admin/product/catogory",
  				data : {codeLarge:codeLarge},
  				success : function(smallVos){
  					let str='/ 소분류 : <select name="codeSmall" id="codeSmall" value=""><option>분류 선택</option>';
  					for(let i=0;i<smallVos.length;i++){
  						if(smallVos==null) break;
	  					str +='<option value="'+smallVos[i].codeSmall+'">'+smallVos[i].smallName+'</option>';
  					}
  					str +='</select>';
  					$("#str").html(str);
  				},
  				error : function(){
  				}
  			});
  		});
  	});
  	function createCode(){
  	 	let codeLarge = myform.codeLarge.value;
  		if(codeLarge==""){alert("대분류를 선택하세요.");return;}
  		let codeSmall = myform.codeSmall.value;
  		if(codeSmall=="분류 선택"){alert("소분류를 선택하세요.");return;}
  		let str ="";
  		if(codeLarge==1)str+="A";
  		else if(codeLarge==2)str+="B";
  		else if(codeLarge==3)str+="C";
  		if(codeSmall<10) {str+=0+codeSmall}
  		else str+=codeSmall;
  		str+="-"+"${strIdx}";
  		myform.code.value=str;
  	}
 
  	function optionPlus(optionIdx){
  		idx = optionIdx;
  		idx++;
  		str2 = $("#options").html();
  		str2 += '<span id="optionIdx'+idx+'"><br/><b>옵션'+idx+' | </b> 옵션이름 : <input class="form-control" style="display:inline;width:30%" type="text" name="optionName" id="optionName'+idx+'"> , ';
  		str2 += '옵션가격 : <input class="form-control" style="display:inline;width:30%" type="text" name="optionPrice" id="optionPrice'+idx+'"></span>';
  		$("#options").html(str2);
  		optionsBtn(idx);
  	};
  	
  	function optionDelete(optionIdx){
  		idx = optionIdx;
  		$("#optionIdx"+optionIdx).remove();
  		idx--;
  		optionsBtn(idx);
  	}
  	
  	function optionsBtn(idx){
  		let str3 = '<div class="btn btn-outline-info" onclick="optionPlus('+idx+')"> + </div>';
  		if(idx!=1){
  			str3 += '<div class="btn btn-outline-danger" onclick="optionDelete('+idx+')"> - </div>';
  		}
  		$("#optionsBtn").html(str3);
  	}
  	//상품 등록 유효성 검사
  	function fCheck(){
  		let codeLarge = myform.codeLarge.value;
  		if(codeLarge=="") {alert("대분류를 선택해주세요.");return;}
  		let codeSmall = myform.codeSmall.value;
  		let code = myform.code.value; 
  		let name = myform.name.value;
  		let content = myform.content.value;
  		let detail = myform.content.value;
  		let point = myform.point.value; const regNum=/^[0-9]*$/gm;
  		let contry = myform.contry.value;
  		let selloption = myform.selloption.value;
  		let delivery = myform.delivery.value;
  		let deliveryPrice = myform.deliveryPrice.value;
  		let fileName = myform.fileName.value;
  		let price = myform.price.value;
  		if(codeSmall=="분류 선택"){alert("소분류를 선택하세요.");return;}
  		else if(code.trim()=="") {alert("상품코드를 생성해주세요.");return;}
  		else if(name.trim()=="") {alert("상품이름을 입력해주세요.");return;}
  		else if(content.trim()=="") {alert("상품 간단 설명을 입력해주세요.");return;}
  		else if(detail.trim()=="") {alert("상품 상세 설명을 입력해주세요.");return;}
  		else if(!point.match(regNum)) {alert("포인트를 숫자로 입력해주세요.");return;}
  		else if(contry.trim()=="") {alert("원산지를 입력해주세요.");return;}
  		else if(selloption.trim()=="") {alert("판매단위를 입력해주세요.");return;}
  		else if(delivery.trim()=="") {alert("배송방법을 입력해주세요.");return;}
  		else if(!deliveryPrice.match(regNum)) {alert("배송비를 숫자로 입력해주세요.");return;}
  		else if(fileName.trim()=="") {alert("상품 사진을 입력해주세요.");return;}
  		else if(!price.match(regNum)) {alert("상품가격을 숫자로 입력해주세요.");return;}
  		
  		myform.submit();
  	}
  	
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-5">
	<nav class="navbar navbar-expand-sm border" style="background-color:#fff">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="adminInputProduct"><h4 class="p-0 m-0">상품등록</h4></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="adminUpdateProduct">| 상품수정</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="adminProductList">| 상품조회</a>
	    </li>
	  </ul>
	</nav>
	<div class="container-fluid p-5 border-bottom border-left border-right" style="background-color:#fff">
		<form name="myform" method="post" enctype="multipart/form-data" >
			<table class="table">
				<tr>
					<th class="bg-light" width="13%"> 상품분류 </th>
					<td>
						대분류 : 
						<select name="codeLarge" id="codeLarge">
							<option value="">분류 선택</option>
							<c:forEach var="largeVo" items="${largeVos}">
								<option value="${largeVo.codeLarge}">${largeVo.largeName}</option>
							</c:forEach>
						</select> 
							<span id="str">
							</span>
					</td>
				</tr>
				<tr>
					<th class="bg-light"> 상품코드 </th>
					<td>
						<input type="text" name="code" id="code" readonly style="width:80%;display:inline" class="form-control">
						<input type="button" class="btn btn-dark" value="생성" style="width:18%" onclick="createCode()" />
					</td>
				</tr>
				<tr>
					<th class="bg-light"> 상품제목 </th>
					<td><input type="text" name="name" id="name" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품간단설명 </th>
					<td><input type="text" name="content" id="content" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품상세설명 </th>
					<td>
						<textarea rows="30" name="detail"  id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
		        <script>
		        	CKEDITOR.replace("detail",{
		        		height : 500,
		        		filebrowserUploadUrl:"${ctp}/imageUpload",
		        		uploadUrl : "${ctp}/imageUpload"
		        	});
		        </script>
				</tr>
				<tr>
					<th class="bg-light"> 구매혜택(포인트) </th>
					<td><input type="number" name="point" id="point"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 원산지 </th>
					<td><input type="text" name="contry" id="contry"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 판매단위 </th>
					<td><input type="text" name="selloption" id="selloption" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 배송방법 </th>
					<td><input type="text" name="delivery" id="delivery" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 배송비 </th>
					<td><input type="number" name="deliveryPrice" id="deliveryPrice" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품사진(썸네일) </th>
					<td><input type="file" name="fileName" id="fileName"  class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light"> 상품가격 </th>
					<td><input type="text" name="price" name="price" class="form-control"></td>
				</tr>
				<tr>
					<th class="bg-light">상품옵션</th>
					<td>
						<b>옵션1 | </b> 옵션이름 : <input class="form-control" style="display:inline;width:30%" type="text" name="optionName" id="optionName1" readonly> , 
						옵션가격 : <input class="form-control" style="display:inline;width:30%" type="text" name="optionPrice" id="optionPrice1" readonly> 
						<span id="options"></span>
						<span id="optionsBtn"><span class="btn btn-outline-info" onclick="optionPlus(1)"> + </span></span>	
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><br/><br/>
						<input type="button" value="상품등록" onclick="fCheck()"  class="btn btn-warning">
						<input type="button" value="다시쓰기"  class="btn btn-secondary">
					</td>
				</tr>
			</table>
			<input type="hidden" name="productIdx" value="${productIdx}"/>
		</form>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>