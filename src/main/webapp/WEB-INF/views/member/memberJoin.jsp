<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>memberJoin.jsp</title>
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
		table {
			font-family:'Noto Sans KR', sans-serif;
		}
		.thin {
			font-weight: 300;
		}
	</style>
</head>
<script>
	'use strict';
	$(document).ready(function(){
		  $('[data-toggle="tooltip"]').tooltip();   
		});
	
	//회원가입폼 체크후 서버로 전송(submit) 
	let idFlag=0;
	
	function fCheck(){
    //폼의 유효성 검사~~~
    
    //정규식
    let name = myform.name.value; const nameregx =/^[가-힣]{2,20}$/g;
    let mid = myform.mid.value;const midregx =/^[0-9a-z_]{4,20}$/g;
		let pwd = myform.pwd.value; const pwdregx=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g; 
		//const pwdregx=/^[0-9]{4,20}$/g;
    let tel = myform.tel.value;const regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/gm
    let email1 = myform.email1.value;const emailregx=/^[0-9a-zA-Z]{2,40}/g;
    
    if(!mid.match(midregx)){alert("아이디는 4~20자의 영문소문자,숫자,밑줄만 사용해주세요.");myform.mid.focus();return;}
    else if(!name.match(nameregx)){alert("한글 이름은 2~20자의 한글만 사용해주세요.");myform.name.focus();return;}
    else if(!pwd.match(pwdregx)){alert("비밀번호는 8~20자, 하나이상의 영문 대/소문자,숫자,특수문자를 입력해주세요.");myform.pwd.focus();return;}
    else if(!tel.match(regTel)){alert("전화번호는 형식에 맞추어주세요.(010-0000-0000)");myform.tel.focus();return;}
    else if(!email1.match(emailregx)){alert("이메일은 2~40자의 영문 대/소문자, 숫자만 입력해주세요.");myform.email1.focus();return;}
    else if(myform.pwd.value!=myform.pwdConfirm.value){alert("비밀번호 확인이 일치하지 않습니다.");myform.pwdConfirm.focus();return;}
   	
    
    if(idFlag==0){
        alert("아이디 중복체크를 먼저 해주세요.");return;
    }

		//이메일을 하나로 묶어준다.
    email1 = myform.email1.value;
    let email2 = myform.email2.value;
    myform.email.value= email1+"@"+email2;
    
    //전송전에 '주소를 하나로 묶어서 전송처리'
    let postcode = myform.postcode.value;
    let roadAddress= myform.roadAddress.value;
    let detailAddress = myform.detailAddress.value;
    let extraAddress = myform.extraAddress.value;
    if(postcode.trim()==""||roadAddress.trim()==""){
    	alert("주소를 입력해주세요.");
    	return;
    }
    myform.address.value= postcode+" /"+roadAddress+" /"+detailAddress+" /"+extraAddress;
    
    if(!myform.applyFlag.checked){
    	alert("개인정보 처리방침에 동의해주세요.");
    	return false;
    }
    
    myform.submit();
	}
