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
	   
       var json = buscarAjax("../../services/professor/provaTurmas/${idProva }");   
	   var tamanho = Object.keys(json).length;
	   var turma;

	   	   
    		$('.'+tabela+'  > tbody > tr').remove();
    		var tbodyAtivo = $('.'+tabela+' > tbody');
    		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
    			turma = json[i];
    				tbodyAtivo.append($("<tr id='linha_"+turma.id+"'>")
    				    .append($("<td >").append(turma.id))  				  
    				    .append($("<td>").append(turma.descricao))
    				  	.append($("<td>").append("<a href='../provaAlunos/"+turma.id+"/${idProva }'> <i class='material-icons'>visibility</i></a>"))	
    			);  

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
    				paginar(tabela)
    				configBotoes(tabela);
    			}
    		});    		
    	}
    	
    	function configBotoes(tabela){
    		$("#proximo"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual > tamanho/qtdPorPagina+1);
    		$("#anterior"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual == 0);
    	}
    	
    	$(function(){ 	
    		paginar("ativa")
    	});
</script>


<div class="col-md-10 col-md-offset-1">
	<div class="card ">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Turmas</h4>
			<p class="category">Lista de turmas que realizaram a prova</p>
		</div>
		<div class="card-content">
			<div class="tab-content table-responsive">
				<div class="tab-pane active" id="ativa">
					<table class="table ativa">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descricao</th>
								<th>Ver provas</th>
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
			</div>
		</div>
	</div>
</div>




<c:import url="/WEB-INF/paginas/template/rodape.jsp" />