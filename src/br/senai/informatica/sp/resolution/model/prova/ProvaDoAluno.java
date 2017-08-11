 package br.senai.informatica.sp.resolution.model.prova;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import br.senai.informatica.sp.resolution.enums.TipoEstadoProvaDoAluno;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;

@Entity
public class ProvaDoAluno {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long nota;
	@Column(columnDefinition = "mediumblob")
	private byte[] qrCode;
	private String codigo;	
	@Column(columnDefinition = "tinyint(1)")
	private TipoEstadoProvaDoAluno tipoEstadoProvaDoAluno;
	
	@OneToOne
	private Aluno aluno;
	@OneToOne
	private Prova prova;
	@Fetch(FetchMode.SUBSELECT)
	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@OrderBy(value = "idQuestaoDaProva")
	private List<RespostaDoAluno> respostasDoAluno;

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

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public Prova getProva() {
		return prova;
	}

	public void setProva(Prova prova) {
		this.prova = prova;
	}


	public List<RespostaDoAluno> getRespostasDoAluno() {
		return respostasDoAluno;
	}

	public void setRespostasDoAluno(List<RespostaDoAluno> respostasDoAluno) {
		this.respostasDoAluno = respostasDoAluno;
	}

	public TipoEstadoProvaDoAluno getTipoEstadoProvaDoAluno() {
		return tipoEstadoProvaDoAluno;
	}

	public Aluno getAluno() {
		return aluno;
	}

	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}

	public void setTipoEstadoProvaDoAluno(TipoEstadoProvaDoAluno tipoEstadoProvaDoAluno) {
		this.tipoEstadoProvaDoAluno = tipoEstadoProvaDoAluno;
	}

	public byte[] getQrCode() {
		return qrCode;
	}

	public void setQrCode(byte[] qrCode) {
		this.qrCode = qrCode;
	}
	
	public String getQrCode64() {
		return Base64.encode(qrCode);
	}
		
}
