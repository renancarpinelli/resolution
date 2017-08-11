package br.senai.informatica.sp.resolution.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.model.usuarios.Administrador;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Escola;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Usuario;

@Transactional
@Controller
public class LoginController {

	@Autowired
	UsuarioDao usuarioDao;

	@RequestMapping("logar")
	public String logarUsuario(String email, String senha, HttpSession session, Model model) {
		Usuario usuario = usuarioDao.logar(email, senha);

		if (usuario != null) {
			if (usuario instanceof Aluno) {
				session.setAttribute("alunoLogado", usuario);
				return "redirect: alx/home";
			} else if (usuario instanceof Professor) {
				session.setAttribute("professorLogado", usuario);
				return "redirect: pfx/home";
			} else if (usuario instanceof Escola) {
				session.setAttribute("escolaLogado", usuario);
				return "redirect:home";
			} else if (usuario instanceof Administrador) {
				session.setAttribute("administradorLogado", usuario);
				return "redirect: adx/home";
			} else {
				return "index";
			}

		} else {
			
			model.addAttribute("erro", "erro");
			return "login";
		}

	}

	@RequestMapping("/sair")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:index";
	}
	
	
}
