package br.senai.informatica.sp.resolution.model.usuarios;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.databind.AnnotationIntrospector.ReferenceProperty.Type;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

@Entity
@DiscriminatorValue("Professor")
public class Professor extends Usuario {

	private String cpf;
	
	@Column(columnDefinition="mediumblob")
	private byte[] documentacao;
	
	@ManyToOne
	private Escola escola;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Turma> turmas;
	
	public String getCpf() {
		return cpf;
	}
	
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public byte[] getDocumentacao() {
		return documentacao;
	}

	public void setDocumentacao(byte[] documentacao) {
		this.documentacao = documentacao;
	}

	public Escola getEscola() {
		return escola;
	}

	public void setEscola(Escola escola) {
		this.escola = escola;
	}

	public String getDocumentacao64(){
		return Base64.encode(documentacao);
	}

	public List<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<Turma> turmas) {
		this.turmas = turmas;
	}

	

	
		
}
