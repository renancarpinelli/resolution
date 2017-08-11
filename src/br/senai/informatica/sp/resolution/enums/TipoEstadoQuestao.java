package br.senai.informatica.sp.resolution.enums;

public enum TipoEstadoQuestao {
	
	ATIVO("Ativo"),SIMULADO("Simulado"),AGUARDANDO("Aguardando"),INATIVO("Inativo");
	
	private String tipo;
	
	
	private TipoEstadoQuestao(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return tipo;
	}
	

}
