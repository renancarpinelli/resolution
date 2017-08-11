package br.senai.informatica.sp.resolution.model.usuarios;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

@Entity
@DiscriminatorValue("Escola")
public class Escola extends Usuario{
	
	private String cnpj;
	@Column(columnDefinition="mediumblob")
	private byte[] documentacao;
	
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	public byte[] getDocumentacao() {
		return documentacao;
	}
	public void setDocumentacao(byte[] documentacao) {
		this.documentacao = documentacao;
	}	
	
	public String getDocumentacao64(){
		return Base64.encode(documentacao);
	}
	
	
}
