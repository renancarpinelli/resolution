package br.senai.informatica.sp.resolution.dao.prova;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.model.prova.RespostaDoAluno;
@Repository
public class RespostaDoAlunoDao implements InterfaceDao<RespostaDoAluno>{

	@PersistenceContext
	private EntityManager manager;
	
	@Override
	public void inserir(RespostaDoAluno objeto) {
		manager.persist(objeto);

		
	}

	@Override
	public void alterar(RespostaDoAluno objeto) {
		manager.merge(objeto);
		
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(RespostaDoAluno.class, id));
		
	}

	@Override
	public List<RespostaDoAluno> listar() {
		TypedQuery<RespostaDoAluno> query = manager.createQuery("Select ra from RespostaDoAluno ra", RespostaDoAluno.class);
		return query.getResultList();
	}

	@Override
	public RespostaDoAluno buscar(long id) {
		return manager.find(RespostaDoAluno.class, id);
	}

}
