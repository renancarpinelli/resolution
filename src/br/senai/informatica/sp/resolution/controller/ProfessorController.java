package br.senai.informatica.sp.resolution.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sun.org.apache.regexp.internal.recompile;

import br.senai.informatica.sp.resolution.dao.prova.ProvaDao;
import br.senai.informatica.sp.resolution.dao.prova.ProvaDoAlunoDao;
import br.senai.informatica.sp.resolution.dao.prova.QuestaoDaProvaDao;
import br.senai.informatica.sp.resolution.dao.prova.RespostaDoAlunoDao;
import br.senai.informatica.sp.resolution.dao.questao.MarcadorDao;
import br.senai.informatica.sp.resolution.dao.questao.QuestaoDao;
import br.senai.informatica.sp.resolution.dao.usuario.TurmaDao;
import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProva;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProvaDoAluno;
import br.senai.informatica.sp.resolution.enums.TipoEstadoQuestao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoTurma;
import br.senai.informatica.sp.resolution.enums.TipoPlataforma;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;
import br.senai.informatica.sp.resolution.model.prova.Prova;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;
import br.senai.informatica.sp.resolution.model.prova.QuestaoDaProva;
import br.senai.informatica.sp.resolution.model.prova.RespostaDoAluno;

import br.senai.informatica.sp.resolution.model.questao.Marcador;
import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.questao.Resposta;
import br.senai.informatica.sp.resolution.model.questao.RespostaDissertativa;
import br.senai.informatica.sp.resolution.model.questao.RespostaObjetiva;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;
import br.senai.informatica.sp.resolution.tools.ConverterData;
import br.senai.informatica.sp.resolution.tools.QRCodeGenerator;
import br.senai.informatica.sp.resolution.tools.RandomString;
import br.senai.informatica.sp.resolution.tools.UploadFoto;

@Transactional
@Controller
@RequestMapping("/pfx")
public class ProfessorController {

	@Autowired
	private UsuarioDao usuarioDao;

	@Autowired
	private TurmaDao turmaDao;

	@Autowired
	private QuestaoDao questaoDao;

	@Autowired
	private MarcadorDao marcadorDao;

	@Autowired
	private ProvaDao provaDao;

	@Autowired
	private ProvaDoAlunoDao provaDoAlunoDao;

	@Autowired
	private QuestaoDaProvaDao questaoDaProvaDao;

	@Autowired
	private RespostaDoAlunoDao respostaDoAlunoDao;

	private UploadFoto upload;

	private Calendar data;
	private QuestaoDaProva questaoDaProva;
	private Questao questao;
	private ConverterData converterData;
	private Turma turma;
	private List<Prova> provas;
	private List<Turma> listTurmas;
	private Prova prova;
	private long tempo, valor, notaTotal;

	// --------------------------- Parte de Turma ----------------------

	// Tela: Lista de Turmas
	@RequestMapping("/listaTurmasProfessor")
	public String listaDeTurmas() {
		return "/usuario/professor/turma/lista_turmas";
	}

	// Tela: criar de turmas
	@RequestMapping("/criarTurma")
	public String CriarTurma() {
		return "/usuario/professor/turma/criar_turma";
	}

	// Tela: buscar turma
	@RequestMapping("/buscarTurmas")
	public String BuscarTurma() {
		return "/usuario/professor/turma/buscar_turma";
	}

	// Post: inativar turma
	@RequestMapping("/inativarTurma/{idTurma}")
	public String inativarTurma(@PathVariable long idTurma) {
		turma = turmaDao.buscar(idTurma);
		turma.setTipoEstadoTurma(TipoEstadoTurma.INATIVO);
		turmaDao.alterar(turma);
		return "redirect: ../perfilTurma/" + idTurma;
	}

	// Post: ativar turma
	@RequestMapping("/ativarTurma/{idTurma}")
	public String ativarTurma(@PathVariable long idTurma) {
		turma = turmaDao.buscar(idTurma);
		turma.setTipoEstadoTurma(TipoEstadoTurma.ATIVO);
		turmaDao.alterar(turma);
		return "redirect: ../perfilTurma/" + idTurma;
	}

	// Post : alterar turma
	@RequestMapping("/salvarTurma")
	public String SalvarTurma(Turma turma) {
		Turma turma2 = turmaDao.buscar(turma.getId());
		turma2.setDescricao(turma.getDescricao());
		turmaDao.alterar(turma2);
		return "redirect:/listaTurmasProfessor";
	}

