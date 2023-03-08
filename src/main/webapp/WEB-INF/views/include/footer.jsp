<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<br/><br/><br/>
<hr style="border-top:1px solid black"/>
<div class="container-fluid" style="width:80%">
	<div class="p-2 m-2" style="float:left;">
		<img src="${ctp}/images/logo-1.png" onclick="location.href='${ctp}/'"/>
	</div>
	<div  class="p-2 m-2"  style="float:left;color:gray">
		<b class="text-dark">고객만족센터</b><br/>
		<span style="font-size:1.3em;color:darkblue;"><b>1877-7235</b><br/></span>
		<span style="font-size:0.9em">
			[평일]AM 10:00 ~ PM 06:00<br/>
			[점심]AM 12:00 ~ PM 01:00<br/>
			토요일 / 일요일 / 공휴일 휴무
		</span>
	</div>
	<div class="card-deck" style="height:130px" onclick="location.href='${ctp}/reviews/reviewsList';">
		<div class="card border-dark">
    	<div class="card-body text-center">
      	<p class="card-text">REVIEW</p>
    	</div>
  	</div>
		<div class="card border-dark" onclick="location.href='${ctp}/board/boardList';">
    	<div class="card-body text-center">
      	<p class="card-text">EVENT</p>
    	</div>
  	</div>
		<div class="card border-dark" onclick="question()">
    	<div class="card-body text-center">
      	<p class="card-text">1:1문의</p>
    	</div>
  	</div>
		<div class="card border-dark" onclick="location.href='${ctp}/business/businessMain';">
    	<div class="card-body text-center">
      	<p class="card-text">제휴농가</p>
    	</div>
  	</div>
	</div>
	<hr class="mb-1"/>
	<div class="row">
		<div class="col">
			<ul class="nav">
			  <li class="nav-item">
			    <a class="nav-link" href="${ctp}/">HOME</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">이용약관</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">개인정보취급방침</a>
			  </li>
			</ul>
		</div>
		<div class="col">
		  <ul class="nav justify-content-end">
		    <li class="nav-item">
		      <a class="nav-link pr-0"  href="#"><font size="5em" style="color:gray;"><i class='bx bxl-facebook-circle' ></i></font></a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#"><font size="5em" style="color:gray;"><i class='bx bx-camera' ></i></font></a>
		    </li>
			 </ul>
		 </div>
  </div>
	<hr class="mt-1" style="clear:both;"/>
	<div class="text-secondary" style="font-size:0.8em">
		<div class="pt-1">2023.02.25. 그린아트컴퓨터학원 | 최수빈</div>
		<div class="pt-1">[디지털 컨버전스]4차 산업(JAVA) & 스프링 프레임워크 백엔드 개발자</div>
		<div class="pt-1"></div>
	</div>
	<br/><br/>
</div>