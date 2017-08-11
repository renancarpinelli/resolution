package br.senai.informatica.sp.resolution.model.questao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.sun.org.apache.xml.internal.security.utils.Base64;

@Entity
public class RespostaObjetiva extends Resposta{

	private Boolean valor;
	@Column(columnDefinition = "mediumblob")
	private byte[] imagem;
	@Column(length=4000)
	private String descricao;
	
	public Boolean getValor() {
		return valor;
	}
	public void setValor(Boolean valor) {
		this.valor = valor;
	}
	
	public byte[] getImagem() {
		return imagem;
	}
	public void setImagem(byte[] imagem) {
		this.imagem = imagem;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String getImagem64(){
		return Base64.encode(imagem);
	}
	
}
