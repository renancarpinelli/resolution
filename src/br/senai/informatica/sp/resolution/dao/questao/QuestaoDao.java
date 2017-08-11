package br.senai.informatica.sp.resolution.dao.questao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoQuestao;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;
import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.usuarios.Usuario;

@Repository
public class QuestaoDao implements InterfaceDao<Questao> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Questao objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Questao objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Questao.class, id));
	}

	@Override
	public List<Questao> listar() {
		TypedQuery<Questao> query = manager.createQuery("select q from Questao q", Questao.class);
		return query.getResultList();
	}

	public List<Questao> listarProfessor(long idProfessor) {
		TypedQuery<Questao> query = manager.createQuery("select q from Questao q where q.id_professor = :id and q.tipoEstadoQuestao = :tipoQuestao",
				Questao.class);
		query.setParameter("id", idProfessor);
		query.setParameter("tipoQuestao", TipoEstadoQuestao.ATIVO);
		return query.getResultList();
	}
	
	
	public List<Questao> listarProfessorInativas(long idProfessor) {
		TypedQuery<Questao> query = manager.createQuery("select q from Questao q where q.id_professor = :id and q.tipoEstadoQuestao = :tipoQuestao",
				Questao.class);
		query.setParameter("id", idProfessor);
		query.setParameter("tipoQuestao", TipoEstadoQuestao.INATIVO);
		return query.getResultList();
	}

	// public List<Questao> listarBusca(TipoQuestao tipoQuestao) {
	// TypedQuery<Questao> query = manager.createQuery("select q from Questao q
	// where q.tipoQuestao = :tipoQuestao ",
	// Questao.class);
	// query.setParameter("tipoQuestao", tipoQuestao);
	// return query.getResultList();
	// }

	public List<Questao> listarBusca(TipoQuestao tipoQuestao, int nivelDificuldade, long marcador) {
		TypedQuery<Questao> query = manager.createQuery(
				"select q from Questao q join q.marcadores m where m.id = :marcador and q.tipoQuestao = :tipoQuestao  and q.nivel_dificuldade = :nivelDificuldade and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
				Questao.class);
		query.setParameter("tipoQuestao", tipoQuestao);
		query.setParameter("nivelDificuldade", nivelDificuldade);
		query.setParameter("marcador", marcador);
		query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);

		return query.getResultList();
	}

	public List<Questao> listarBusca(TipoQuestao tipoQuestao, int nivelDificuldade, long marcador1, long marcador2) {
		TypedQuery<Questao> query = manager.createQuery(
				"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2) and q.tipoQuestao = :tipoQuestao  and q.nivel_dificuldade = :nivelDificuldade and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
				Questao.class);
		query.setParameter("tipoQuestao", tipoQuestao);
		query.setParameter("nivelDificuldade", nivelDificuldade);
		query.setParameter("marcador1", marcador1);
		query.setParameter("marcador2", marcador2);
		query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		return query.getResultList();
	}

	public List<Questao> listarBusca(TipoQuestao tipoQuestao, int nivelDificuldade, long marcador1, long marcador2,
			long marcador3) {
		TypedQuery<Questao> query = manager.createQuery(
				"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2 or  m.id = :marcador3) and q.tipoQuestao = :tipoQuestao  and q.nivel_dificuldade = :nivelDificuldade and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
				Questao.class);
		query.setParameter("tipoQuestao", tipoQuestao);
		query.setParameter("nivelDificuldade", nivelDificuldade);
		query.setParameter("marcador1", marcador1);
		query.setParameter("marcador2", marcador2);
		query.setParameter("marcador3", marcador3);
		query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		return query.getResultList();
	}

	// public List<Questao> listaBusca(int quantidade, long marcador1, long
	// marcador2, long marcador3) {
	// TypedQuery<Questao> query = manager.createQuery(
	// "select q from Questao q join q.marcadores m where (m.id = :marcador1 or
	// m.id = :marcador2 or m.id = :marcador3) )",
	// Questao.class);
	// query.setParameter("marcador1", marcador1);
	// query.setParameter("marcador2", marcador2);
	// query.setParameter("marcador3", marcador3);
	// try {
	// return query.getResultList().subList(0, quantidade);
	// } catch (Exception e) {
	// return null;
	// }
	// }

	public List<Questao> gerarProva(int quantidade, Long[] marcSelecionados) {
		TypedQuery<Questao> query;
		if (marcSelecionados.length == 1) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1) and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		} else if (marcSelecionados.length == 2) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2) and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		} else {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2 or  m.id = :marcador3) and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("marcador3", marcSelecionados[2]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		}
		try {
			return query.getResultList().subList(0, quantidade);
		} catch (Exception e) {
			return null;
		}
	}

	public List<Questao> gerarProva(TipoQuestao tipoQuestao, int quantidade, Long[] marcSelecionados) {
		TypedQuery<Questao> query;
		if (marcSelecionados.length == 1) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1) and q.tipoQuestao = :tipoQuestao and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		} else if (marcSelecionados.length == 2) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2) and q.tipoQuestao = :tipoQuestao and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		} else {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2 or  m.id = :marcador3) and q.tipoQuestao = :tipoQuestao and (q.dataReabertura < CURRENT_TIMESTAMP or q.dataReabertura is null ) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("marcador3", marcSelecionados[2]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.ATIVO);
		}
		try {
			return query.getResultList().subList(0, quantidade);
		} catch (Exception e) {
			return null;
		}
	}

	public List<Questao> gerarSimulado(int quantidade, Long[] marcSelecionados) {
		TypedQuery<Questao> query;
		if (marcSelecionados.length == 1) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		} else if (marcSelecionados.length == 2) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		} else {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2 or  m.id = :marcador3) and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("marcador3", marcSelecionados[2]);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		}
		try {
			return query.getResultList().subList(0, quantidade);
		} catch (Exception e) {
			return null;
		}
	}

	public List<Questao> gerarSimulado(TipoQuestao tipoQuestao, int quantidade, Long[] marcSelecionados) {
		TypedQuery<Questao> query;
		if (marcSelecionados.length == 1) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1) and q.tipoQuestao = :tipoQuestao and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		} else if (marcSelecionados.length == 2) {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2) and q.tipoQuestao = :tipoQuestao and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		} else {
			query = manager.createQuery(
					"select q from Questao q join q.marcadores m where (m.id = :marcador1 or m.id = :marcador2 or  m.id = :marcador3) and q.tipoQuestao = :tipoQuestao and q.tipoEstadoQuestao = :tipoEstadoQuestao",
					Questao.class);
			query.setParameter("marcador1", marcSelecionados[0]);
			query.setParameter("marcador2", marcSelecionados[1]);
			query.setParameter("marcador3", marcSelecionados[2]);
			query.setParameter("tipoQuestao", tipoQuestao);
			query.setParameter("tipoEstadoQuestao", TipoEstadoQuestao.SIMULADO);
		}
		try {
			return query.getResultList().subList(0, quantidade);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public Questao buscar(long id) {
		return manager.find(Questao.class, id);
	}

}
