function validaradio(){
	var myRadio = $('input[name=tipo]');
	
	var checkedValue = myRadio.filter(':checked').val();
	
	if(checkedValue == 'aluno'){
		 $("#cpf").show();
		 $("#cnpj").hide();
		 $("#documento").hide();
		 $('#form').attr('action', 'salvar_aluno');
	}else if(checkedValue == 'professor'){
		 $("#cpf").show();
		 $("#cnpj").hide();
		 $("#documento").show();
		 $('#form').attr('action', 'salvar_professor');
	}else if(checkedValue == 'escola'){
		$("#cpf").hide();
		 $("#cnpj").show();
		 $("#documento").show();
		$('#form').attr('action', 'salvar_escola');
	}else{
		
	}
	
}