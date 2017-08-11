package br.senai.informatica.sp.resolution.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoUsuario;
import br.senai.informatica.sp.resolution.model.usuarios.Escola;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Usuario;

@RestController
public class AdministradorRestController {

	@Autowired
	private UsuarioDao usuarioDao;
	
	// Parte Professor 

	@RequestMapping(value = "listarProfessores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Professor> listarProfessores() {
		return usuarioDao.listarProfessores();
	}
	
	
	@RequestMapping(value = "ativoProfessores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Professor> listarProfessoresAtivos() {
		return usuarioDao.listarProfessores(TipoEstadoUsuario.ATIVO);
	}
	
	
	@RequestMapping(value = "inativoProfessores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Professor> listarProfessoresInativos() {
		return usuarioDao.listarProfessores(TipoEstadoUsuario.INATIVO);
	}
	
	@RequestMapping(value = "aguardandoProfessores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Professor> listarProfessoresAguardando() {
		return usuarioDao.listarProfessores(TipoEstadoUsuario.AGUARDANDO);
	}
	
	@RequestMapping(value = "recusadoProfessores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Professor> listarProfessoresRecusado() {
		return usuarioDao.listarProfessores(TipoEstadoUsuario.RECUSADO);
	}
	
	// Parte Escola 
	
	@RequestMapping(value = "ativoEscolas", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Escola> listarEscolasAtivos() {
		return usuarioDao.listarEscolas(TipoEstadoUsuario.ATIVO);
	}
	
	
	@RequestMapping(value = "inativoEscolas", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Escola> listarEscolasInativos() {
		return usuarioDao.listarEscolas(TipoEstadoUsuario.INATIVO);
	}
	
	@RequestMapping(value = "aguardandoEscolas", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Escola> listarEscolasAguardando() {
		return usuarioDao.listarEscolas(TipoEstadoUsuario.AGUARDANDO);
	}
	
	@RequestMapping(value = "recusadoEscolas", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Escola> listarEscolasRecusado() {
		return usuarioDao.listarEscolas(TipoEstadoUsuario.RECUSADO);
	}


}
