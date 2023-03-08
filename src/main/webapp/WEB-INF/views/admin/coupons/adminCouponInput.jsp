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
 	
 	function sendMail(){
 		let toMail = myform.toMail.value;
 		let photo = myform.photo.value;
 		let title = myform.title.value;
 		let content = myform.content.value;
 		
 		if(photo.trim()==""){alert("쿠폰을 선택해주세요.");return;}
 		else if(toMail.trim()==""){alert("메일 주소를 입력해주세요.");return;}
 		else if(title.trim()==""){alert("메일 제목을 입력해주세요.");return;}
 		else if(content.trim()==""){alert("메일 내용을 입력해주세요.");return;}
 		
 		let query = {toMail:toMail,photo:photo,title:title,content:content};
 		
 		$.ajax({
 			type:"post",
 			url: "${ctp}/admin/coupons/adminCouponSend",
 			data : query,
 			success : function(res){
 				if(res==1)alert("메일을 보냈습니다.");
 				else alert("메일 주소를 확인하세요.");
 			},
 			error : function(){
 				alert("메일 전송 실패");
 			}
 		});
 	}
 	
 	
 	function fInput(){
 		let name =myform.name.value;
 		let price = myform.price.value;
 		let startDate = myform.startDate.value;
 		let lastDate = myform.lastDate.value;
	 	
	 	$.ajax({
			type:"post",
			url:"${ctp}/admin/coupons/adminCouponsInput",
			data : {name:name,price:price,startDate:startDate,lastDate:lastDate},
			success: function(){location.reload();},
			error: function(){alert("실패");}
	 	});
 	}
 	
    function jusorokView() {
    	$("#myModal").on("show.bs.modal", function(e){
    		$(".modal-header #cnt").html(${cnt});
    		let jusorok = '';
    		jusorok += '<table class="table table-hover">';
    		jusorok += '<tr class="table-dark text-dark text-center">';
    		jusorok += '<th>번호</th><th>아이디</th><th>성명</th><th>메일주소</th>';
    		jusorok += '</tr>';
    		jusorok += '<c:forEach var="vo" items="${memberVos}" varStatus="st">';
    		jusorok += '<tr onclick="setEmail(\'${vo.email}\');" class="text-center">';
    		jusorok += '<td>${st.count}</td>';
    		jusorok += '<td>${vo.mid}</td>';
    		jusorok += '<td>${vo.name}</td>';
    		jusorok += '<td>${vo.email}</td>';
    		jusorok += '</tr>';
    		jusorok += '</c:forEach>';
    		jusorok += '';
    		jusorok += '</table>';
    		$(".modal-body #jusorok").html(jusorok);
    	});
    }
    
    function setEmail(email){
    	myform.toMail.value=email;
    }
    function setCoupons(fSName){
    	myform.photo.value=fSName;
    }
    
    function couponDelete(idx,fSName){
    	let ans = confirm("삭제하신 쿠폰은 복구되지 않습니다. 정말로 삭제하시겠습니까?");
    	
    	if(!ans) return;
    	
    	$.ajax({
    		type:"post",
   			url :"couponDelete",
   			data :{idx:idx,fSName:fSName},
   			success:function(){alert("쿠폰을 삭제하였습니다.");location.reload()},
   			error:function(){alert("전송오류 ㅜ")}
    	});
    }
 </script>