//공백체크
	function spaceCheck(e){
		let spacecheck = e.value;
		e.value= spacecheck.replace(" ","");
		e.focus();
	}
	
	function idCheck(){
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "" || mid.length<4||mid.length>=20) {
    		alert("아이디를 확인하세요!(아이디는 4~20자 이내)");
    		myform.mid.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/member/memberIdCheck",
    		data : {mid:mid},
    		success: function(res) {
    			if(res=="1"){
    				alert("이미 사용중인 아이디입니다.");
    				$("#mid").focus();
    			}
    			else {
    				alert("사용 가능한 아이디입니다.");
    				idFlag=1;
    			}
    		},
    		error : function(){
    			alert("전송오류!");
    		}
    	});
	}
	
	function idChange(e){
		spaceCheck(e);
		idFlag=0;
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
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container text-center fadein" >
	<div style="height:50px;"></div>
	<form name="myform" method="post" action="memberJoin">
		<table class="table table-borderless form-group" >
			<tr>
				<td colspan="2" class="text-left text-white table-dark pl-2">회원가입 정보</td>
			</tr>
			<tr>
				<td class="pl-2">아이디<font color="red">*</font></td>
				<td>
					<input type="text" name="mid" id="mid" class="form-control bg-light" onkeyup="idChange(this)" style="width:70%;display:inline">
					<input type="button" onclick="idCheck()" class="form-control" value="중복검사" style="width:28%;display:inline" class="btn bg-dark text-white">		
				</td>
			</tr>
			<tr>
				<td class="pl-2">이름<font color="red">*</font></td>
				<td><input type="text" name="name" onkeyup="spaceCheck(this)" id="name" class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">비밀번호<font color="red">*</font> <a href="#" data-toggle="tooltip" title="8~20자 이내 영문/숫자 조합(특수문자 입력 필수)">❓</a></td>
				<td><input type="password" name="pwd" id="pwd" onkeyup="spaceCheck(this)" class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">비밀번호 확인<font color="red">*</font></td>
				<td><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="spaceCheck(this)" class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">우편번호 검색<font color="red">*</font></td>
				<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 검색" class="brn btn-dark"></td>
			</tr>
			<tr>
				<td class="pl-2">주소<font color="red">*</font></td>
				<td><input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="도로명 주소"  class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">상세주소<font color="red">*</font></td>
				<td>
					<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control bg-light" style="width:70%;display:inline">
					<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control bg-light" style="width:29%;display:inline">
				</td>
			</tr>
			<tr>
				<td class="pl-2">우편번호<font color="red">*</font></td>
				<td><input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">연락처<font color="red">*</font></td>
				<td><input type="text" id="tel" name="tel" onkeyup="spaceCheck(this)" class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">성별</td>
				<td>
				<input type="radio" id="gender1" name="gender" value="남자" checked>남자 &nbsp;&nbsp;
				<input type="radio" id="gender2" name="gender" value="여자">여자
				</td>
			</tr>
			<tr>
				<td class="pl-2">생일</td>
				<td><input type="date" name="birthday" id="birth" value="2000-01-01"  class="form-control bg-light"></td>
			</tr>
			<tr>
				<td class="pl-2">이메일 주소<font color="red">*</font></td>
				<td>
					<input type="text" name="email1" value="${empty param.email?'':fn:split(param.email,'@')[0]}" <c:if test="${!empty param.email}">readonly</c:if> id="email1" class="form-control bg-light" value="${param.email}" onkeyup="spaceCheck(this)" style="width:33%;display:inline"> 
					@<input type="text" name="email2" value="${empty param.email?'':fn:split(param.email,'@')[1]}" <c:if test="${!empty param.email}">readonly</c:if> id="email2" class="form-control bg-light" onkeyup="spaceCheck(this)"  style="width:32%;display:inline">
					<select name="email3" id="email3" class="form-control bg-light" style="width:32%;display:inline" onchange="fEmailChange()" >
						<c:if test="${empty param.email}">
							<option value="직접입력" >직접입력</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gmail.com" >gmail.com</option>
							<option value="hanmail.net" >hanmail.net</option>
						</c:if>
						<c:if test="${!empty param.email}">
							<option value="${fn:split(param.email,'@')[1]}">${fn:split(param.email,'@')[1]}</option>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td class="pl-2">수신동의</td>
				<td><input type="checkbox" class="bg-light"  name="receiveSw" value="OK"> <span class="thin">SMS,이메일 수신동의</span></td>
			</tr>
			<tr>
				<td colspan="2" class="p-5">
					<div class="mt-5 border thin" style="width:100%;height:500px;overflow:auto">
						<jsp:include page="/WEB-INF/views/include/apply.jsp"></jsp:include>
					</div><br/>
				<hr/>
				<input type="checkbox" name="applyFlag" value="applyFlag"/> <span class="thin">위 이용약관 및 개인정보 처리방침을 읽고 동의합니다.</span>
				<hr/>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="회원가입" onclick="fCheck()" class="btn btn-dark btn-lg">
				</td>
			</tr>
		</table>
		<input type="hidden" name="email">
		<input type="hidden" name="address">
	</form>
</div>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
