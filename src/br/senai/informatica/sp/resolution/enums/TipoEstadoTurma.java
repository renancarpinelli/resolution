package br.senai.informatica.sp.resolution.enums;

public enum TipoEstadoTurma {

	ATIVO("Ativo"), INATIVO("Inativo");

	private String tipo;

	private TipoEstadoTurma(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}

}
