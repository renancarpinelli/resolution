package br.senai.informatica.sp.resolution.enums;

public enum TipoQuestao {
	
	OBJETIVA("Objetiva"), DISSERTATIVA("Dissertativa");
	
	
private String tipo;
	
	
	private TipoQuestao(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return tipo;
	}
	

}