	// Post : cria turma
	@RequestMapping("/criarNovaTurma")
	public String CriarNovaTurma(Turma turma, HttpSession session) {
		// pega professro da sessão
		Professor professor = (Professor) session.getAttribute("professorLogado");
		turma.setCodigoAluno(RandomString.GerarString());
		turma.setCodigoProfessor(RandomString.GerarString());
		turma.setIdProfessor(professor.getId());
		turma.setTipoEstadoTurma(TipoEstadoTurma.ATIVO);
		// Cria nova turma
		List<Turma> turmas = turmaDao.listarTurmas(professor.getId());
		turmas.add(turma);
		// set turma no professor

		professor.setTurmas(turmas);
		usuarioDao.alterar(professor);
		return "redirect: listaTurmasProfessor";
	}

	// Tela: Turma do professor
	@RequestMapping("perfilTurma/{idTurma}")
	public String perfilProfessor(@PathVariable Long idTurma, Model model) {
		model.addAttribute(turmaDao.buscar(idTurma));
		return "usuario/professor/turma/perfil_turma";
	}

	// Tela: Turma do professor
	@RequestMapping("/buscarTurmaProfessor")
	public String perfilTurma(String codigo, Model model, HttpSession session) {
		boolean japossui = false;
		Professor professor = (Professor) session.getAttribute("professorLogado");
		Turma turma = turmaDao.buscarCodigoProf(codigo);
		if (turma != null) {
			List<Turma> turmas = turmaDao.listarTurmas(professor.getId());
			for (Turma t : turmas) {
				if (turma.getId() == t.getId()) {
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
		return "usuario/professor/turma/buscar_turma";
	}

	// Get : Busca turma
	@RequestMapping("entrarTurmaProfessor/{idTurma}")
	public String entrarTurma(@PathVariable Long idTurma, HttpSession session, Model model) {
		Professor professor = (Professor) session.getAttribute("professorLogado");
		Turma turma = turmaDao.buscar(idTurma);
		List<Turma> turmas = turmaDao.listarTurmas(professor.getId());
		turmas.add(turma);
		professor.setTurmas(turmas);
		usuarioDao.alterar(professor);
		return "redirect: ../listaTurmasProfessor";
	}

	// Remover aluno da turma

	@RequestMapping("remover_aluno_turma/{idTurma}/{idAluno}")
	public String removerAlunoTurma(@PathVariable Long idTurma, @PathVariable Long idAluno) {

		Turma turma = turmaDao.buscar(idTurma);
	
		for (Aluno aluno : turma.getAlunos()) {
			if(aluno.getId() == idAluno){
				turma.getAlunos().remove(aluno);
				break;
			}
		}
		
		
		turmaDao.alterar(turma);
		return "redirect: ../../perfilTurma/"+idTurma;
	}

	// ---------------------------- Parte de questões
	// ---------------------------------

	// Tela : lista de questões
	@RequestMapping("/listasMinhasQuestoes")
	public String listaDeQuestoes() {
		return "/usuario/professor/questao/minhas_questoes";
	}

	// Tela lista questões inativas
	@RequestMapping("/listasMinhasQuestoesInativas")
	public String listaDeQuestoesInativas() {
		return "/usuario/professor/questao/minhas_questoes_inativas";
	}

	// Get : Retorna questões de acordo com a busca
	@RequestMapping(value = "/listarQuestoes", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody List<Questao> listaDeQuestoes(String tipoDaQuestao, int nivel_dificuldade,
			Long[] marcSelecionados) {
		TipoQuestao tipoQuestao = null;

		if (tipoDaQuestao.equalsIgnoreCase("objetiva")) {
			tipoQuestao = TipoQuestao.OBJETIVA;
		} else {
			tipoQuestao = TipoQuestao.DISSERTATIVA;
		}

		if (marcSelecionados.length == 1) {
			return questaoDao.listarBusca(tipoQuestao, nivel_dificuldade, marcSelecionados[0]);

		} else if (marcSelecionados.length == 2) {
			return questaoDao.listarBusca(tipoQuestao, nivel_dificuldade, marcSelecionados[0], marcSelecionados[1]);

		} else {
			return questaoDao.listarBusca(tipoQuestao, nivel_dificuldade, marcSelecionados[0], marcSelecionados[1],
					marcSelecionados[2]);
		}
	}

	// Tela : Criar questao
	@RequestMapping("/criarQuestao")
	public String CriarQuestao() {
		return "/usuario/professor/questao/criar_questao";
	}

	// Post : Cria e altera questão dissertativa
	@RequestMapping("/criarQuestaoDissertativa")
	public String CriarQuestaoDissertativa(Questao questao, RespostaDissertativa respostaDissertativa,
			Long[] marcSelecionados, MultipartFile fileImagem, HttpSession session) {

		List<Marcador> marcadores = new ArrayList<>();
		for (Long idMarcador : marcSelecionados) {
			marcadores.add(marcadorDao.buscar(idMarcador));
		}
		List<Resposta> respostas = new ArrayList<>();
		respostas.add(respostaDissertativa);
		questao.setImagem(upload.salvarBytes(fileImagem));
		questao.setRespostas(respostas);
		questao.setMarcadores(marcadores);
		questao.setId_professor(((Professor) session.getAttribute("professorLogado")).getId());
		questao.setTipoQuestao(TipoQuestao.DISSERTATIVA);
		questao.setTipoEstadoQuestao(TipoEstadoQuestao.ATIVO);

		if (questao.getId() != null) {
			questaoDao.alterar(questao);
			return "redirect: editar_questao/" + questao.getId();
		} else {
			questaoDao.inserir(questao);
			return "redirect: listasMinhasQuestoes";
		}

	}

	// Post : Cria e altera questão objetiva
	@RequestMapping("/criarQuestaoObjetiva")
	public String CriarQuestaoObjetiva(Questao questao, String[] valores, String[] enunciados, Long[] marcSelecionados,
			MultipartFile[] fileAlternativa, MultipartFile fileImagem, HttpSession session) {
		RespostaObjetiva objetiva;

		List<Marcador> marcadores = new ArrayList<>();
		for (Long idMarcador : marcSelecionados) {
			marcadores.add(marcadorDao.buscar(idMarcador));
		}
		List<Resposta> objetivas = new ArrayList<>();
		for (int i = 0; i < valores.length; i++) {
			objetiva = new RespostaObjetiva();
			objetiva.setValor(valores[i].equalsIgnoreCase("v"));
			objetiva.setDescricao(enunciados[i]);
			objetivas.add(objetiva);
		}
		questao.setImagem(upload.salvarBytes(fileImagem));
		questao.setRespostas(objetivas);
		questao.setMarcadores(marcadores);
		questao.setId_professor(((Professor) session.getAttribute("professorLogado")).getId());
		questao.setTipoQuestao(TipoQuestao.OBJETIVA);
		questao.setTipoEstadoQuestao(TipoEstadoQuestao.ATIVO);

		if (questao.getId() != null) {
			questaoDao.alterar(questao);
			return "redirect: editar_questao/" + questao.getId();
		} else {
			questaoDao.inserir(questao);
			return "redirect: listasMinhasQuestoes";
		}

	}

	// Tela : Editar questao
	@RequestMapping("/editar_questao/{idQuestao}")
	public String visualizarQuestao(@PathVariable Long idQuestao, Model model) {
		model.addAttribute(questaoDao.buscar(idQuestao));
		return "/usuario/professor/questao/criar_questao";
	}

	// Inativar Questão
	@RequestMapping("/inativar_questao/{idQuestao}")
	public String inativarQuestao(@PathVariable Long idQuestao) {
		Questao questao = questaoDao.buscar(idQuestao);
		questao.setTipoEstadoQuestao(TipoEstadoQuestao.INATIVO);
		questaoDao.alterar(questao);
		return "redirect: ../listasMinhasQuestoesInativas";
	}

	// Reativar Questao
	@RequestMapping("/ativar_questao/{idQuestao}")
	public String ativarQuestao(@PathVariable Long idQuestao) {
		Questao questao = questaoDao.buscar(idQuestao);
		questao.setTipoEstadoQuestao(TipoEstadoQuestao.ATIVO);
		questaoDao.alterar(questao);
		return "redirect: ../listasMinhasQuestoes";
	}

	// ------------- Parte de Provas ---------------------

	// Tela : Lista de Provas
	@RequestMapping("/listaProvas")
	public String listarProvas() {
		return "/usuario/professor/prova/lista_provas";
	}

	// Tela : Criar Prova
	@RequestMapping("/criarProva")
	public String criarProva() {
		return "/usuario/professor/prova/criar_prova";
	}

	//
	@RequestMapping("/agendarProva")
	public String agendarProva() {
		return "/usuario/professor/prova/agendar_prova";
	}

	// Tela : Editar Prova

	@RequestMapping("/editarProva/{idProva}")
	public String editarProva(@PathVariable long idProva, Model model) {
		model.addAttribute("prova", provaDao.buscar(idProva));
		return "/usuario/professor/prova/criar_prova";
	}

	// Post : Adiar Prova
	@RequestMapping("/adiarProva/{idProva}")
	public String adiarProva(@PathVariable long idProva) {
		prova = provaDao.buscar(idProva);
		prova.setTipoEstadoProva(TipoEstadoProva.ADIADA);
		prova.setData_inicial(null);
		prova.setData_final(null);
		provaDao.alterar(prova);
		return "redirect: ../listaProvas";
	}

	@RequestMapping("/excluirProva/{idProva}")
	public String excluirProva(@PathVariable long idProva) {
		provaDao.excluir(idProva);
		return "redirect: ../listaProvas";
	}

	// Post : salvar prova
	@RequestMapping("/salvarProva")
	public String salvarProva(Prova prova, int questoes[], HttpSession session) {
		List<QuestaoDaProva> questoesDaProva;
		if (prova.getId() == null) {
			prova.setData_criacao(data.getInstance());
			prova.setTipoEstadoProva(TipoEstadoProva.CRIADA);
			questoesDaProva = new ArrayList<>();

			for (int i = 0; i < questoes.length; i++) {
				questaoDaProva = new QuestaoDaProva();
				Questao questao = questaoDao.buscar(questoes[i]);

				if (questao.getNumero_uso() == 2) {
					questao.setTipoEstadoQuestao(TipoEstadoQuestao.SIMULADO);
				}
				questao.somarNumero_uso();
				questao.setDataReabertura(ConverterData.somarData());
				questaoDaProva.setQuestao(questao);
				questoesDaProva.add(questaoDaProva);
				questaoDao.alterar(questao);
			}

			prova.setIdProfessor(((Professor) (session.getAttribute("professorLogado"))).getId());
			prova.setQuestoesDaProva(questoesDaProva);
			provaDao.inserir(prova);

			return "redirect: agendarProva/" + prova.getId();

		} else {
			Prova prova2 = provaDao.buscar(prova.getId());
			questoesDaProva = new ArrayList<>();
			for (int i = 0; i < questoes.length; i++) {
				questaoDaProva = new QuestaoDaProva();
				// Inativar questão temporariamente
				questaoDaProva.setQuestao(questaoDao.buscar(questoes[i]));
				questoesDaProva.add(questaoDaProva);
			}

			prova2.setDescricao(prova.getDescricao());
			prova2.setCabecalho(prova.getCabecalho());
			prova2.setQuestoesDaProva(questoesDaProva);

			provaDao.alterar(prova2);

			return "redirect: editarProva/" + prova.getId();
		}

	}

	// Tela : Agendar prova
	@RequestMapping("/agendarProva/{idProva}")
	public String viewAgendarProva(@PathVariable int idProva, Model model) {
		Prova prova = provaDao.buscar(idProva);
		model.addAttribute("prova", prova);

		return "/usuario/professor/prova/agendar_prova";
	}

	// Post : Agendar prova
	@RequestMapping("/agendarProvaSistema/{idProva}")
	public String agendarProva(@PathVariable int idProva, int[] turmas, Long[] nota, String dataProva,
			String plataforma, String tempoProva, String[] tempoQuestao) throws ParseException {
		valor = 0;
		Prova prova = provaDao.buscar(idProva);
		tempo = 0;
		List<QuestaoDaProva> questoesDaProva = prova.getQuestoesDaProva();
		for (QuestaoDaProva questaoDaProva : questoesDaProva) {
			questaoDaProva.setNota(nota[questoesDaProva.lastIndexOf(questaoDaProva)]);
			valor += nota[questoesDaProva.lastIndexOf(questaoDaProva)];
			if (tempoProva == null) {
				long t = converterData.converterHora(tempoQuestao[questoesDaProva.lastIndexOf(questaoDaProva)]);
				tempo += t;
				questaoDaProva.setStringTempo(tempoQuestao[questoesDaProva.lastIndexOf(questaoDaProva)]);
				questaoDaProva.setTempo_questao(t);
			} else {
				prova.setStringTempoProva(null);
				prova.setStringTempoProva(tempoProva);
				questaoDaProva.setTempo_questao(null);
				questaoDaProva.setStringTempo(null);
			}
		}
		if (tempoProva == null) {
			prova.setData_final(converterData.somarDataHora(converterData.converterDataEHora(dataProva), tempo));
		} else {
			prova.setData_final(converterData.somarDataHora(converterData.converterDataEHora(dataProva),
					converterData.converterHora(tempoProva)));
		}
		for (int i = 0; i < turmas.length; i++) {
			turma = turmaDao.buscar(turmas[i]);
			listTurmas = prova.getTurmas();
			listTurmas.add(turma);
			provas = turma.getProvas();
			provas.add(prova);
			turma.setProvas(provas);
			turmaDao.alterar(turma);
		}
		if (plataforma.equalsIgnoreCase("desktop")) {
			prova.setTipoPlataforma(TipoPlataforma.DESKTOP);
		} else if (plataforma.equalsIgnoreCase("web")) {
			prova.setTipoPlataforma(TipoPlataforma.WEB);
		} else {
			prova.setTipoPlataforma(TipoPlataforma.FISICA);
		}
		prova.setTurmas(listTurmas);
		prova.setValor(valor);
		prova.setData_inicial(converterData.converterDataEHora(dataProva));
		prova.setTipoEstadoProva(TipoEstadoProva.AGENDADA);
		provaDao.alterar(prova);
		return "redirect: ../listaProvas";
	}

	// Get : Gerar prova automatica
	@RequestMapping(value = "/gerarProvaAutomatica", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<List<Questao>> gerarProva(String tipoDaQuestao, int numerQuestoes,
			Long[] marcSelecionados) {
		List<Questao> questoes;
		if (tipoDaQuestao.equalsIgnoreCase("mista")) {
			questoes = questaoDao.gerarProva(numerQuestoes, marcSelecionados);
		} else if (tipoDaQuestao.equalsIgnoreCase("objetiva")) {
			questoes = questaoDao.gerarProva(TipoQuestao.OBJETIVA, numerQuestoes, marcSelecionados);
		} else {
			questoes = questaoDao.gerarProva(TipoQuestao.DISSERTATIVA, numerQuestoes, marcSelecionados);
		}

		if (questoes != null) {
			return ResponseEntity.ok().body(questoes);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// Corrigir Prova

	// Tela de Turma que a prova foi aplicada
	@RequestMapping("/provaTurmas/{idProva}")
	public String provaTurmas(@PathVariable int idProva, Model model) {
		model.addAttribute("idProva", idProva);
		return "/usuario/professor/prova/prova_turmas";
	}

	// Tela : Provas dos alunos daquela turma
	@RequestMapping("/provaAlunos/{idTurma}/{idProva}")
	public String provaAlunos(@PathVariable int idTurma, @PathVariable int idProva, Model model) {
		model.addAttribute("idProva", idProva);
		model.addAttribute("idTurma", idTurma);
		return "/usuario/professor/prova/prova_alunos";
	}

	// Tela : Prova do aluno
	@RequestMapping("/provaDoAluno/{idProvaDoAluno}")
	public String provaDoAluno(@PathVariable Long idProvaDoAluno, Model model) {
		ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscar(idProvaDoAluno);
		model.addAttribute("provaDoAluno", provaDoAluno);
		return "/usuario/professor/prova/prova_aluno";
	}

	// Post : Corrigir questão
	@RequestMapping("/corrigirQuestao/{idProva}/{idResposta}")
	public String corrigirQuestao(@PathVariable Long idProva, @PathVariable Long idResposta, String parecer,
			Long nota) {
		notaTotal = 0;
		// Busco prova do aluno
		ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscar(idProva);
		// Busco resposta do aluno e corrigo
		RespostaDoAluno resposta = respostaDoAlunoDao.buscar(idResposta);
		resposta.setParecer(parecer);
		resposta.setNota(nota);
		respostaDoAlunoDao.alterar(resposta);
		// Atualiza nota fa prova
		for (RespostaDoAluno r : provaDoAluno.getRespostasDoAluno()) {
			notaTotal += r.getNota();
		}
		provaDoAluno.setNota(notaTotal);
		// Atualiza status da prova
		if (provaDoAlunoDao.provaJaCorrigida(idProva)) {
			provaDoAluno.setTipoEstadoProvaDoAluno(TipoEstadoProvaDoAluno.CORRIGIDA);
		}
		provaDoAlunoDao.alterar(provaDoAluno);

		return "redirect: ../../provaDoAluno/" + idProva;
	}

}
