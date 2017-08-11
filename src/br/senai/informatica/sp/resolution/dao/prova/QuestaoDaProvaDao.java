package br.senai.informatica.sp.resolution.dao.prova;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.model.prova.QuestaoDaProva;
import br.senai.informatica.sp.resolution.model.questao.Questao;

@Repository
public class QuestaoDaProvaDao implements InterfaceDao<QuestaoDaProva>{

	@PersistenceContext
	private EntityManager manager;
	
	@Override
	public void inserir(QuestaoDaProva objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(QuestaoDaProva objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(QuestaoDaProva.class, id));
	}

	@Override
	public List<QuestaoDaProva> listar() {
		TypedQuery<QuestaoDaProva> query = manager.createQuery("Select qp from QuestaoDaProva qp", QuestaoDaProva.class);
		return query.getResultList();
	}

	@Override
	public QuestaoDaProva buscar(long id) {
		return manager.find(QuestaoDaProva.class, id);
	}	

}
