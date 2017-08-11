package br.senai.informatica.sp.resolution.enums;

public enum TipoEstadoUsuario {

	ATIVO("Ativo"), INATIVO("Inativo"), AGUARDANDO("Aguardando"), RECUSADO("Recusado");

	private String tipo;

	private TipoEstadoUsuario(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}

}
