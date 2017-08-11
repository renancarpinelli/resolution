package br.senai.informatica.sp.resolution.restcontroller;

import java.util.ArrayList;
import java.util.Collections;
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
import br.senai.informatica.sp.resolution.dao.prova.QuestaoDaProvaDao;
import br.senai.informatica.sp.resolution.dao.questao.QuestaoDao;
import br.senai.informatica.sp.resolution.dao.questao.RespostaDao;
import br.senai.informatica.sp.resolution.dao.usuario.TurmaDao;
import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProva;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProvaDoAluno;
import br.senai.informatica.sp.resolution.enums.TipoEstadoTurma;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;
import br.senai.informatica.sp.resolution.model.prova.Prova;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;
import br.senai.informatica.sp.resolution.model.prova.QuestaoDaProva;
import br.senai.informatica.sp.resolution.model.prova.RespostaDoAluno;
import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.questao.Resposta;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;
import br.senai.informatica.sp.resolution.tools.RandomString;

@Transactional
@RestController
@RequestMapping("/services/aluno")
public class AlunoRestController {

	@Autowired
	private TurmaDao turmaDao;

	@Autowired
	private UsuarioDao usuarioDao;

	@Autowired
	private ProvaDao provaDao;

	@Autowired
	private ProvaDoAlunoDao provaDoAlunoDao;

	@Autowired
	private QuestaoDaProvaDao questaoDaProvaDao;

	@Autowired
	private RespostaDao respostaDao;

	@Autowired
	private QuestaoDao questaoDao;

	private List<Turma> turmas;
	private HashSet<Prova> hSet;
	private List<Prova> provas;
	private ProvaDoAluno provaDoAluno;
	private String codigo;
	private JSONObject jobProva;
	private JSONObject jobTurma;
	private JSONArray arrTurmas;
	private JSONArray arrProvas;


