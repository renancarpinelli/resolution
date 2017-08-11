package br.senai.informatica.sp.resolution.dao.prova;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoProvaDoAluno;
import br.senai.informatica.sp.resolution.model.prova.ProvaDoAluno;

@Repository
public class ProvaDoAlunoDao implements InterfaceDao<ProvaDoAluno> {

	@PersistenceContext
	private EntityManager manager;
	
	@Override
	public void inserir(ProvaDoAluno objeto) {
		manager.persist(objeto);	
	}

	@Override
	public void alterar(ProvaDoAluno objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(ProvaDoAlunoDao.class, id));
	}

	@Override
	public List<ProvaDoAluno> listar() {
		TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa", ProvaDoAluno.class);
		return query.getResultList();
	}

	@Override
	public ProvaDoAluno buscar(long id) {
		return manager.find(ProvaDoAluno.class, id);
	}
	
	public ProvaDoAluno buscar(Long idAluno,String codigo) {
		TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa where pa.codigo = :codigo and pa.aluno.id = :idAluno", ProvaDoAluno.class);
	    query.setParameter("codigo", codigo); 
	    query.setParameter("idAluno", idAluno);
	    try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}
	
		
	public ProvaDoAluno buscarProvaDoAluno(long idProva, long idAluno) {
		try {
			TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa where pa.prova.id = :idProva and pa.aluno.id = :idAluno", ProvaDoAluno.class);
		    query.setParameter("idProva", idProva);
		    query.setParameter("idAluno", idAluno);
		    return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	public boolean provaJaCriada(long idProva, long idAluno) {
		try {
			TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa where pa.prova.id = :idProva and pa.aluno.id = :idAluno", ProvaDoAluno.class);
		    query.setParameter("idProva", idProva);
		    query.setParameter("idAluno", idAluno);
		    query.getSingleResult();
		    return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean provaJaRealizada(long idProva, long idAluno) {
		try {
			TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa where pa.prova.id = :idProva and pa.aluno.id = :idAluno and pa.tipoEstadoProvaDoAluno is null", ProvaDoAluno.class);
		    query.setParameter("idProva", idProva);
		    query.setParameter("idAluno", idAluno);
		    query.getSingleResult();
		    return false;
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		}
	}

	public boolean provaJaCorrigida(long idProva) {	
			TypedQuery<ProvaDoAluno> query = manager.createQuery("select pa from ProvaDoAluno pa join pa.respostasDoAluno r where pa.id = :idProva and r.nota is null", ProvaDoAluno.class);
		    query.setParameter("idProva", idProva);
		    List<ProvaDoAluno> provas = query.getResultList();		    
		    if(provas.isEmpty()){
		    	return true;
		    }else{
		    	return false;
		    }
	}
	
	
	
	
	
	

}
