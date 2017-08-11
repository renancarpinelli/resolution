package br.senai.informatica.sp.resolution.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoUsuario;
import br.senai.informatica.sp.resolution.model.usuarios.Escola;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.restcontroller.AdministradorRestController;

@Transactional
@Controller
@RequestMapping("/adx")
public class AdministradorController {

	@Autowired
	private UsuarioDao usuarioDao;


	// Parte de Professor 
	
	@RequestMapping("/listaProfessores")
	public String listaDeProfessores() {
		return "/usuario/administrador/lista_professores";
	}

	@RequestMapping("/perfilProfessor/{idProfessor}")
	public String perfilProfessor(@PathVariable Long idProfessor, Model model) {
		model.addAttribute(usuarioDao.buscar(idProfessor));
		return "usuario/administrador/perfil_professor";
	}
	
	@RequestMapping("/ativarProfessor/{idProfessor}")
	public String ativarProfessor(@PathVariable Long idProfessor) {
		Professor professor = (Professor) usuarioDao.buscar(idProfessor);
		professor.setTipoEstadoUsuario(TipoEstadoUsuario.ATIVO);
		usuarioDao.alterar(professor);
		return "redirect: ../perfilProfessor/"+idProfessor;
	}
	
	@RequestMapping("/recusarProfessor/{idProfessor}")
	public String recusarProfessor(@PathVariable Long idProfessor) {
		Professor professor = (Professor) usuarioDao.buscar(idProfessor);
		professor.setTipoEstadoUsuario(TipoEstadoUsuario.RECUSADO);
		usuarioDao.alterar(professor);
		return "redirect: ../perfilProfessor/"+idProfessor;
	}
	
	
	@RequestMapping("/inativarProfessor/{idProfessor}")
	public String inativarProfessor(@PathVariable Long idProfessor) {
		Professor professor = (Professor) usuarioDao.buscar(idProfessor);
		professor.setTipoEstadoUsuario(TipoEstadoUsuario.INATIVO);
		usuarioDao.alterar(professor);
		return "redirect: ../perfilProfessor/"+idProfessor;
	}
	
	// Parte de Escola 
	
	@RequestMapping("/listaEscolas")
	public String listaDeEscolas() {
		return "/usuario/administrador/lista_escolas";
	}
	
	@RequestMapping("perfilEscola/{idEscola}")
	public String perfilEscola(@PathVariable Long idEscola, Model model) {
		model.addAttribute(usuarioDao.buscar(idEscola));
		return "usuario/administrador/perfil_escola";
	}
	
	
	@RequestMapping("/ativarEscola/{idEscola}")
	public String ativarEscola(@PathVariable Long idEscola) {
		Escola escola = (Escola) usuarioDao.buscar(idEscola);
		escola.setTipoEstadoUsuario(TipoEstadoUsuario.ATIVO);
		usuarioDao.alterar(escola);
		return "redirect: /adx/perfilEscola/"+idEscola;
	}
	
	@RequestMapping("/recusarEscola/{idEscola}")
	public String recusarEscola(@PathVariable Long idEscola) {
		Escola escola = (Escola) usuarioDao.buscar(idEscola);
		escola.setTipoEstadoUsuario(TipoEstadoUsuario.RECUSADO);
		usuarioDao.alterar(escola);
		return "redirect: /adx/perfilEscola/"+idEscola;
	}
	
	@RequestMapping("/inativarEscola/{idEscola}")
	public String inativarEscola(@PathVariable Long idEscola) {
		Escola escola = (Escola) usuarioDao.buscar(idEscola);
		escola.setTipoEstadoUsuario(TipoEstadoUsuario.INATIVO);
		usuarioDao.alterar(escola);
		return "redirect: /adx/perfilEscola/"+idEscola;
	}

}
