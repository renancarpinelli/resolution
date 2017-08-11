package br.senai.informatica.sp.resolution.model.usuarios;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import br.senai.informatica.sp.resolution.enums.TipoEstadoUsuario;
import br.senai.informatica.sp.resolution.enums.TipoUsuario;

// teste ddo commit

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "pertence_a_classe")
public class Usuario {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nome;
	private String email;
	private String senha;
	@Column(columnDefinition = "mediumblob")
	private byte[] foto;
	private String celular;
	@Column(columnDefinition = "tinyint(1)")
	private TipoEstadoUsuario tipoEstadoUsuario;
	@Column(columnDefinition = "tinyint(1)")
	private TipoUsuario tipoUsuario;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public byte[] getFoto() {
		return foto;
	}

	public void setFoto(byte[] foto) {
		this.foto = foto;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public TipoEstadoUsuario getTipoEstadoUsuario() {
		return tipoEstadoUsuario;
	}

	public void setTipoEstadoUsuario(TipoEstadoUsuario tipoEstadoUsuario) {
		this.tipoEstadoUsuario = tipoEstadoUsuario;
	}

	public String getFoto64() {
		return Base64.encode(foto);
	}

	public TipoUsuario getTipoUsuario() {
		return tipoUsuario;
	}

	public void setTipoUsuario(TipoUsuario tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}

}
