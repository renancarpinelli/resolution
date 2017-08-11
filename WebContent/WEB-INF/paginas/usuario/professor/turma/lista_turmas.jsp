<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<script>
function buscarAjax(url){
	var json;
	   jQuery.ajax({
	        url: url ,
	        type: "GET",
	        dataType: "json",
	        async: false,
	        success: function (data) {
	        	json = data;            
	        }
	    });	
	   return json;
}

var qtdPorPagina = 10;
var pagAtual = 0

   function paginar(tabela,tipoTurma){
	   
       var json = buscarAjax("../services/professor/turma/${professorLogado.id}");   
	   var tamanho = Object.keys(json).length;
	   var turma;
	   	   
    		$('.'+tabela+'  > tbody > tr').remove();
    		var tbodyAtivo = $('.'+tabela+' > tbody');
    		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
    			turma = json[i];
    	           if(turma.tipoEstadoTurma == tipoTurma){
    	        	   
    	          
    				tbodyAtivo.append($("<tr id='linha_"+turma.id+"'>")
    				    .append($("<td >").append(turma.id))  				  
    				    .append($("<td>").append(turma.descricao))
    				  	.append($("<td>").append("<a href='perfilTurma/"+turma.id+"'> <i class='material-icons'>visibility</i></a>"))	
    			);  
    	           }
    		}

    		$("#numeracao"+tabela).text("Página "+ (pagAtual+1)+ " de "+ Math.ceil(tamanho/qtdPorPagina));
    		
    		$("#proximo"+tabela).click(function(){
    			if(pagAtual < tamanho/qtdPorPagina-1){
    				pagAtual++;
    				paginar(tabela,tipoTurma);
    				configBotoes(tabela);
    			}
    		});
    		
    		$("#anterior"+tabela).click(function(){
    			if(pagAtual > 0){
    				pagAtual--;
    				paginar(tabela,tipoTurma);
    				configBotoes(tabela);
    			}
    		});    		
    	}
    	
    	function configBotoes(tabela){
    		$("#proximo"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual > tamanho/qtdPorPagina+1);
    		$("#anterior"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual == 0);
    	}
    	
    	$(function(){ 	
    		paginar("ativa","ATIVO")
    		paginar("inativa","INATIVO")
    	});

</script>



<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Turmas</li>
</ol>

<div class="col-md-2 col-md-offset-1">
	<a class="btn btn-primary" href='<c:url value="criarTurma"></c:url>'>
		Criar Turma
		<div class="ripple-container"></div>
	</a>
</div>

<div class="col-md-2">
	<a class="btn btn-primary" href='<c:url value="buscarTurmas"></c:url>'>
		Entrar em uma Turma
		<div class="ripple-container"></div>
	</a>
</div>

<div class="col-md-10 col-md-offset-1">
	<div class="card card-nav-tabs">
		<div class="card-header" data-background-color="green">
			<span class="nav-tabs-title">Turma:</span>
			<ul class="nav nav-tabs" data-tabs="tabs">
				<li class="active col-md-offset-1"><a href="#ativa"
					data-toggle="tab"> <i class="material-icons">done</i> Ativas
						<div class="ripple-container"></div></a></li>
				<li class="col-md-offset-1"><a href="#inativa"
					data-toggle="tab"> <i class="material-icons">clear</i> Inativas
						<div class="ripple-container"></div></a></li>
		</div>
		<div class="card-content">
			<div class="tab-content table-responsive">
				<div class="tab-pane active" id="ativa">
					<table class="table ativa">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descricao</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorativa">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoativa" class=""></span>
							<button class="btn btn-primary btn-sm pull-right"
								id="proximoativa">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane " id="inativa">
					<table class="table inativa">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descricao</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorinativa">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoinativa" class=""></span>
							<button class="btn btn-primary btn-sm pull-right"
								id="proximoinativa">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<c:import url="/WEB-INF/paginas/template/rodape.jsp" />