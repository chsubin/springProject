<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>boardContent.jsp</title>
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
		  function fCheck() {
			  let maxSize = 1024 * 1024 * 20;
			  let title = $("#title").val();
			  let file = $("#file").val();
			  let content =$("#content").val();
			  
			  if(title.trim() == "") {
				  alert("제목을 입력하세요.");
				  document.getElementById("title").focus();
				  return false;
			  }
			  else if(content.trim() == "") {
				  alert("비밀번호를 입력하세요.");
				  document.getElementById("content").focus();
				  return false;
			  }
			  
			  // 파일 사이즈 처리...
			  let fileSize = 0;
			  let files = document.getElementById("file").files;
			  
			  for(let i=0; i<files.length; i++) {
				  file =files[i];
				  let fName;
					  
					 if(file.name != "") {
						  //fileSize += file.size;
						  fName = file.name;
						  let ext = fName.substr(fName.lastIndexOf(".")+1);
						  let uExt = ext.toUpperCase();
						  if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JFIF") {
							  alert("업로드 가능한 파일은 'JPG/GIF/PNG/JFIF' 입니다.");
							  return false;
					  	}
						  fileSize+=file.size;
				  }
			  }
			  if(fileSize > maxSize) {
				  alert("업로드할 파일의 최대용량은 20MByte 입니다.");
				  return false;
			  }
			  else {
				  myform.submit();
			  }
		  }
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<p><br/></p>
<div class="container-fluid fadein" style="width:80%">
	<div class="border" style="width:100%">
		<form name="myform" method="post" action="${ctp}/reviews/reviewsInput"  enctype="multipart/form-data">
			<table class="table" style="margin:0 auto;width:80%">
				<tr class="table-borderless">
					<td colspan="2" class="pb-5 pt-5" >
						<h1 style="font-family:'ChosunNm'">REVIEWS</h1>
					</td>
				</tr>
				<tr>
					<th width="10%">상품</th>
					<td>
						<div class="row">
							<div class="col-sm-2">
								<img style="width:100%" src="${ctp}/data/ckeditor/product/${vo.FSName}">
							</div>
							<div class="col">
								<h6><b>${vo.productName}</b></h6><br/>
								<p>${vo.optionName} X ${vo.optionNum}</p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%">제목</th>
					<td><input type="text" name="title" id="title" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="15" name="content"  id="content" class="form-control" required></textarea></td>
				</tr>
				<tr>
					<th>사진 파일</th>
					<td>
						<input type="file" name="file" id="file" class="form-control-file" multiple="multiple" accept=".jpg,.gif,.png,.jfif"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><br/><br/>
						<input type="button" value="등록하기" onclick="fCheck()"  class="btn btn-warning">
						<input type="button" value="다시쓰기"  class="btn btn-secondary">
					</td>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}"/>
			<input type="hidden" name="oIdx" value="${param.idx}"/>
		</form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
