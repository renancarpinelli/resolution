package br.senai.informatica.sp.resolution.model.prova;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import br.senai.informatica.sp.resolution.enums.TipoEstadoQuestao;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;

@Entity
public class RespostaDoAluno {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long idQuestaoDaProva;
	@Column(length = 4000)
	private String resposta;
	private Long nota;
	private String parecer;
	@Column(columnDefinition = "tinyint(1)")
	private TipoQuestao tipoQuestao;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public TipoQuestao getTipoQuestao() {
		return tipoQuestao;
	}

	public void setTipoQuestao(TipoQuestao tipoQuestao) {
		this.tipoQuestao = tipoQuestao;
	}

	public Long getIdQuestaoDaProva() {
		return idQuestaoDaProva;
	}

	public void setIdQuestaoDaProva(Long idQuestaoDaProva) {
		this.idQuestaoDaProva = idQuestaoDaProva;
	}

	public String getResposta() {
		return resposta;
	}

	public void setResposta(String resposta) {
		this.resposta = resposta;
	}




	public Long getNota() {
		return nota;
	}

	public void setNota(Long nota) {
		this.nota = nota;
	}

	public String getParecer() {
		return parecer;
	}

	public void setParecer(String parecer) {
		this.parecer = parecer;
	}
}
