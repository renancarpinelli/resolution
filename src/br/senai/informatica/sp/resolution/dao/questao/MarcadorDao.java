package br.senai.informatica.sp.resolution.dao.questao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.model.questao.Marcador;

@Repository
public class MarcadorDao implements InterfaceDao<Marcador> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Marcador objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Marcador objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Marcador.class, id));
	}

	@Override
	public List<Marcador> listar() {
		TypedQuery<Marcador> query = manager.createQuery("select m from Marcador m", Marcador.class);
		return query.getResultList();
	}

	@Override
	public Marcador buscar(long id) {
		return manager.find(Marcador.class, id);
	}

}
