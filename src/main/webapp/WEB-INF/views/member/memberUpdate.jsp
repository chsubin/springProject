<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		.cli{
			cursor:pointer;
		}
	</style>
	<script>
	 'use strict';
	 
	 function fCheck(){
			 
	    //정규식
	    let name = myform.name.value; const nameregx =/^[가-힣]{2,20}$/g;
	    let tel = myform.tel.value;const regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/gm
	    let email1 = myform.email1.value;const emailregx=/^[0-9a-zA-Z]{2,40}/g;
	    
	    if(!name.match(nameregx)){alert("한글 이름은 2~20자의 한글만 사용해주세요.");myform.name.focus();return;}
	    else if(!tel.match(regTel)){alert("전화번호는 형식에 맞추어주세요.(010-0000-0000)");myform.tel.focus();return;}
	    else if(!email1.match(emailregx)){alert("이메일은 2~40자의 영문 대/소문자, 숫자만 입력해주세요.");myform.email1.focus();return;}
		 
	    

		//이메일을 하나로 묶어준다.
    email1 = myform.email1.value;
    let email2 = myform.email2.value;
    myform.email.value= email1+"@"+email2;
	    
	    let postcode = myform.postcode.value;
	    let roadAddress= myform.roadAddress.value;
	    let detailAddress = myform.detailAddress.value;
	    let extraAddress = myform.extraAddress.value;
	    if(postcode.trim()==""||roadAddress.trim()==""){
	    	alert("주소를 입력해주세요.");
	    	return;
	    }
	    myform.address.value= postcode+" /"+roadAddress+" /"+detailAddress+" /"+extraAddress;
	    
	    if("${sLevel}"==3){
			    let comnumber = myform.comnumber.value;const regComnumber=/^[0-9]{3}-[0-9]{2}-[0-9]{5}$/gm;
	        let comname = myform.comname.value;
	        let owner = myform.owner.value;
	        let compart = myform.compart.value;
	        if(comname.length==0||comname.length>50){
	        	alert("법인명을 입력해주세요");
	        	return;
	        }
	        else if(owner.length==0||owner.length>50){
	        	alert("대표자를 입력해주세요");
	        	return;
	        }
	        else if(compart.length==0||compart.length>50){
	        	alert("업종을 입력해주세요");
	        	return;
	        }
	        else if(!comnumber.match(regComnumber)){alert("사업자번호는 형식에 맞추어주세요.(000-00-00000)");myform.comnumber.focus();return;}
	    }
	    myform.submit();
	    
	 }
		function fEmailChange(){
			let semail = myform.email3.value;
			if(semail!='직접입력'){
				myform.email2.value=semail;
			}
			else {
				myform.email2.value="";
			}
		}
	</script>
