package br.senai.informatica.sp.resolution.dao.questao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.model.questao.Resposta;
import br.senai.informatica.sp.resolution.model.questao.RespostaObjetiva;

@Repository
public class RespostaDao implements InterfaceDao<Resposta> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Resposta objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Resposta objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Resposta.class, id));
	}

	@Override
	public List<Resposta> listar() {
		TypedQuery<Resposta> query = manager.createQuery("select r from Resposta r", Resposta.class);
		return query.getResultList();
	}

	@Override
	public Resposta buscar(long id) {
		return manager.find(Resposta.class, id);
	}
	
	public boolean corrigirObjetiva(long id){
		TypedQuery<Resposta> query = manager.createQuery("select r from Resposta r where r.id = :id", Resposta.class);
		query.setParameter("id", id);
		
		try {
			RespostaObjetiva r = (RespostaObjetiva) query.getSingleResult();
			return r.getValor();
		} catch (Exception e) {
			e.printStackTrace();
			return (Boolean) null;
		}
		
		
	}
	
	

}
