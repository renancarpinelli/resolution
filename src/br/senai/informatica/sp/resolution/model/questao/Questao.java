package br.senai.informatica.sp.resolution.model.questao;

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

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

import com.sun.org.apache.xml.internal.security.utils.Base64;

import br.senai.informatica.sp.resolution.enums.TipoEstadoQuestao;
import br.senai.informatica.sp.resolution.enums.TipoQuestao;

@Entity
public class Questao {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long id_professor;
    @Column(length=4000)
	private String descricao;
	@Column(columnDefinition = "mediumblob")
	private byte[] imagem;
	private int nivel_dificuldade;
	private int numero_uso = 0;
	private int numero_alternativas;
	private float avaliacao;
	
	@Column(columnDefinition="tinyint(1)")
	private TipoEstadoQuestao tipoEstadoQuestao;
	@Column(columnDefinition="tinyint(1)")
	private TipoQuestao tipoQuestao; // Dissestativa / Objetiva
	
	@Fetch(FetchMode.SUBSELECT)
	@ManyToMany(fetch = FetchType.EAGER)
	private List<Marcador> marcadores;
	
	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Resposta> respostas;
	
	private Calendar dataReabertura; 
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId_professor() {
		return id_professor;
	}

	public Calendar getDataReabertura() {
		return dataReabertura;
	}

	public void setDataReabertura(Calendar dataReabertura) {
		this.dataReabertura = dataReabertura;
	}

	public void setId_professor(Long id_professor) {
		this.id_professor = id_professor;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public int getNivel_dificuldade() {
		return nivel_dificuldade;
	}

	public void setNivel_dificuldade(int nivel_dificuldade) {
		this.nivel_dificuldade = nivel_dificuldade;
	}

	public int getNumero_uso() {
		return numero_uso;
	}

	public void setNumero_uso(int numero_uso) {
		this.numero_uso = numero_uso;
	}
	
	public void somarNumero_uso(){
	     this.numero_uso ++;
	}

	public float getAvaliacao() {
		return avaliacao;
	}

	public void setAvaliacao(float avaliacao) {
		this.avaliacao = avaliacao;
	}

	public TipoEstadoQuestao getTipoEstadoQuestao() {
		return tipoEstadoQuestao;
	}

	public void setTipoEstadoQuestao(TipoEstadoQuestao tipoEstadoQuestao) {
		this.tipoEstadoQuestao = tipoEstadoQuestao;
	}

	public TipoQuestao getTipoQuestao() {
		return tipoQuestao;
	}

	public void setTipoQuestao(TipoQuestao tipoQuestao) {
		this.tipoQuestao = tipoQuestao;
	}

	public List<Marcador> getMarcadores() {
		return marcadores;
	}

	public void setMarcadores(List<Marcador> marcadores) {
		this.marcadores = marcadores;
	}

	public List<Resposta> getRespostas() {
		return respostas;
	}

	public void setRespostas(List<Resposta> respostas) {
		this.respostas = respostas;
	}

	public byte[] getImagem() {
		return imagem;
	}

	public void setImagem(byte[] imagem) {
		this.imagem = imagem;
	}
	
	public String getImagem64(){
		return Base64.encode(imagem);
	}

	public int getNumero_alternativas() {
		return numero_alternativas;
	}

	public void setNumero_alternativas(int numero_alternativas) {
		this.numero_alternativas = numero_alternativas;
	}
	
	
	
}
