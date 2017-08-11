package br.senai.informatica.sp.resolution.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	@RequestMapping("index")
	public String index(){
		return "index";
	}
	
	
	@RequestMapping("login")
	public String login(){
		return "login";
	}

	
	@RequestMapping("acessonegado")
	public String acessoNegado(){
		return "acessonegado";
	}
	
	
	@RequestMapping("loginerro")
	public String loginErro(){
		return "loginerro";
	}

}

