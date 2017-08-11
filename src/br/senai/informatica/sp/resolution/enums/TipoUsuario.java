package br.senai.informatica.sp.resolution.enums;

public enum TipoUsuario {
	
	
	ALUNO("Aluno"),PROFESSOR("Professor"),ESCOLA("Escola"),ADMINISTRADOR("Administrador");

	private String tipo;

	private TipoUsuario(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}


}
