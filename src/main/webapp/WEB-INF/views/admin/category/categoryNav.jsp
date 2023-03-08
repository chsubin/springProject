<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<nav class="navbar navbar-expand-sm border" style="background-color:#white">
	  <ul class="navbar-nav">
	    <li class="nav-item active">
	      <a class="nav-link" href="${ctp}/admin/category/adminCategory">소분류 등록</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${ctp}/admin/category/adminDetail">| 정기배송 상세페이지</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">| 상세설명</a>
	    </li>
	  </ul>
	</nav>