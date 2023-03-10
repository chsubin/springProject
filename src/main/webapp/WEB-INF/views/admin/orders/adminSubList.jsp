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
		.badge:hover{
		cursor:pointer;
		}
		.cli {
			cursor:pointer;
		}
	 </style>
 <script>
 	'use strict';
 	function fSearch(){
 		let startDate= myform.startDate.value;
 		let lastDate= myform.lastDate.value;
 		let subSw = myform.subSw.value;
 		let part = myform.part.value;
 		let search = myform.search.value;
 		let sstartDate= myform.sstartDate.value;
 		let slastDate= myform.slastDate.value;
 		
 		location.href="${ctp}/admin/orders/adminSubList?startDate="+startDate+"&lastDate="+lastDate+"&subSw="+subSw+"&part="+part+"&search="+search+"&sstartDate="+sstartDate+"&slastDate="+slastDate;
 		
 	}
 	function selectAll(){
 		$(".chk").prop("checked",true);
 	}
 	function selectReverse(){
	 		if($(".chk").prop("checked")){
	 			$(".chk").prop("checked",false);
	 		}
	 		else{
	 			$(".chk").prop("checked",true);
	 		}
 	}
 	function selectDelivery(){
 		let chks ="";
 		let content=myform.content.value;
 		for(let i=0;i<myform.chk.length;i++){
 			if(myform.chk[i].checked){
 				chks+= myform.chk[i].value+"/";
 			}
 		}
 		if(chks==""){chks = myform.chk.value+"/";}
 		if(chks=="") {alert("??????????????? ????????? ??????????????????.");return;}
 		alert(chks);
 		$.ajax({
 			type: "post",
 			data: {idxs:chks,content:content},
 			url: "${ctp}/admin/orders/adminSubWrite",
 			success:function(){alert("???????????? ???????????????.");location.reload();},
 			error:function(){}
 		});
 	}
 	
	
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>???????????? ?????? ??????</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3">

		<div class="container-fluid p-1 mb-3 border shadow-sm" style="background-color:#fff">
			<table class="table table-borderless">
				<tr>
					<th><h4><b>?????? ?????? ??????</b></h4></th>
					<td>????????? <input type="date" name="startDate" value="${startDate}"> - <input type="date"  name="lastDate"  value="${lastDate}"> </td>
					<td>
						<select name="subSw"> 
							<option value="99" >?????? ??????</option>
							<option value="1" ${subSw==1 ? 'selected' : ''}>?????????</option>
							<option value="-1" ${subSw==-1 ? 'selected' : ''}>????????????</option>
						</select>
					</td>
					<td>
						<select name="part">
							<option value="" >??????????????????</option>
							<option value="orderIdx" ${part=='orderIdx' ? 'selected' : ''}>????????????</option>
							<option value="mid" ${part=='mid' ? 'selected' : ''}>?????????</option>
							<option value="productName" ${part=='productName' ? 'selected' : ''}>????????????</option>
							<option value="optionName" ${part=='optionName' ? 'selected' : ''}>??????</option>
						</select>
						<input type="text" name="search" value="${search}">
					</td>
					<td>???????????? ?????? 
						<input type="date" name="sstartDate" value="${sstartDate}"> - <input type="date"  name="slastDate"  value="${slastDate}"><br/>
						* ??? ????????? ?????? ????????? ??????????????????.
					</td>
					<td><input type="button" class="btn btn-success" value="??????" onclick="fSearch()"/></td>
				</tr>
			</table>
		</div>
	<div class="container-fluid p-5  border shadow-sm" style="background-color:#fff">
		<c:if test="${empty ordersVos}">
			<h4 class="m-5">???????????? ????????? ????????????.</h4>
		</c:if>
		<c:if test="${!empty ordersVos}">
			<table class="table table-hover table-bordered bg-white">
				<tr class="table table-borderless">
					<td colspan="4" class="text-left">
						<div class="btn btn-light border" onclick="selectAll();">????????????</div>
						<div class="btn btn-light border" onclick="selectReverse();">????????????</div>
					</td>
					<td colspan="3" class="text-right">
						<div class="btn btn-outline-dark" data-toggle="modal" data-target="#myModal">????????????</div>
					</td>
				</tr>
				<tr class="text-center border bg-dark text-white">
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>???????????? ??????</th>
					<th>????????? ?????????</th>
					<th>??????</th>
				</tr>
				<c:forEach var="ordersVo" items="${ordersVos}">
					<tr  class="text-center">
						<td class="border-top"><input type="checkbox"  class="chk" name="chk"  value="${ordersVo.idx}"/></td>
						<td class="border-top cli" onclick="location.href='${ctp}/admin/orders/adminOrdersContent?orderIdx=${ordersVo.orderIdx}';">
								<b>${ordersVo.orderIdx}</b><br/>
								${ordersVo.orderDate}<br/><br/>
								????????? : ${ordersVo.mid}
						</td>
						<c:if test="${ordersVo.orderIdx==orderIdx}"><td class="table-borderless"></td></c:if>
						<td class="border-top" >
							<c:if test="${ordersVo.orderSw!=-1}">${ordersVo.productName}</c:if>
							<c:if test="${ordersVo.orderSw==-1}"><font color="red">${ordersVo.productName}</font><div class="badge badge-danger">??????</div></c:if>
						</td>
						<td class="border-top">${ordersVo.optionName}</td>
						<td class="border-top">${ordersVo.optionDetail}</td>
						<td class="border-top">${ordersVo.DDate}</td>
						<td class="border-top" onclick="location.href='${ctp}/admin/subscribe/adminSubContent?oIdx=${ordersVo.idx}';">
							<c:if test="${ordersVo.subSw=='NO'}"><div class="badge badge-danger">????????????</div></c:if>
							<c:if test="${ordersVo.subSw=='OK'}"><div class="badge badge-success">?????????</div></c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
<!-- ?????? ????????? ?????? -->

			<div class="text-center">
			  <ul class="pagination justify-content-center">
			    <c:if test="${pageVo.pag > 1}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=1&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">????????????</a></li>
			    </c:if>
			    <c:if test="${pageVo.curBlock > 0}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">????????????</a></li>
			    </c:if>
			    <c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize + 1}" end="${(pageVo.curBlock)*pageVo.blockSize + pageVo.blockSize}" varStatus="st">
			      <c:if test="${i <=pageVo.totPage && i == pageVo.pag}">
			    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">${i}</a></li>
			    	</c:if>
			      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
			    		<li class="page-item"><a class="page-link text-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=${i}&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">${i}</a></li>
			    	</c:if>
			    </c:forEach>
			    <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">????????????</a></li>
			    </c:if>
			    <c:if test="${pageVo.pag < pageVo.totPage}">
			      <li class="page-item"><a class="page-link text-secondary" href="adminSubList?pageSize=${pageVo.pageSize}&pag=${pageVo.totPage}&startDate=${startDate}&lastDate=${lastDate}&subSw=${subSw}&part=${part}&search=${search}&sstartDate=${sstartDate}&slastDate=${slastDate}">??????????????????</a></li>
			    </c:if>
			  </ul>
			</div>
		</div>
	</div>
	
	  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">?????? ?????? ??????</h4>
          <button type="button" class="close" data-dismiss="modal">??</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <table class="table ">
          	<tr>
          		<td>?????? ?????? ????????????</td>
          	</tr>
          	<tr>
          		<td><textarea rows="5" class="form-control" name="content"></textarea> </td>
          	</tr>
          </table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-success" onclick="selectDelivery()">????????????</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	
	
</form>
<p><br/><br/></p>
</body>
</html>