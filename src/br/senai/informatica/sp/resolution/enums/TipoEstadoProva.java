package br.senai.informatica.sp.resolution.enums;

public enum TipoEstadoProva {

	CRIADA("Criada"), AGENDADA("Agendada"), ADIADA("Adiada"), ABERTA("Aberta"), FINALIZADA("Finalizada");

	private String tipo;

	private TipoEstadoProva(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}

}