	@RequestMapping(value = "/turma/{idAluno}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Turma> listarTurmas(@PathVariable Long idAluno) {
		return turmaDao.listarTurmasAluno(idAluno, TipoEstadoTurma.ATIVO);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/turma/buscar/{codigoTurma}/{idAluno}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Turma> buscarTurma(@PathVariable String codigoTurma, @PathVariable Long idAluno) {
		boolean japossui = false;
		Turma turma = turmaDao.buscarCodigoAluno(codigoTurma);
		if ((turma != null)) {
			List<Turma> turmas = turmaDao.listarTurmasAluno(idAluno, TipoEstadoTurma.ATIVO);
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
			Aluno aluno = (Aluno) usuarioDao.buscar(job.getLong("idAluno"));
			List<Aluno> alunos = turma.getAlunos();
			alunos.add(aluno);
			turmaDao.alterar(turma);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
	

	@RequestMapping(value = "listarProvas/{idAluno}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Prova> listarProvas(@PathVariable Long idAluno) {
		turmas = turmaDao.listarTurmasAluno(idAluno, TipoEstadoTurma.ATIVO);
		hSet = new HashSet<Prova>();
		for (Turma turma : turmas) {
			for (Prova prova : turma.getProvas() ){
				if(prova.getTipoEstadoProva() == TipoEstadoProva.AGENDADA || prova.getTipoEstadoProva() == TipoEstadoProva.ABERTA){
					hSet.add(prova);
				}
			}
		}
		provas = new ArrayList<Prova>(hSet);
		
		System.out.println(provas.size());
		
		return provas;
	}

	@RequestMapping(value = "prova/{idAluno}/{idProva}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Void> liberarProva(@PathVariable Long idAluno, @PathVariable Long idProva) {
		try {
			if (!provaDoAlunoDao.provaJaCriada(idProva, idAluno)) {
				provaDoAluno = new ProvaDoAluno();
				codigo = RandomString.GerarString();
				provaDoAluno.setCodigo(codigo);
				provaDoAluno.setAluno((Aluno) usuarioDao.buscar(idAluno));
				provaDoAluno.setProva(provaDao.buscar(idProva));
				provaDoAlunoDao.inserir(provaDoAluno);
			}
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "iniciarProva/{idAluno}/{codigo}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<ProvaDoAluno> iniciarProva(@PathVariable Long idAluno, @PathVariable String codigo) {
		try {
			provaDoAluno = provaDoAlunoDao.buscar(idAluno, codigo);
			Prova prova = provaDoAluno.getProva();
			List<QuestaoDaProva> questoes = prova.getQuestoesDaProva();
			Collections.shuffle(questoes);					
			if (provaDoAluno.getTipoEstadoProvaDoAluno() == TipoEstadoProvaDoAluno.LIBERADA) {
				return ResponseEntity.ok(provaDoAluno);
			} else {
				return new ResponseEntity<ProvaDoAluno>(HttpStatus.UNAUTHORIZED);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "prova", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Void> finalizarProva(@RequestBody String json) {
		try {
			JSONObject job = new JSONObject(json);
			System.out.println(job);
			JSONArray arr = job.getJSONArray("questoesDaProva");
			String resposta;
			Long nota;
			Long notaProva = 0l;
			Long idQuestaoDaProva;
			ProvaDoAluno provaDoAluno = provaDoAlunoDao.buscar(job.getLong("id"));
			boolean dissertativa = false;
			List<RespostaDoAluno> respostasDoALuno = new ArrayList<>();
			QuestaoDaProva questaoDaProva;
			RespostaDoAluno respostaDoAluno;
			for (int i = 0; i < arr.length(); i++) {
				idQuestaoDaProva = (Long.parseLong(arr.get(i) + ""));

				questaoDaProva = questaoDaProvaDao.buscar(idQuestaoDaProva);
				respostaDoAluno = new RespostaDoAluno();
				resposta = job.getString(idQuestaoDaProva + "");
				nota = questaoDaProva.getNota();

				if (resposta.startsWith("%")) {
					if (respostaDao.corrigirObjetiva(Long.parseLong(resposta.substring(1)))) {
						respostaDoAluno.setNota(nota);
						respostaDoAluno.setTipoQuestao(TipoQuestao.OBJETIVA);
						notaProva += nota;
					} else {
						respostaDoAluno.setNota(0l);
					}
					respostaDoAluno.setResposta(resposta.substring(1));
				} else {
					dissertativa = true;
					respostaDoAluno.setTipoQuestao(TipoQuestao.DISSERTATIVA);
					respostaDoAluno.setResposta(resposta);
				}
				respostaDoAluno.setIdQuestaoDaProva(idQuestaoDaProva);
				respostasDoALuno.add(respostaDoAluno);
			}

			if (dissertativa) {
				provaDoAluno.setTipoEstadoProvaDoAluno(TipoEstadoProvaDoAluno.REALIZADA);
			} else {
				provaDoAluno.setTipoEstadoProvaDoAluno(TipoEstadoProvaDoAluno.CORRIGIDA);
			}

			provaDoAluno.setNota(notaProva);
			provaDoAluno.setRespostasDoAluno(respostasDoALuno);
			provaDoAlunoDao.alterar(provaDoAluno);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "prova/{idAluno}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> listaProvas(@PathVariable long idAluno) {
		turmas = turmaDao.listarTurmasAluno(idAluno);
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
	
	@RequestMapping(value = "prova/{idAluno}/{string}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> listaProvasInativas(@PathVariable long idAluno) {
		turmas = turmaDao.listarTurmasAluno(idAluno);
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
					arrProvas.put(jobProva);
				}
			}
			return ResponseEntity.ok(arrProvas.toString());
		} catch (JSONException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	

		
	@RequestMapping(value = "prova", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Void> liberarProvaQRCode(@RequestBody String json) {
		try {
			JSONObject job = new JSONObject(json);
			provaDoAluno = provaDoAlunoDao.buscar(job.getLong("idAluno"), job.getString("codigoProva"));
			provaDoAluno.setTipoEstadoProvaDoAluno(TipoEstadoProvaDoAluno.LIBERADA);
			provaDoAlunoDao.alterar(provaDoAluno);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
