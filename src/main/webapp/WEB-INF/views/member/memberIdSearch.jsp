<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
		input {
			font-family:'Noto Sans KR', sans-serif;
			font-weight: 300;
		}
	</style>
	<script>
		'use strict';
		function fPwdCheck(){
			let code = myform.code.value;
			if(code==""){alert("인증코드를 입력하세요.");return;}
			else if (code=="${sImsiPwd}") myform.submit();
			else alert("인증코드를 틀리셨습니다.");
		}
		
		
		function fMidSearch(){
			let name = myform.name.value;
			let email = myform.email1.value;
			
			if(name.trim()==""){
				alert("이름을 입력해주세요.");
				return;
			}
			else if(email.trim()==""){
				alert("이메일주소를 입력해주세요.");
				return;
			}
			$.ajax({
				type:"post",
				url:"${ctp}/member/memberMidSearch",
				data:{name:name,email:email},
				success:function(res){
					if(res=="0") alert("입력하신 정보가 존재하지 않습니다.");
					else {
						$('#searchRes1').html(res)
						$('#myModal1').modal();
					}
				},
				error:function(){
					alert("전송오류");
				}
			});
			
		}
		function fPwdSearch(){
			let mid = myform.mid.value;
			let email = myform.email2.value;
			if(mid.trim()==""){
				alert("아이디를 입력해주세요.");
				return;
			}
			else if(email.trim()==""){
				alert("이메일주소를 입력해주세요.");
				return;
			}
			Swal.fire({
				title : "정보 조회 중",
				text : "입력하신 정보로 인증번호를 발급중입니다.",
				icon : "warning"
			});
			$.ajax({
				type:"post",
				url:"${ctp}/member/memberPwdSearch",
				data:{mid:mid,email:email},
				success:function(res){
					if(res=="0") alert("입력하신 정보가 존재하지 않습니다.");
					else {
						location.reload();
					}
				},
				error:function(){
					alert("전송오류");
				}
			});
			
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container fadein">
	<form name="myform" method="post" action="${ctp}/member/memberImsiPwdUpdate">
	  <div class="border" style="width:60%;margin:0 auto" >
		  <br/>
		  <ul class="nav justify-content-center">
		    <li class="nav-item">
		      <a class="nav-link border btn-outline-secondary" data-toggle="pill" href="#menu1">&nbsp;&nbsp; 아이디 찾기 &nbsp;&nbsp;</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link active border btn-outline-secondary" data-toggle="pill" href="#home">&nbsp;&nbsp; 비밀번호 초기화 &nbsp;&nbsp;</a>
		    </li>
		  </ul>
		  <div class="tab-content">
		    <div id="menu1" class="container-fluid p-0 m-0 tab-pane fade"><br>
					<table class="table table-borderless form-group" >
						<tr>
							<td class="pl-5 pr-5  pb-3"><input type="text" name="email1" id="email1" placeholder=" 이메일주소 " value="" class="form-control bg-light" style="height:50px"></td>
						</tr>
						<tr>
							<td class="pl-5 pr-5 pb-3"><input type="text" name="name" id="name" placeholder=" 이름 " class="form-control bg-light" style="height:50px"></td>
						</tr>
						<tr>
							<td class="pl-5 pr-5 pb-3">
								<button type="button" onclick="fMidSearch()" class="btn form-control text-white" style="height:50px;background-color:darkblue">
									아이디 찾기
								</button>
							</td>
						<tr>
						</tr>
						<tr>
							<td class="text-center bg-light pt-4 pb-5" style="color:darkblue">
								<a href="${ctp}/memberIdSearch"><i class='bx bx-key'></i> 로그인페이지로 돌아가기</a>
							</td>
						</tr>
					</table>
				</div>
		  	<div id="home" class="container tab-pane active"><br>
					<table class="table table-borderless form-group" >
						<tr>
							<td class="pl-5 pr-5  pb-3"><input type="text" name="mid" id="mid" placeholder=" 아이디 " value="" class="form-control bg-light" style="height:50px"></td>
						</tr>
						<tr>
							<td class="pl-5 pr-5 pb-3"><input type="text" name="email2" id="email2" placeholder=" 이메일주소 " class="form-control bg-light" style="height:50px"></td>
						</tr>
						<c:if test="${!empty sImsiPwd}">
						<tr>
							<td class="pl-5 text-center">
									인증번호 <input type="text" name="code" id="code" placeholder=" 인증번호를 입력하세요. " class="bg-light" style="height:50px">
									<input type="button" class="btn btn-outline-success btn-lg" value="입력" onclick="fPwdCheck()"  class="bg-light" style="height:50px">
							</td>					
						</tr>
						</c:if>
						<tr>
							<td class="pl-5 pr-5 pb-3">
								<button type="button" onclick="fPwdSearch()" class="btn form-control text-white" style="height:50px;background-color:darkblue">
									인증번호 발송
								</button>
							</td>
						<tr>
						</tr>
						<tr>
							<td class="text-center bg-light pt-4 pb-5" style="color:darkblue">
								<a href="${ctp}/member/memberLogin"><i class='bx bx-key'></i> 로그인페이지로 돌아가기</a>
							</td>
						</tr>
					</table>
		    </div>
	   </div>
	  </div>
	  <input type="hidden" name="imsiMid" value="${sImsiMid}"/>
	</form>
</div>

  <!-- The Modal -->
  <div class="modal" id="myModal1">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">아이디 찾기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          입력하신 정보로 찾은 아이디는 <font color="blue"><span id="searchRes1"></span></font>입니다.
      	</div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  <!-- The Modal -->
  <div class="modal" id="myModal2">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 초기화</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          입력하신 이메일로 임시코드를 발송했습니다.
          인증코드를 입력해주세요.
      	</div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>



<div style="height:50px;"></div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
