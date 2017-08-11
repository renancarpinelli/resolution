<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />


<script>
function buscarAjax(url){
	var json;
	   jQuery.ajax({
	        url: '../services/professor/'+url ,
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
	   
	   var json = buscarAjax(tabela+'Prova/${professorLogado.id}');   
	   var tamanho = Object.keys(json).length;
	   var prova;
	   var dataCriacao;
	   var dataAplicacao;
	   var horaAplicacao;
	   var horaFinal;
	   var dataFinal;
	   var dataAtual = new Date();
	
	   console.log("Atual"+dataAtual)
	   	   
    		$('.'+tabela+'  > tbody > tr').remove();
    		var tbodyAtivo = $('.'+tabela+' > tbody');
    		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
    			prova = json[i]; 			  
    			  var btns="";
    			  dataCriacao = new Date(prova.data_criacao).toLocaleDateString();
    			  dataFinal = new Date(prova.data_final).toLocaleDateString();
    			  horaFinal =  new Date(prova.data_final).toLocaleTimeString();
    			  dataAplicacao = new Date(prova.data_inicial).toLocaleDateString();
				  horaAplicacao = new Date(prova.data_inicial).toLocaleTimeString();

    			  if(prova.tipoEstadoProva == "CRIADA"){ 	  				   
    				   btns = "<td> <a href='editarProva/"+prova.id+"'> <i class='material-icons'>description</i></a> </td>"
    			  }else if (prova.tipoEstadoProva == "AGENDADA"){
    				 
    				  btns = "<td>"+dataAplicacao +"  " + horaAplicacao +"</td>  <td> <a href='editarProva/"+prova.id+"'> <i class='material-icons'>description</i></a> </td> <td> <a href='agendarProva/"+prova.id+"'> <i class='material-icons'>date_range</i></a> </td>"
    			  }else if (prova.tipoEstadoProva == "ADIADA"){
    				  btns = "<td> <a href='editarProva/"+prova.id+"'> <i class='material-icons'>description</i></a> </td>  "
    				  
    			  }else if (prova.tipoEstadoProva == "FINALIZADA"){
    				  
    				  btns = "<td> <a href='provaTurmas/"+prova.id+"'> <i class='material-icons'>description</i></a> </td>  "
    			  }else if (prova.tipoEstadoProva == "ABERTA"){				 
    				  btns = "<td>"+dataAplicacao +"  " + horaAplicacao +"</td>  <td> "+ dataFinal+" "+ horaFinal  +" </td>"
    			  }    			  
    			  var linhas = "<tr id='linha_"+prova.id+"'> <td>"+prova.id+"</td><td>"+prova.descricao+"</td> <td>"+dataCriacao+"</td>"+btns+" </tr>";     			    			  
    				tbodyAtivo.append(linhas);    			
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
    	paginar("criada")
    	paginar("agendada")
    	paginar("aberta")
    	paginar("finalizada")
    	paginar("adiada")
    	});
    	
    	
    	function alerta(texto, type) {
    		$.notify(texto, {
    			type : type,
    			placement : {
    				from : 'top',
    				align : 'rigth'
    			}
    		});
    	}
    	
    	function getCurrentDate(){
    		var today = new Date();
    		var dd = today.getDate();
    		var mm = today.getMonth()+1; //January is 0!
    		var yyyy = today.getFullYear();
    		var hh = today.getHours();
    		var mm = today.getMinutes();
    		var ss = todal.getSeconds();
    		
    		if(dd<10) {
    		    dd='0'+dd
    		} 
    		if(mm<10) {
    		    mm='0'+mm
    		} 
    		return 	today = dd+'/'+mm+'/'+yyyy;
    	}
    	

</script>


<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Lista de Provas</li>
</ol>

<div class="col-md-2 ">
	<a class="btn btn-primary" href='<c:url value="criarProva"></c:url>'>
		Criar Prova
		<div class="ripple-container"></div>
	</a>
</div>


<div class="col-md-12">
	<div class="card card-nav-tabs">
		<div class="card-header" data-background-color="green">
			<div class="nav-tabs-navigation">
				<div class="nav-tabs-wrapper">
					<span class="nav-tabs-title">Provas:</span>
					<ul class="nav nav-tabs" data-tabs="tabs">
						<li class="active "><a href="#agendada" data-toggle="tab">
								<i class="material-icons">alarm_on</i> Agendadas
								<div class="ripple-container"></div>
						</a></li>
						<li class="col-md-offset-1"><a href="#criada"
							data-toggle="tab"> <i class="material-icons">done</i> Criadas
								<div class="ripple-container"></div></a></li>
						<li class="col-md-offset-1"><a href="#aberta"
							data-toggle="tab"> <i class="material-icons">create</i> Em
								andamento
								<div class="ripple-container"></div></a></li>
						<li class="col-md-offset-1"><a href="#finalizada"
							data-toggle="tab"> <i class="material-icons">assignment_turned_in</i>
								Finalizadas
								<div class="ripple-container"></div></a></li>
						<li class="col-md-offset-1"><a href="#adiada"
							data-toggle="tab"> <i class="material-icons">assignment_turned_in</i>
								Adiadas
								<div class="ripple-container"></div></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="card-content">
			<div class="tab-content table-responsive">
				<div class="tab-pane active" id="agendada">
					<table class="table agendada">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Dia em que foi criada</th>
								<th>Data de Aplicação</th>
								<th>Visualizar/Editar Prova</th>
								<th>Visualizar/Editar Data da Prova</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anterioragendada">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoagendada" class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximoagendada">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="criada">
					<table class="table criada">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Dia em que foi criada</th>
								<th>Visualizar/Editar Prova</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorcriada">
								Anterior
								<div class="ripple-container"></div>
							</button>

							<span id="numeracaocriada" class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximocriada">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="aberta">
					<table class="table aberta">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Dia em que foi criada</th>
								<th>Data de Aplicação</th>
								<th>Data de Final</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anterioraberta">
								Anterior
								<div class="ripple-container"></div>
							</button>

							<span id="numeracaoaberta" class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximoaberta">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="finalizada">
					<table class="table finalizada">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Data de Aplicação</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anteriorfinalizada">
								Anterior
								<div class="ripple-container"></div>
							</button>

							<span id="numeracaofinalizada" class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximofinalizada">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="adiada">
					<table class="table adiada">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Data de Criação</th>
								<th>Editar/Agendar</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12">
							<button class="btn btn-primary btn-sm pull-left"
								id="anterioradiada"">
								Anterior
								<div class="ripple-container"></div>
							</button>

							<span id="numeracaoadiada" " class=""></span>

							<button class="btn btn-primary btn-sm pull-right"
								id="proximoadiada"">
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
<c:if test="${provaBloqueada != null }">
	<script> 
      alerta("Você ja realizou essa prova !","danger")
      
      </script>

</c:if>





<c:import url="/WEB-INF/paginas/template/rodape.jsp" />