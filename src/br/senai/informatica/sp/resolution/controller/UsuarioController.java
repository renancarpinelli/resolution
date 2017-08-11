package br.senai.informatica.sp.resolution.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import br.senai.informatica.sp.resolution.tools.UploadFoto;
import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoUsuario;
import br.senai.informatica.sp.resolution.enums.TipoUsuario;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Escola;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;

@Transactional
@Controller
public class UsuarioController {

	@Autowired
	private UsuarioDao usuarioDao;

	private UploadFoto upload;

	@RequestMapping("form_usuario")
	public String form() {
		return "usuario/form";
	}
	
	@RequestMapping("adx/home")
	public String home() {
		return "usuario/home";
	}
	
	@RequestMapping("pfx/home")
	public String home1() {
		return "usuario/home";
	}
	
	@RequestMapping("alx/home")
	public String home2() {
		return "usuario/home";
	}
	
	@RequestMapping("salvar_aluno")
	public String salvar(Aluno aluno, MultipartFile fileFoto) {

		aluno.setFoto(upload.salvarBytes(fileFoto));
		aluno.setTipoEstadoUsuario(TipoEstadoUsuario.ATIVO);
		aluno.setTipoUsuario(TipoUsuario.ALUNO);
		usuarioDao.inserir(aluno);
		return "redirect:form_usuario";
	}

	@RequestMapping("salvar_professor")
	public String salvar(Professor professor, MultipartFile fileFoto, MultipartFile fileDocumento) {

		professor.setFoto(upload.salvarBytes(fileFoto));
		professor.setDocumentacao(upload.salvarBytes(fileDocumento));
		professor.setTipoUsuario(TipoUsuario.PROFESSOR);

		professor.setTipoEstadoUsuario(TipoEstadoUsuario.AGUARDANDO);
		usuarioDao.inserir(professor);
		return "redirect:form_usuario";
	}

	@RequestMapping("salvar_escola")
	public String salvar(Escola escola, MultipartFile fileFoto, MultipartFile fileDocumento) {

		escola.setFoto(upload.salvarBytes(fileFoto));
		escola.setDocumentacao(upload.salvarBytes(fileDocumento));
		escola.setTipoUsuario(TipoUsuario.ESCOLA);

		escola.setTipoEstadoUsuario(TipoEstadoUsuario.AGUARDANDO);
		usuarioDao.inserir(escola);
		return "redirect:form_usuario";
	}

	@RequestMapping("/verificarEmail")
	public @ResponseBody boolean verificarEmail(String email, HttpServletResponse response) {
		response.setStatus(200);
		return usuarioDao.verificaEmail(email);
	}

}
