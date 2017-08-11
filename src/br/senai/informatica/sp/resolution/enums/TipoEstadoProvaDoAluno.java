package br.senai.informatica.sp.resolution.enums;

public enum TipoEstadoProvaDoAluno {
	
	LIBERADA("Liberada"),REALIZADA("Realizada"), CORRIGIDA("Corrigida"), ANULADA("Anulada");
	
	private String tipo;

	private TipoEstadoProvaDoAluno(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return tipo;
	}

}
