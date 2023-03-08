package com.spring.green2209S_20.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level3Interceptor extends HandlerInterceptorAdapter {
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null?99:Integer.parseInt(String.valueOf(session.getAttribute("sLevel")));
		if(level>3) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/memberNo1");
			dispatcher.forward(request, response);
			return false;
		}
		
		
		return true;
	}
	
}
