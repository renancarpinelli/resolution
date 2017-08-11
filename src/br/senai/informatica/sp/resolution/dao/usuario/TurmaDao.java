package br.senai.informatica.sp.resolution.dao.usuario;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoTurma;
import br.senai.informatica.sp.resolution.model.prova.Prova;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;

@Repository
public class TurmaDao implements InterfaceDao<Turma> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Turma objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Turma objeto) {
		manager.merge(objeto);

	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Turma.class, id));

	}

	@Override
	public List<Turma> listar() {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t", Turma.class);
		return query.getResultList();
	}

	public List<Aluno> listarAlunos(long idTurma) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t where t.id = :id", Turma.class);
		query.setParameter("id", idTurma);

		Turma turma = query.getSingleResult();
		List<Aluno> alunos = turma.getAlunos();
		return alunos;
	}

	public List<Turma> listarTurmasAluno(long idAluno) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t join t.alunos a where a.id = :id",
				Turma.class);
		query.setParameter("id", idAluno);
		return query.getResultList();
	}

	public List<Turma> listarTurmasAluno(long idAluno, TipoEstadoTurma tipoEstadoTurma) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t join t.alunos a where a.id = :id and t.tipoEstadoTurma = :tipoEstadoTurma ",
				Turma.class);
		query.setParameter("id", idAluno);
		query.setParameter("tipoEstadoTurma", tipoEstadoTurma);
		return query.getResultList();
	}

	public List<Turma> listarTurmasProva(long idProva) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t join t.provas p where p.id = :id",
				Turma.class);
		query.setParameter("id", idProva);
		return query.getResultList();
	}

	@Override
	public Turma buscar(long id) {
		return manager.find(Turma.class, id);
	}

	public Turma buscarCodigoProf(String codigo) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t where t.codigoProfessor = :codigo",
				Turma.class);
		query.setParameter("codigo", codigo);
		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	public Turma buscarCodigoAluno(String codigo) {
		TypedQuery<Turma> query = manager.createQuery("select t from Turma t where t.codigoAluno = :codigo",
				Turma.class);
		query.setParameter("codigo", codigo);
		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	public List<Turma> listarTurmas(long idProfessor) {
		TypedQuery<Professor> query = manager.createQuery("select p from Professor p where p.id = :id",
				Professor.class);
		query.setParameter("id", idProfessor);
		Professor professor = query.getSingleResult();
		List<Turma> turmas = professor.getTurmas();
		return turmas;
	}


}
