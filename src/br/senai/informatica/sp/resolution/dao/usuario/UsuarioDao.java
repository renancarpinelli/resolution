package br.senai.informatica.sp.resolution.dao.usuario;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import com.sun.org.apache.regexp.internal.recompile;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

import br.senai.informatica.sp.resolution.dao.InterfaceDao;
import br.senai.informatica.sp.resolution.enums.TipoEstadoUsuario;
import br.senai.informatica.sp.resolution.model.usuarios.Escola;
import br.senai.informatica.sp.resolution.model.usuarios.Professor;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;
import br.senai.informatica.sp.resolution.model.usuarios.Usuario;

@Repository
public class UsuarioDao implements InterfaceDao<Usuario> {

	@PersistenceContext
	private EntityManager manager;

	@Override
	public void inserir(Usuario objeto) {
		manager.persist(objeto);
	}

	@Override
	public void alterar(Usuario objeto) {
		manager.merge(objeto);
	}

	@Override
	public void excluir(long id) {
		manager.remove(manager.find(Usuario.class, id));
	}

	@Override
	public List<Usuario> listar() {
		TypedQuery<Usuario> query = manager.createQuery("select u from Usuario u order by u.nome", Usuario.class);
		return query.getResultList();
	}
	
	
	public List<Professor> listarProfessores() {		
		TypedQuery<Professor> query = manager.createQuery("select p from Professor p order by p.nome", Professor.class);
		return query.getResultList();
	}
	
	public List<Professor> listarProfessores(TipoEstadoUsuario estadoUsuario) {		
		TypedQuery<Professor> query = manager.createQuery("select p from Professor p where p.tipoEstadoUsuario = :estadoUsuario order by p.nome", Professor.class);
		query.setParameter("estadoUsuario", estadoUsuario);
		return query.getResultList();
	}
	

	
	
	public List<Escola> listarEscolas(TipoEstadoUsuario estadoUsuario) {		
		TypedQuery<Escola> query = manager.createQuery("select e from Escola e where e.tipoEstadoUsuario = :estadoUsuario order by e.nome", Escola.class);
		query.setParameter("estadoUsuario", estadoUsuario);
		return query.getResultList();
	}

	@Override
	public Usuario buscar(long id) {
		return manager.find(Usuario.class, id);
	}
	
	public boolean verificaEmail(String email){	
		TypedQuery<Usuario> query = manager.createQuery("select u from Usuario u where u.email = :email", Usuario.class);
		query.setParameter("email", email);
		
		if(query.getResultList().size() == 0){
			return true;
			}else{
			return false;
			}		
	}
	
	public Usuario logar(String email, String senha){
		TypedQuery<Usuario> query = manager.createQuery("Select u from Usuario u where cast(u.email as binary) = cast(:email as binary) and cast (u.senha as binary) = cast(:senha as binary) and u.tipoEstadoUsuario = :tipoEstadoUsuario ", Usuario.class);
		query.setParameter("email", email);
		query.setParameter("senha", senha);
		// Se o usuario nao for ativo, o login não pode ser concluido.
		query.setParameter("tipoEstadoUsuario", TipoEstadoUsuario.ATIVO);
		
		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}  
	}
	

}
