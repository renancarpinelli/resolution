package br.senai.informatica.sp.resolution.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import br.senai.informatica.sp.resolution.dao.prova.ProvaDao;
import br.senai.informatica.sp.resolution.dao.prova.ProvaDoAlunoDao;
import br.senai.informatica.sp.resolution.dao.questao.QuestaoDao;
import br.senai.informatica.sp.resolution.dao.usuario.TurmaDao;
import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;
import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;
import br.senai.informatica.sp.resolution.tools.QRCodeGenerator;
import br.senai.informatica.sp.resolution.tools.RandomString;

@Transactional
@Controller
@RequestMapping("/alx")
public class AlunoController {

	@Autowired
	private UsuarioDao usuarioDao;

	@Autowired
	private TurmaDao turmaDao;

	@Autowired
	private ProvaDoAlunoDao provaDoAlunoDao;

	@Autowired
	private ProvaDao provaDao;
	
	@Autowired
	private QuestaoDao questaoDao;

	private ProvaDoAluno provaDoAluno;
	private String codigo;

	@RequestMapping("/listaTurmasAluno")
	public String listaDeTurmas() {
		
		System.out.println("testeee");
		
		return "/usuario/aluno/turma/lista_turmas";
	}

	@RequestMapping("/buscarTurmasAluno")
	public String BuscarTurma() {
		return "/usuario/aluno/turma/buscar_turma";
	}

	@RequestMapping("/buscarTurmaAluno")
	public String perfilTurma(String codigo, Model model, HttpSession session) {
		boolean japossui = false;
		Aluno aluno = (Aluno) session.getAttribute("alunoLogado");
		Turma turma = turmaDao.buscarCodigoAluno(codigo);

		if (turma != null) {
			List<Aluno> alunos = turmaDao.listarAlunos(turma.getId());
			for (Aluno a : alunos) {
				if (aluno.getId() == a.getId()) {
					japossui = true;
				}
			}
			if (japossui) {
				model.addAttribute("erroentrar", "erroentrar");
			} else {
				model.addAttribute(turma);
			}
		} else {
			model.addAttribute("erro", "erro");
		}
		return "usuario/aluno/turma/buscar_turma";
	}

	@RequestMapping("entrarTurmaAluno/{idTurma}")
	public String entrarTurma(@PathVariable Long idTurma, HttpSession session, Model model) {
		Aluno aluno = (Aluno) session.getAttribute("alunoLogado");
		Turma turma = turmaDao.buscar(idTurma);

		List<Aluno> alunos = turmaDao.listarAlunos(turma.getId());
		alunos.add(aluno);

		turma.setAlunos(alunos);

		turmaDao.alterar(turma);

		return "redirect: ../listaTurmasAluno";
	}

	// Provas

	@RequestMapping("/listaProvasAluno")
	public String listaDeProvas() {
		return "/usuario/aluno/prova/lista_provas";
	}
	
	@RequestMapping("/listaProvasAluno2")
	public String listaDeProvas2() {
		return "/usuario/aluno/prova/lista_provas2";
	}

	@RequestMapping("/realizarProva/{idProva}")
	public String realizarProvas(@PathVariable long idProva, HttpSession session, Model model)
			throws JSONException, IOException {
		Aluno aluno = (Aluno) session.getAttribute("alunoLogado");
        Long idAluno = aluno.getId();
		if (!provaDoAlunoDao.provaJaCriada(idProva, idAluno)) {
			provaDoAluno = new ProvaDoAluno();
			codigo = RandomString.GerarString();
			provaDoAluno.setCodigo(codigo);
			provaDoAluno.setAluno(aluno);
			provaDoAluno.setProva(provaDao.buscar(idProva));
			// Inserir QRCODE
			JSONObject job = new JSONObject();
			job.put("idAluno", aluno.getId());
			job.put("codigoProva", codigo);
			provaDoAluno.setQrCode(QRCodeGenerator.gerarQRCode(job.toString()));
			//
			provaDoAlunoDao.inserir(provaDoAluno);
			model.addAttribute("QRCode", provaDoAluno.getQrCode64());
			model.addAttribute("codigo",codigo);
			return "/usuario/aluno/prova/prova";
		} else {
			if (provaDoAlunoDao.provaJaRealizada(idProva, idAluno)) {
				return "redirect: ../provaAluno/"+idProva+"/"+idAluno;
			} else {
				provaDoAluno = provaDoAlunoDao.buscarProvaDoAluno(idProva, idAluno);		
				model.addAttribute("QRCode", provaDoAluno.getQrCode64());
				model.addAttribute("codigo",provaDoAluno.getCodigo());
				return "/usuario/aluno/prova/prova";
			}

		}

	}
	
	// View : Prova do Aluno 
	@RequestMapping("provaAluno/{idProva}/{idAluno}")
	public String provaDoAluno(@PathVariable Long idProva, @PathVariable Long idAluno, Model model) {
		ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscarProvaDoAluno(idProva, idAluno);
		model.addAttribute("provaDoAluno", provaDoAluno);
		return "/usuario/aluno/prova/prova_aluno";
	}

	
	// View : Realizar Simulado
	@RequestMapping("/realizar_simulado")
	public String realizarSimulado() {
		return "/usuario/aluno/simulado/realizar_simulado";
	}

	
	     //  Gerar simualdo
		@RequestMapping(value = "/gerarSimulado", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public String gerarSimulado(String tipoDaQuestao, int numerQuestoes,Long[] marcSelecionados, Model model) {
			List<Questao> questoes;
			if (tipoDaQuestao.equalsIgnoreCase("mista")) {
				questoes = questaoDao.gerarSimulado(numerQuestoes, marcSelecionados);
			} else if (tipoDaQuestao.equalsIgnoreCase("objetiva")) {
				questoes = questaoDao.gerarSimulado(TipoQuestao.OBJETIVA, numerQuestoes, marcSelecionados);
			} else {
				questoes = questaoDao.gerarSimulado(TipoQuestao.DISSERTATIVA, numerQuestoes, marcSelecionados);
			}	
			
			if (questoes != null) {
				model.addAttribute("questoes", questoes);
				return "/usuario/aluno/simulado/simulado";
			} else {
				model.addAttribute("erro", "erro");
				return "/usuario/aluno/simulado/realizar_simulado";
			}
			
			
		}
	
	
	

}
