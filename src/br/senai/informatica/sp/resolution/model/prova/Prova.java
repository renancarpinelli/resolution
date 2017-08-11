package br.senai.informatica.sp.resolution.model.prova;

import java.util.Calendar;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import br.senai.informatica.sp.resolution.enums.TipoEstadoProva;
import br.senai.informatica.sp.resolution.enums.TipoPlataforma;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;

@JsonIgnoreProperties("turmas")
@Entity
public class Prova {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long idProfessor;
	@Column(length=4000)
	private String cabecalho;
	private String descricao;
	private Long valor;
	private Calendar data_criacao;
	private Calendar data_inicial;
	private Calendar data_final;
	private String stringTempoProva;
	@Column(columnDefinition = "tinyint(1)")
	private TipoEstadoProva tipoEstadoProva;
	@Column(columnDefinition = "tinyint(1)")
	private TipoPlataforma tipoPlataforma;

	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@OrderBy(value = "id")
	private List<QuestaoDaProva> questoesDaProva;
	
	@Fetch(FetchMode.SUBSELECT)
	@ManyToMany(mappedBy="provas",fetch = FetchType.EAGER)
	private List<Turma> turmas;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCabecalho() {
		return cabecalho;
	}

	public void setCabecalho(String cabecalho) {
		this.cabecalho = cabecalho;
	}

	public Calendar getData_inicial() {
		return data_inicial;
	}

	public void setData_inicial(Calendar data_inicial) {
		this.data_inicial = data_inicial;
	}

	public Calendar getData_final() {
		return data_final;
	}

	public void setData_final(Calendar data_final) {
		this.data_final = data_final;
	}

	public TipoEstadoProva getTipoEstadoProva() {
		return tipoEstadoProva;
	}

	public void setTipoEstadoProva(TipoEstadoProva tipoEstadoProva) {
		this.tipoEstadoProva = tipoEstadoProva;
	}

	public TipoPlataforma getTipoPlataforma() {
		return tipoPlataforma;
	}

	public void setTipoPlataforma(TipoPlataforma tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}

	public List<QuestaoDaProva> getQuestoesDaProva() {
		return questoesDaProva;
	}

	public void setQuestoesDaProva(List<QuestaoDaProva> questoesDaProva) {
		this.questoesDaProva = questoesDaProva;
	}

	public Calendar getData_criacao() {
		return data_criacao;
	}

	public void setData_criacao(Calendar data_criacao) {
		this.data_criacao = data_criacao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Long getIdProfessor() {
		return idProfessor;
	}

	public void setIdProfessor(Long idProfessor) {
		this.idProfessor = idProfessor;
	}

	public String getStringTempoProva() {
		return stringTempoProva;
	}



	public Long getValor() {
		return valor;
	}

	public void setValor(Long valor) {
		this.valor = valor;
	}

	public void setStringTempoProva(String stringTempoProva) {
		this.stringTempoProva = stringTempoProva;
	}

	public List<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<Turma> turmas) {
		this.turmas = turmas;
	}
	
	
    
	
	
}
