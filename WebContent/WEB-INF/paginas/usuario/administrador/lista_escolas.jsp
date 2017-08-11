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

   function paginar(tabela){
	   
	   var json = buscarAjax(tabela+"Escolas");   
	   var tamanho = Object.keys(json).length;
	   var escola;
	   	   
    		$('.'+tabela+'  > tbody > tr').remove();
    		var tbodyAtivo = $('.'+tabela+' > tbody');
    		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
    			escola = json[i];
    			if(escola.tipoEstadoUsuario == (tabela).toUpperCase()){
    				tbodyAtivo.append(
    				    $("<tr id='linha_"+escola.id+"'>")
    				    .append($("<td >").append(escola.id))
    				    .append($("<td>").append(escola.nome))
    				    .append($("<td>").append(escola.email))	
    				  	.append($("<td>").append("<a href='perfilEscola/"+escola.id+"'> <i class='material-icons'>visibility</i></a>"))	
    			);
    			}
    		}

    		$("#numeracao"+tabela).text("Página "+ (pagAtual+1)+ " de "+ Math.ceil(tamanho/qtdPorPagina));
    		
    		$("#proximo"+tabela).click(function(){
    			if(pagAtual < tamanho/qtdPorPagina-1){
    				pagAtual++;
    				paginar(tabela);
    				configBotoes(tabela);
    			}
    		});
    		
    		$("#anterior"+tabela).click(function(){
    			if(pagAtual > 0){
    				pagAtual--;
    				paginar(tabela);
    				configBotoes(tabela);
    			}
    		});    		
    	}
    	
    	function configBotoes(tabela){
    		$("#proximo"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual > tamanho/qtdPorPagina+1);
    		$("#anterior"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual == 0);
    	}
    	
    	$(function(){ 	
    		paginar("ativo")
    		paginar("inativo")
    		paginar("aguardando")
    		paginar("recusado")
    	});

</script>


<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Professores</li>
</ol>


<div class="col-md-6">
	<div class="card card-nav-tabs">
		<div class="card-header" data-background-color="green">
			<div class="nav-tabs-navigation">
				<div class="nav-tabs-wrapper">
					<span class="nav-tabs-title">Escolas do Sistema:</span>
					<ul class="nav nav-tabs" data-tabs="tabs">
						<li class="active"><a href="#ativo" data-toggle="tab"> <i
								class="material-icons">verified_user</i> Ativos
								<div class="ripple-container"></div></a></li>
						<li class=""><a href="#inativo" data-toggle="tab"> <i
								class="material-icons">block</i> Inativos
								<div class="ripple-container"></div></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="card-content">
			<div class="tab-content table-responsive">
				<div class="tab-pane active" id="ativo">
					<table class="table ativo">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Nome</th>
								<th>E-mail</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorativo">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoativo" class=""></span>
							<button class="btn btn-primary btn-sm pull-right"
								id="proximoativo">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="inativo">
					<table class="table inativo">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Nome</th>
								<th>E-mail</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorinativo">
								Anterior
								<div class="ripple-container"></div>
							</button>

							<span id="numeracaoinativo" class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximoinativo">
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


<div class="col-md-6">
	<div class="card card-nav-tabs">
		<div class="card-header" data-background-color="green">
			<div class="nav-tabs-navigation">
				<div class="nav-tabs-wrapper">
					<span class="nav-tabs-title">Escolas em Aguardo:</span>
					<ul class="nav nav-tabs" data-tabs="tabs">
						<li class="active"><a href="#aguardando" data-toggle="tab"> <i
								class="material-icons">verified_user</i> Aguardando
								<div class="ripple-container"></div></a></li>
						<li class=""><a href="#recusado" data-toggle="tab"> <i
								class="material-icons">block</i> Recudados
								<div class="ripple-container"></div></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="card-content">
			<div class="tab-content table-responsive">
				<div class="tab-pane active" id="aguardando">
					<table class="table aguardando">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Nome</th>
								<th>E-mail</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anterioraguardando">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoaguardando" class=""></span>
							<button class="btn btn-primary btn-sm pull-right"
								id="proximoaguardando">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				
				<div class="tab-pane " id="recusado">
					<table class="table recusado">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Nome</th>
								<th>E-mail</th>
								<th>Mais Informações</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorrecusado">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaorecusado" class=""></span>
							<button class="btn btn-primary btn-sm pull-right"
								id="proximorecusado">
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