</head>
<body class="bg-light">
	<form name="myform" >
		<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
			<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>쿠폰 발급</b></h2></div>
			<div class="col">
				<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
			</div>
		</div>
		<div class="container-fluid  p-3 row">
		<!-- 	<nav class="navbar navbar-expand-sm border" style="background-color:#fff">
			  <ul class="navbar-nav">
			    <li class="nav-item active">
			      <a class="nav-link" href="adminInputProduct">상품등록 |</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="adminUpdateProduct">상품수정 |</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="adminProductList"><h4 class="p-0 m-0"> 상품조회</h4></a>
			    </li>
			  </ul>
			</nav> -->

			<div class="container-fluid p-2 m-3 border shadow-sm col" style="background-color:#fff">
				<table class="table" style='width:95%;margin:0 auto'>
					<tr class="table-borderless">
						<td colspan="4">
							<h2>쿠폰리스트</h2>
						</td>
						<tr class="text-center">
							<th>구분</th>
							<th>쿠폰이름</th>
							<th>가격</th>
							<th>사용시작일</th>
							<th>만료일</th>
							<th>사용일</th>
						</tr>
						<c:forEach var="vo" items="${vos}">
							<tr class="text-center">
								<td>
									<input type="radio" name="coupons" onclick="setCoupons('${vo.FSName}')"/> 
									<img src="${ctp}/data/ckeditor/coupons/${vo.FSName}.png" data-toggle="modal" data-target="#myModal${vo.idx}" style="width:50px" >
									<!-- 주소록을 Modal로 출력하기 -->
								<div class="modal fade" id="myModal${vo.idx}" style="width:680px">
									<div class="modal-dialog modal-sm">
									  <div class="modal-content">
									  	<div class="modal-header">
									  		<h4 class="modal-title"> QR 코드 </h4>
									  		<button type="button" class="close" data-dismiss="modal">&times;</button>
									  	</div>
									  	<div class="modal-body">
									  		<img src="${ctp}/data/ckeditor/coupons/${vo.FSName}.png">
									  		<h4>${vo.FSName}.png&nbsp;&nbsp;
									  			<c:if test="${vo.useSw!='NO'}"> 
									  				<div class="btn btn-danger" onclick="couponDelete('${vo.idx}','${vo.FSName}')">삭제하기</div>
									  			</c:if>
									  			</h4>
									  	</div>
									  	<div class="modal-footer" >
									  		<button type="button" class="close btn-danger" data-dismiss="modal">Close</button>
									  	</div>
									  </div>
									</div>
								</div>
								</td>
								<td>${vo.name}</td>
								<td>${vo.price}</td>
								<td>${fn:substring(vo.startDate,0,10)}</td>
								<td>${fn:substring(vo.lastDate,0,10)}</td>
								<td>
									<c:if test="${vo.useSw!='NO'}">
										<font color="red">미사용</font>
									</c:if>
									<c:if test="${!empty vo.useDate}">
									${fn:substring(vo.useDate,0,10)}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
					<p><br/></p>
					<!-- 페이지네이션 -->
					<div class="text-center">
					  <ul class="pagination justify-content-center">
					    <c:if test="${pageVo.pag > 1}">
					      <li class="page-item"><a class="page-link text-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=1">첫페이지</a></li>
					    </c:if>
					    <c:if test="${pageVo.curBlock > 0}">
					      <li class="page-item"><a class="page-link text-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}">이전블록</a></li>
					    </c:if>
					    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
					      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
					    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
					    	</c:if>
					      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
					    		<li class="page-item"><a class="page-link text-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=${i}">${i}</a></li>
					    	</c:if>
					    </c:forEach>
					    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
					      <li class="page-item"><a class="page-link text-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}">다음블록</a></li>
					    </c:if>
					    <c:if test="${pageVo.pag < pageVo.totPage}">
					      <li class="page-item"><a class="page-link text-secondary" href="adminCouponInput?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}">마지막페이지</a></li>
					    </c:if>
					  </ul>
					</div>
					
			</div>
				<div class="col" >
					<div class="container-fluid  p-2 mt-3 mr-3 border shadow-sm" style="background-color:#fff">
						<h2 style="width:95%;margin:0 auto" class="m-3">쿠폰 발급하기</h2>
				    <table class="table table-bordered" style="width:95%;margin:0 auto">
				      <tr>
				        <th>쿠폰 이름</th>
				        <td>
				          <input type="text" name="name" placeholder="쿠폰 이름을 입력해주세요." class="form-control" required />
				        </td>
				      </tr>
				      <tr>
				        <th>쿠폰 가격</th>
				        <td><input type="number" name="price" placeholder="쿠폰 가격을 입력하세요." class="form-control" required/></td>
				      </tr>
				      <tr>
				        <th>쿠폰 사용 기간</th>
				        <td>
				        	<div class="row">
				        		<div class="col-sm-5">
				        			<input type="text" name="startDate" placeholder="쿠폰 사용 시작일" class="form-control" required/>
				        		</div>
				        		<div class="col-sm-2 text-center">
				        			~
				        		</div>
				        		<div class="col-sm-5">
				        			<input type="text" name="lastDate" placeholder="쿠폰 만료일" class="form-control" required/>
				        		</div>
				        	</div>
				        </td>
				      </tr>
				      <tr>
				        <td colspan="2" class="text-center">
				          <input type="button" value="쿠폰발급" class="btn btn-success" onclick="fInput()"/>
				          <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
				          <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-warning"/>
				        </td>
				      </tr>
				    </table>
					</div>
					<div class="container-fluid  p-2 mt-3 mr-3 border shadow-sm" style="background-color:#fff">
						<h2 class="m-3">메일로 쿠폰 보내기</h2>
				    <table class="table table-bordered">
				      <tr>
				        <th>보낼쿠폰</th>
				        <td>
				          <div class="row">
					          <div class="col-10"><input type="text" name="photo"  placeholder="쿠폰 리스트에서 쿠폰을 선택해주세요." class="form-control" required /></div>
				          </div>
				        </td>
				      </tr>
				      <tr>
				        <th>받는사람</th>
				        <td>
				          <div class="row">
					          <div class="col-10"><input type="text" name="toMail" value="" placeholder="받는사람 메일주소를 입력하세요." class="form-control" required /></div>
					          <div class="col-2"><input type="button" value="주소록" onclick="jusorokView()" class="btn btn-info form-control" data-toggle="modal" data-target="#myModal" /></div>
				          </div>
				        </td>
				      </tr>
				      <tr>
				        <th>메일제목</th>
				        <td><input type="text" name="title" placeholder="메일 제목을 입력하세요." class="form-control" required/></td>
				      </tr>
				      <tr>
				        <th>메일내용</th>
				        <td><textarea rows="7" name="content" class="form-control" required></textarea></td>
				      </tr>
				      <tr>
				        <td colspan="2" class="text-center">
				          <input type="button" value="메일보내기" class="btn btn-success" onclick="sendMail()"/>
				          <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
				          <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-warning"/>
				        </td>
				      </tr>
				    </table>
					</div>
		</div>
	</form>
	<!-- 주소록을 Modal로 출력하기 -->
<div class="modal fade" id="myModal" style="width:680px">
	<div class="modal-dialog">
	  <div class="modal-content" style="width:600px">
	  	<div class="modal-header" style="width:600px">
	  		<h4 class="modal-title">☆ 주 소 록 ☆</h4>
	  		<button type="button" class="close" data-dismiss="modal">&times;</button>
	  	</div>
	  	<div class="modal-body" style="width:600px;height:400px;overflow:auto;">
	  		<span id="jusorok"></span>
	  	</div>
	  	<div class="modal-footer" style="width:600px">
	  		<button type="button" class="close btn-danger" data-dismiss="modal">Close</button>
	  	</div>
	  </div>
	</div>
</div>
</body>
</html>