package br.senai.informatica.sp.resolution.model.prova;

import java.util.Calendar;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import br.senai.informatica.sp.resolution.model.questao.Questao;
import br.senai.informatica.sp.resolution.model.usuarios.Turma;

@Entity
public class ProvaInterdisciplinar {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String cabecalho;
	private int numero_questoes;
	private Calendar data_inicial;

	@OneToMany
	private List<Questao> questoes;
	
	@OneToMany
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

	public int getNumero_questoes() {
		return numero_questoes;
	}

	public void setNumero_questoes(int numero_questoes) {
		this.numero_questoes = numero_questoes;
	}

	public Calendar getData_inicial() {
		return data_inicial;
	}

	public void setData_inicial(Calendar data_inicial) {
		this.data_inicial = data_inicial;
	}

	public List<Questao> getQuestoes() {
		return questoes;
	}

	public void setQuestoes(List<Questao> questoes) {
		this.questoes = questoes;
	}
}
