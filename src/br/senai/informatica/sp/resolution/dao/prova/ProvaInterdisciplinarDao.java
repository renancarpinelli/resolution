package br.senai.informatica.sp.resolution.dao.prova;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.model.prova.ProvaInterdisciplinar;

@Repository
public class ProvaInterdisciplinarDao implements InterfaceDao<ProvaInterdisciplinar>{
	
	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(ProvaInterdisciplinar objeto) {
		manager.persist(objeto);
		
	}

	@Override
	public void alterar(ProvaInterdisciplinar objeto) {
		manager.merge(objeto);
		
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(ProvaInterdisciplinar.class, id));
	}

	@Override
	public List<ProvaInterdisciplinar> listar() {
		TypedQuery<ProvaInterdisciplinar> query = manager.createQuery("select p from ProvaInterdisciplinar p", ProvaInterdisciplinar.class);
		return query.getResultList();
	}

	@Override
	public ProvaInterdisciplinar buscar(long id) {
		return manager.find(ProvaInterdisciplinar.class, id);
	}
	
	

}