</head>
<body>
<div class="container-fluid " style="width:80%;" >
	<div class="row bg-light" >
		<div class="col-md-4 border shadow bg-white" style="height:100vh" >
			<jsp:include page="memberMenu.jsp"/>
		</div>
		<div class="col-md-8 fadein" style="overflow:auto;height:100vh">
			<h3 class="p-5"><b>내 정보</b></h3>	
			<div class=" bg-white shadow p-5">
				<form name="myform" method="post">
					<table class="table table-borderless form-group" >
						<tr>
							<td class="pl-2">구분<font color="red">*</font></td>
							<td>
								<input type="radio" ${vo.level==2 ? 'checked' : ''} disabled> 개인회원
								<input type="radio" ${vo.level==3 ? 'checked' : ''} disabled> 기업회원
							</td>
						</tr>
						<tr>
							<td class="pl-2">이름<font color="red">*</font></td>
							<td><input type="text" name="name" id="name" value="${vo.name}" class="form-control bg-light"></td>
						</tr>
						<tr>
							<td class="pl-2">우편번호 검색<font color="red">*</font></td>
							<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 검색" class="brn btn-dark"></td>
						</tr>
						<tr>
							<c:set var="address" value="${fn:split(vo.address,'/')}"/>
						  <c:set var="postcode" value="${address[0]}"/>
						  <c:set var="roadAddress" value="${address[1]}"/>
						  <c:set var="detailAddress" value="${address[2]}"/>
						  <c:set var="extraAddress" value="${address[3]}"/>
							<td class="pl-2">주소<font color="red">*</font></td>
							<td><input type="text" name="roadAddress" value="${fn:substring(roadAddress,0,roadAddress.length()-1)}" id="sample6_address" size="50"  class="form-control bg-light"></td>
						</tr>
						<tr>
							<td class="pl-2">상세주소<font color="red">*</font></td>
							<td>
								<input type="text" name="detailAddress" value="${fn:substring(detailAddress,0,detailAddress.length()-1)}" id="sample6_detailAddress" placeholder="상세주소" class="form-control bg-light" style="width:70%;display:inline">
								<input type="text" name="extraAddress" value="${extraAddress}" id="sample6_extraAddress" placeholder="참고항목" class="form-control bg-light" style="width:29%;display:inline">
							</td>
						</tr>
						<tr>
							<td class="pl-2">우편번호<font color="red">*</font></td>
							<td><input type="text"  value="${fn:substring(postcode,0,postcode.length()-1)}"  name="postcode" id="sample6_postcode" class="form-control bg-light"></td>
						</tr>
						<tr>
							<td class="pl-2">연락처<font color="red">*</font></td>
							<td><input type="text" id="tel" value="${vo.tel}" name="tel" class="form-control bg-light"></td>
						</tr>
						<c:if test="${sLevel!=3}">  <!-- 개인회원 -->
							<tr>
								<td class="pl-2">성별</td>
								<td>
								<input type="radio" id="gender1" name="gender" value="남자" ${vo.gender=='남자' ? 'checked' : ''} checked>남자 &nbsp;&nbsp;
								<input type="radio" id="gender2" name="gender" value="여자" ${vo.gender=='여자' ? 'checked' : ''}> 여자
								</td>
							</tr>
							<tr>
								<td class="pl-2">생일</td>
								<td><input type="date" name="birthday" id="birth" value="2000-01-01"  class="form-control bg-light"></td>
							</tr>
						</c:if>
						<c:if test="${sLevel==3}">  <!-- 개인회원 -->
							<tr>
								<td class="pl-2">법인명</td>
								<td><input type="text" id="comname" value="${vo.comname}" name="comname" class="form-control bg-light"></td>
							</tr>
							<tr>
								<td class="pl-2">사업자번호</td>
								<td><input type="text" id="number" value="${vo.comnumber}" name="comnumber" class="form-control bg-light"></td>
							</tr>
							<tr>
								<td class="pl-2">대표자</td>
								<td><input type="text" id="owner" value="${vo.owner}" name="owner" class="form-control bg-light"></td>
							</tr>
							<tr>
								<td class="pl-2">업종</td>
								<td><input type="text" id="compart" value="${vo.compart}" name="compart" class="form-control bg-light"></td>
							</tr>
						</c:if>
						<tr>
							<td class="pl-2">이메일 주소<font color="red">*</font></td>
							<td>
							  <c:set var="emails" value="${fn:split(vo.email,'@')}"/>
							  <c:set var="email1" value="${emails[0]}"/>
							  <c:set var="email2" value="${emails[1]}"/>
								<input type="text" name="email1" id="email1" value="${email1}" class="form-control bg-light" onkeyup="spaceCheck(this)" style="width:30%;display:inline"> 
								@<input type="text" name="email2" id="email2" value="${email2}" class="form-control bg-light" onkeyup="spaceCheck(this)"  style="width:30%;display:inline">
								<select name="email3" id="email3" class="form-control bg-light" style="width:30%;display:inline" onchange="fEmailChange()">
									<option value="직접입력">직접입력</option>
								 	<option value="naver.com" <c:if test="${email2=='naver.com'}">selected</c:if> >naver.com</option>
									<option value="daum.net"  <c:if test="${email2=='daum.net'}">selected</c:if> >daum.net</option>
									<option value="gmail.com" <c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
									<option value="hanmail.net" <c:if test="${email2=='hanmail.net'}">selected</c:if>>hanmail.net</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="pl-2">수신동의</td>
							<td><input type="checkbox" class="bg-light"  name="receiveSw" ${vo.receiveSw=='OK' ? 'checked' : ''} value="OK"> <span class="thin">SMS,이메일 수신동의</span></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="수정하기" onclick="fCheck()" class="btn btn-dark btn-lg">
								<input type="reset" value="다시쓰기" class="btn btn-outline-dark btn-lg">
							</td>
						</tr>
					</table>
					<input type="hidden" name="mid" value="${sMid}"/>
					<input type="hidden" name="address"  />
					<input type="hidden" name="level" value="${sLevel}" />
					<input type="hidden" name="email"/>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
