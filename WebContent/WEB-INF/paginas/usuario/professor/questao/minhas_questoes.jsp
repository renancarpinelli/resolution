<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<style>
.questao {
	padding: 20px;
}

.label {
	margin-left: 5px;
}
</style>


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

var qtdPorPagina = 5;
var pagAtual = 0

   function paginar(tabela){
	   
       var json = buscarAjax("../services/professor/questoes/${professorLogado.id}");   
	   var tamanho = Object.keys(json).length;
	   var questao;
	   

    		
	   $('.questoes').empty();
		var tbody = $('.questoes');
   		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
   			questao = json[i];
   			var marcadores = '';
   			for (var j = 0 ; j < (questao.marcadores).length ; j++){
   				marcadores += '<span class="label label-success">' + (questao.marcadores[j].descricao) + '</span>';
   			}   			
   			var resposta = '';
   			for (var z = 0 ; z < (questao.respostas).length ; z++){   						   			   				
   				if(questao.tipoQuestao == 'DISSERTATIVA'){
   					resposta += '<div class="row" > <div class="col-md-10"> <label >Resposta Esperada</label> '+ questao.respostas[z].resp_esperada+' </div> </div>';
   				}else{
   					if(questao.respostas[z].valor == true){
   						resposta += '<div class="row  text-success"> <div class="col-md-10">  <label > Alternativa Correta </label>'  + questao.respostas[z].descricao+ ' </div>  </div>';
   					}
   				}
   			}    			
   			var texto ='<div  class="card questao"><div class="row"><div class="col-md-2 "><div class="form-group "><label class="">Tipo deQuestão</label><h6>'+questao.tipoQuestao+'</h6></div></div><div class="col-md-2 col-md-offset-1"><div class="form-group "><label class="">Nivel de Dificuldade</label><h6>'+questao.nivel_dificuldade+' </h6></div></div><div class="col-md-4 col-md-offset-1"><div class="form-group "><label class="">Marcadores</label><h6>'+marcadores+'</div></div></div><div class="row"><div class="col-md-10"><div class="form-group "><label class="control-label">Enunciado</label>'+questao.descricao+'</div></div></div><div class="row"><div class="col-md-10 "> <div class="form-group ">  '+resposta+'</div></div></div><div class="row"><div class="col-md-12 "> <a class="btn btn-primary btn-sm pull-right" href="editar_questao/'+questao.id+'"> Editar Questão </a></div></div></div>'
   			tbody.append(texto);     		    				
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
    	});

</script>

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Minhas Questões</li>
</ol>

<div class="col-md-12 col-md-offset-1">
<a class="btn btn-primary" href='<c:url value="criarQuestao"></c:url>'>
	Criar Questão
	<div class="ripple-container"></div>
</a>

<a class="btn btn-danger" href='<c:url value="listasMinhasQuestoesInativas"></c:url>'>
	Questões Inativas 
	<div class="ripple-container"></div>
</a>
 </div>

<div class="col-md-10 col-md-offset-1">
	<div class="card card-plain">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Questões</h4>
			<p class="category">Lista de questões</p>
		</div>
	</div>

	<div class="questoes"></div>


	<div class="card-footer text-center">
		<div class="col-md-12">
			<button class="btn btn-primary btn-sm pull-left" id="anteriorativo">
				Anterior
				<div class="ripple-container"></div>
			</button>
			<span id="numeracaoativo" class=""></span>
			<button class="btn btn-primary btn-sm pull-right" id="proximoativo">
				Proximo
				<div class="ripple-container"></div>
			</button>
		</div>
	</div>
</div>

<c:import url="/WEB-INF/paginas/template/rodape.jsp" />