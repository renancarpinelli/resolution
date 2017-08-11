package br.senai.informatica.sp.resolution.model.usuarios;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import br.senai.informatica.sp.resolution.enums.TipoEstadoTurma;
import br.senai.informatica.sp.resolution.model.prova.Prova;

@JsonIgnoreProperties("professor")
@Entity
public class Turma {
	
	@Id
	@GeneratedValue (strategy=GenerationType.IDENTITY)
	private Long id;
	private String descricao;
	private String codigoAluno;
	private String codigoProfessor;
	private Long idProfessor; 
	
	private TipoEstadoTurma tipoEstadoTurma;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Aluno> alunos;
	
	@Fetch(FetchMode.SUBSELECT)
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "provas_turmas")
	private List<Prova> provas;
		
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getCodigoAluno() {
		return codigoAluno;
	}

	public void setCodigoAluno(String codigoAluno) {
		this.codigoAluno = codigoAluno;
	}

	public String getCodigoProfessor() {
		return codigoProfessor;
	}

	public Long getIdProfessor() {
		return idProfessor;
	}

	public void setIdProfessor(Long idProfessor) {
		this.idProfessor = idProfessor;
	}

	public void setCodigoProfessor(String codigoProfessor) {
		this.codigoProfessor = codigoProfessor;
	}
	
	public List<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public List<Prova> getProvas() {
		return provas;
	}

	public void setProvas(List<Prova> provas) {
		this.provas = provas;
	}

	public TipoEstadoTurma getTipoEstadoTurma() {
		return tipoEstadoTurma;
	}

	public void setTipoEstadoTurma(TipoEstadoTurma tipoEstadoTurma) {
		this.tipoEstadoTurma = tipoEstadoTurma;
	}

	
	
	
			
}
