package br.senai.informatica.sp.resolution.model.prova;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import br.senai.informatica.sp.resolution.model.questao.Questao;

@Entity
public class QuestaoDaProva {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long nota;
	private Long tempo_questao;
	private String stringTempo;

	@OneToOne
	private Questao questao;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getNota() {
		return nota;
	}

	public void setNota(Long nota) {
		this.nota = nota;
	}

	public Long getTempo_questao() {
		return tempo_questao;
	}

	public void setTempo_questao(Long tempo_questao) {
		this.tempo_questao = tempo_questao;
	}

	public Questao getQuestao() {
		return questao;
	}

	public void setQuestao(Questao questao) {
		this.questao = questao;
	}

	public String getStringTempo() {
		return stringTempo;
	}

	public void setStringTempo(String stringTempo) {
		this.stringTempo = stringTempo;
	}

	

	
		
}
