package br.senai.informatica.sp.resolution.model.questao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
public class RespostaDissertativa extends Resposta {

	@Column(length=4000)
	private String resp_esperada;

	public String getResp_esperada() {
		return resp_esperada;
	}

	public void setResp_esperada(String resp_esperada) {
		this.resp_esperada = resp_esperada;
	}
	
	
	
	
}
