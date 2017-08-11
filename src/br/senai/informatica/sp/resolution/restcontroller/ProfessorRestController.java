package br.senai.informatica.sp.resolution.restcontroller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import br.senai.informatica.sp.resolution.dao.prova.ProvaDao;
import br.senai.informatica.sp.resolution.dao.prova.ProvaDoAlunoDao;
import br.senai.informatica.sp.resolution.dao.questao.QuestaoDao;
import br.senai.informatica.sp.resolution.dao.usuario.TurmaDao;
import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProva;
import br.senai.informatica.sp.resolution.model.prova.Prova;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;
import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;

@Transactional
@RestController
@RequestMapping("/services/professor")
public class ProfessorRestController {

	@Autowired
	private UsuarioDao usuarioDao;

	@Autowired
	private TurmaDao turmaDao;

	@Autowired
	private QuestaoDao questaoDao;

	@Autowired
	private ProvaDao provaDao;

	@Autowired
	private ProvaDoAlunoDao provaDoAlunoDao;

	private List<Turma> turmas;
	private List<Prova> provas;
	private JSONObject jobProva;
	private JSONObject jobTurma;
	private JSONArray arrTurmas;
	private JSONArray arrProvas;
	private HashSet<Prova> hSet;

	@RequestMapping(value = "/turma/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Turma> listarTurmasAtivas(@PathVariable Long idProfessor) {
		return turmaDao.listarTurmas(idProfessor);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/turma/buscar/{codigoTurma}/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Turma> buscarTurma(@PathVariable String codigoTurma, @PathVariable Long idProfessor) {
		boolean japossui = false;
		Turma turma = turmaDao.buscarCodigoProf(codigoTurma);
		if ((turma != null)) {
			List<Turma> turmas = turmaDao.listarTurmas(idProfessor);
			for (Turma t : turmas) {
				if (turma.getId() == t.getId()) {
					japossui = true;
				}
			}
			if (japossui) {
				return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
			} else {
				return ResponseEntity.ok(turma);
			}
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(method = RequestMethod.POST, value = "/turma/entrar", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Void> entrarTurma(@RequestBody String json) {

		try {
			JSONObject job = new JSONObject(json);
			Turma turma = turmaDao.buscar(job.getLong("idTurma"));
			Professor professor = (Professor) usuarioDao.buscar(job.getLong("idProfessor"));
			List<Turma> turmas = turmaDao.listarTurmas(professor.getId());
			turmas.add(turma);
			professor.setTurmas(turmas);
			usuarioDao.alterar(professor);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	// Parte de Questões

	@RequestMapping(method = RequestMethod.GET, value = "/questoes/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Questao> listarQuestoesProfessor(@PathVariable Long idProfessor) {
		return questaoDao.listarProfessor(idProfessor);
	}
	
	
	@RequestMapping(method = RequestMethod.GET, value = "/questoesInativas/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Questao> listarQuestoesInativasProfessor(@PathVariable Long idProfessor) {
		return questaoDao.listarProfessorInativas(idProfessor);
	}

	// Listagem de provas

	@RequestMapping(value = "criadaProva/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvasCriadas(@PathVariable long idProfessor) {
		provaDao.verificarProvasAbertas();
		provaDao.verificarProvasFinalizadas();
		return provaDao.listar(idProfessor, TipoEstadoProva.CRIADA);
	}

	@RequestMapping(value = "agendadaProva/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvasAgendadas(@PathVariable long idProfessor) {
		return provaDao.listar(idProfessor, TipoEstadoProva.AGENDADA);
	}

	@RequestMapping(value = "abertaProva/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvasAplicadas(@PathVariable long idProfessor) {
		return provaDao.listar(idProfessor, TipoEstadoProva.ABERTA);
	}

	@RequestMapping(value = "finalizadaProva/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvasCorrigidas(@PathVariable long idProfessor) {
		return provaDao.listar(idProfessor, TipoEstadoProva.FINALIZADA);
	}

	@RequestMapping(value = "adiadaProva/{idProfessor}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvasCanceladas(@PathVariable long idProfessor) {
		return provaDao.listar(idProfessor, TipoEstadoProva.ADIADA);
	}

	@RequestMapping(value = "provaTurma/{idProva}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Turma> listarTurma(@PathVariable long idProva) {
		return turmaDao.listarTurmasProva(idProva);
	}

	@RequestMapping(value = "prova/{idProfessor}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> listaProvas(@PathVariable long idProfessor) {
		turmas = turmaDao.listarTurmas(idProfessor);
		arrProvas = new JSONArray();
		hSet = new HashSet<Prova>();
		try {
			for (Turma turma : turmas) {
				hSet.addAll(turma.getProvas());
			}
			provas = new ArrayList<Prova>(hSet);
			for (Prova prova : provas) {
				if (prova.getTipoEstadoProva() != TipoEstadoProva.FINALIZADA) {
					jobProva = new JSONObject();
					jobProva.put("id", prova.getId());
					jobProva.put("descricao", prova.getDescricao());
					jobProva.put("dataProva", prova.getData_inicial().getTimeInMillis());
					jobProva.put("tipoEstadoProva", prova.getTipoEstadoProva().toString());
					turmas = prova.getTurmas();
					arrTurmas = new JSONArray();
					for (Turma turma : turmas) {
						jobTurma = new JSONObject();
						jobTurma.put("id", turma.getId());
						jobTurma.put("descricao", turma.getDescricao());
						arrTurmas.put(jobTurma);
					}
					jobProva.put("turmas", arrTurmas);
					arrProvas.put(jobProva);
				}
			}
			return ResponseEntity.ok(arrProvas.toString());
		} catch (JSONException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "prova/{idProfessor}/{string}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> listaProvasInativas(@PathVariable long idProfessor) {

		turmas = turmaDao.listarTurmas(idProfessor);
		arrProvas = new JSONArray();
		hSet = new HashSet<Prova>();
		try {
			for (Turma turma : turmas) {
				hSet.addAll(turma.getProvas());
			}
			provas = new ArrayList<Prova>(hSet);
			for (Prova prova : provas) {
				if (prova.getTipoEstadoProva() == TipoEstadoProva.FINALIZADA) {
					jobProva = new JSONObject();
					jobProva.put("id", prova.getId());
					jobProva.put("descricao", prova.getDescricao());
					jobProva.put("dataProva", prova.getData_inicial().getTimeInMillis());
					jobProva.put("tipoEstadoProva", prova.getTipoEstadoProva().toString());
					turmas = prova.getTurmas();
					arrTurmas = new JSONArray();
					for (Turma turma : turmas) {
						jobTurma = new JSONObject();
						jobTurma.put("id", turma.getId());
						jobTurma.put("descricao", turma.getDescricao());
						arrTurmas.put(jobTurma);
					}
					jobProva.put("turmas", arrTurmas);
					arrProvas.put(jobProva);
				}
			}
			return ResponseEntity.ok(arrProvas.toString());
		} catch (JSONException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "provaTurmas/{idProva}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Turma> provaTurmas(@PathVariable long idProva) {
		return turmaDao.listarTurmasProva(idProva);
	}

	@RequestMapping(value = "provaAlunos/{idProva}/{idTurma}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<ProvaDoAluno> provaAlunos(@PathVariable long idProva, @PathVariable long idTurma) {

		Turma turma = turmaDao.buscar(idTurma);
		List<Aluno> alunos = turma.getAlunos();
		List<ProvaDoAluno> provasDosAlunos = new ArrayList<>();
		for (Aluno aluno : alunos) {
			ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscarProvaDoAluno(idProva, aluno.getId());
			if (provaDoAluno != null) {
				provasDosAlunos.add(provaDoAluno);
			}
		}

		return provasDosAlunos;
	}

	@RequestMapping(value = "provaRelatorio/{idProva}/{idTurma}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> provaRelatorio(@PathVariable long idProva, @PathVariable long idTurma) {
        long media = 0l;
		Turma turma = turmaDao.buscar(idTurma);
		List<Aluno> alunos = turma.getAlunos();
		List<ProvaDoAluno> provasDosAlunos = new ArrayList<>();
		for (Aluno aluno : alunos) {
			ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscarProvaDoAluno(idProva, aluno.getId());
			if (provaDoAluno != null) {
				provasDosAlunos.add(provaDoAluno);
			}
		}

		try {
			jobTurma = new JSONObject();
			jobTurma.put("id", turma.getId());
			jobTurma.put("descricaoTurma", turma.getDescricao());
			jobTurma.put("descricaoProva",  provasDosAlunos.get(0).getProva().getDescricao() );
			JSONArray arrAlunos = new JSONArray();
			for (ProvaDoAluno provaDoAluno : provasDosAlunos) {
				JSONObject jobAluno = new JSONObject();
				jobAluno.put("id", provaDoAluno.getId());
				jobAluno.put("nome", provaDoAluno.getAluno().getNome());
				jobAluno.put("nota", provaDoAluno.getNota() +"/"+ provaDoAluno.getProva().getValor());
				media += provaDoAluno.getNota();
				arrAlunos.put(jobAluno);
			}
			jobTurma.put("media", (media/provasDosAlunos.size()));
			jobTurma.put("alunos", arrAlunos);	
			return ResponseEntity.ok(jobTurma.toString());
			
		} catch (JSONException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

}
