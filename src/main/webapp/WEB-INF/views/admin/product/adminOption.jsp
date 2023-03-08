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
 	function optionUpdate(idx){
 		let optionName= $("#optionName"+idx).val();
 		let optionPrice= $("#optionPrice"+idx).val();
 		if(optionName.trim()==""||optionPrice.trim()==""){
 			alert("빈칸을 입력해주세요.")
 			$("#optionName"+idx).focus();
 		};
 		
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/product/optionUpdate",
 			data:{idx:idx,optionName:optionName,optionPrice:optionPrice},
 			success:function(){alert("수정되었습니다.");location.reload();},
 			error:function(){location.reload()}
 		});
 	}
 	function optionInput(productIdx){
 		let optionName= $("#optionName").val();
 		let optionPrice= $("#optionPrice").val();
 		if(optionName.trim()==""||optionPrice.trim()==""){
 			alert("빈칸을 입력해주세요.")
 			$("#optionName").focus();
 		};
 		
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/product/optionInput",
 			data:{productIdx:productIdx,optionName:optionName,optionPrice:optionPrice},
 			success:function(){alert("옵션이 추가되었습니다.");location.reload();},
 			error:function(){location.reload()}
 		});
 		
 		
 	}
 	function optionDelete(idx){
 		$.ajax({
 			type:"post",
 			url:"${ctp}/admin/product/optionDelete",
 			data:{idx:idx},
 			success:function(){alert("삭제되었습니다.");location.reload();},
 			error:function(){location.reload()}
 		});
 	}
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>상품 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<nav class="navbar navbar-expand-sm border shadow-sm " style="background-color:#fff">
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
	</nav>
	<div class="container-fluid p-5 border shadow-sm" style="background-color:#fff">
		<form name="myform">
			<div class="row">
				<div class="col-sm-4">
					<img style="width:80%" src="${ctp}/data/ckeditor/product/${vo.FSName}">
				</div>
				<div class="col-sm-8">
					<table class="table">
						<tr class="text-center">
							<tr>
								<th>상품코드</th>
								<td>${vo.code}</td>
							</tr>
							<tr>
								<th>대분류</th>
								<td>${vo.largeName}</td>
							</tr>
							<tr>
								<th>소분류</th>
								<td>${vo.smallName}</td>
							</tr>
							<tr>
								<th>상품이름</th>
								<td>${vo.name}</td>
							</tr>
							<tr>
								<th>상품가격</th>
								<td>${vo.price}</td>
							</tr>
							<tr>
								<th>상품옵션</th>
								<td>
									<table style="width:100%">
										<tr>
											<td>등록된 옵션</td>
											<td>
												<c:forEach var="optionVo" items="${optionVos}">
													옵션 이름 : <input type="text" value="${optionVo.optionName}" name="optionName${optionVo.idx}" id="optionName${optionVo.idx}" style="display:inline;width:30%"  class="form-control"/>,
													옵션 가격 :<input type="text" value="${optionVo.optionPrice}" name="optionPrice${optionVo.idx}" id="optionPrice${optionVo.idx}" style="display:inline;width:30%" class="form-control" />
													<input type="button" value="수정" class="btn btn-warning" onclick="optionUpdate(${optionVo.idx})"/>
													<input type="button" value="삭제" class="btn btn-danger" onclick="optionDelete(${optionVo.idx})" />
													<br/>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td>옵션 추가하기</td>
											<td>
												옵션 이름 : <input type="text" name="optionName" id="optionName" style="display:inline;width:30%"  class="form-control"/>,
												옵션 가격 :<input type="text" name="optionPrice" id="optionPrice" style="display:inline;width:30%" class="form-control" />
												<input type="button" value="등록" class="btn btn-success" onclick="optionInput(${vo.idx})"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
					</table>
				</div>
			</div>

		</form>
			
	</div>
</div>
<p><br/><br/></p>
</body>
</html>