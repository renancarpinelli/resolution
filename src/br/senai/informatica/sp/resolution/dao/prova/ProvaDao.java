package br.senai.informatica.sp.resolution.dao.prova;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProva;
import br.senai.informatica.sp.resolution.enums.TipoEstadoQuestao;
import br.senai.informatica.sp.resolution.model.prova.Prova;

@Repository
public class ProvaDao implements InterfaceDao<Prova> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Prova objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Prova objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Prova.class, id));
	}

	@Override
	public List<Prova> listar() {
		TypedQuery<Prova> query = manager.createQuery("select p from Prova p", Prova.class);
		return query.getResultList();
	}
	
	
	public List<Prova> listar(long idProfessor, TipoEstadoProva estadoProva) {
		TypedQuery<Prova> query = manager.createQuery("select p from Prova p where p.idProfessor = :id and p.tipoEstadoProva = :estadoProva", Prova.class);
		query.setParameter("id", idProfessor);
		query.setParameter("estadoProva", estadoProva);
		return query.getResultList();
	}
	
	public void verificarProvasFinalizadas(){
		TypedQuery<Prova> query = manager.createQuery("select p from Prova p where p.data_final < CURRENT_TIMESTAMP", Prova.class);	
		List<Prova> provas = query.getResultList();	
		for (Prova prova : provas) {
			prova.setTipoEstadoProva(TipoEstadoProva.FINALIZADA);
			alterar(prova);
		}	
	}
	
	public void verificarProvasAbertas(){
		TypedQuery<Prova> query = manager.createQuery("select p from Prova p where p.tipoEstadoProva = :estadoProva and p.data_inicial < CURRENT_TIMESTAMP  and p.data_final > CURRENT_TIMESTAMP", Prova.class);
		query.setParameter("estadoProva", TipoEstadoProva.AGENDADA);		
		List<Prova> provas = query.getResultList();	
		for (Prova prova : provas) {
			prova.setTipoEstadoProva(TipoEstadoProva.ABERTA);
			alterar(prova);
		}	
	}
	
	

	@Override
	public Prova buscar(long id) {
		return manager.find(Prova.class, id);
	}

}
