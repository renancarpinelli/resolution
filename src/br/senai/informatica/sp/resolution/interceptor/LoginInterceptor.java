package br.senai.informatica.sp.resolution.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		
		if(uri.endsWith("index") || uri.endsWith("login")|| uri.endsWith("loginerro")|| uri.endsWith("form")){
			return true;
		}else if (uri.contains("adx")&& request.getSession().getAttribute("administradorLogado") == null){
			response.sendRedirect("acessonegado");
			return false;
		}else if(uri.contains("alx")&& request.getSession().getAttribute("alunoLogado") == null){
			response.sendRedirect("acessonegado");
			return false;
		}else if (uri.contains("pfx")&& request.getSession().getAttribute("professorLogado") == null){
			response.sendRedirect("acessonegado");
			return false;
		}		
		
		return true;
	}}

