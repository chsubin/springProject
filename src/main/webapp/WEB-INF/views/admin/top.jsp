<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	 <ul class="nav headernav justify-content-end m-2">
    <li class="nav-item">
	    <a class="nav-link" href="${ctp}/member/memberLogout">
		  	<font class="headericon" size="4em"></font>
	    	 리얼후르츠 관리자 접속시간 : ${sTime}
	    </a>
    </li>
		<li class="nav-item dropdown">
      <a class="nav-link" >
		  	<font class="headericon" size="4em"></font>
      	HOME
      </a>
    </li>
    <li class="nav-item">
	    <a class="nav-link btn btn-sm btn-outline-secondary"  href="javascript:logout()">
		  	<font class="headericon" size="4em"></font>
	    	  로그아웃
	    </a>
    </li>
  </ul>