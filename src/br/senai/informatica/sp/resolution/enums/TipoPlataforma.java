package br.senai.informatica.sp.resolution.enums;

public enum TipoPlataforma {
	
	WEB("Web"), DESKTOP("Desktop"), FISICA("Fisica"); 
	
	private String tipo;

	private TipoPlataforma(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}

}
