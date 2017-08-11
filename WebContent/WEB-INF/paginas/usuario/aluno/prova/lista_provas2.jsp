<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<script>
	function buscarAjax(url) {
		var json;
		jQuery.ajax({
			url : url,
			type : "GET",
			dataType : "json",
			async : false,
			success : function(data) {
				json = data;
			}
		});
		return json;
	}

	var json
	function paginar(tabela) {
		json = buscarAjax("../services/aluno/listarProvas/${alunoLogado.id}");
		var tamanho = Object.keys(json).length;
		var prova;
		var btn = '';
		var horaFinal;
		var horaInicial;
		var provas = 0;
		var h;
 		$('.'+tabela+'  > tbody > tr').remove();
		var tbody = $('.'+tabela+' > tbody');
		for (var i = 0; i < tamanho; i++) {
			var linhas = '';
			prova = json[i];
			h = new Date();
			var horaFinal = new Date(prova.data_final);
			var horaInicial = new Date(prova.data_inicial);
			dataAplicacao = horaInicial.toLocaleDateString();
			horaAplicacao = horaInicial.toLocaleTimeString();
			
           if (h < horaFinal && tabela == 'agendada'){    
        	   linhas = "<tr id='linha_"+prova.id+"'> <td>"+prova.id+"</td><td>"+prova.descricao+"</td> <td>"+dataAplicacao +"  " + horaAplicacao +"</td></tr>";    		      	    
			}else if ( h >= horaInicial  &&  h > horaFinal  && tabela == 'finalizada'){
				 var btns = "<td> <a href='provaAluno/"+prova.id+"/${alunoLogado.id}'> <i class='material-icons'>visibility</i></a> </td>"
	       		 linhas = "<tr id='linha_"+prova.id+"'> <td>"+prova.id+"</td><td>"+prova.descricao+"</td> <td>"+dataAplicacao +"  " + horaAplicacao +"</td>"+btns+" </tr>";   
			}			
			tbody.append(linhas);
		}

	}

	$(function() {
		paginar("agendada")
		paginar("finalizada")
	});


</script>


<style>
.questao {
	padding: 10px;
	text-align: center;
	margin: 5px 0;
}

.abertas{
min-height: 300px;
}
</style>



<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Lista de Prova</li>
</ol>

</div>

<div class="col-md-10 col-md-offset-1">
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
						<li class="col-md-offset-1"><a href="#finalizada"
							data-toggle="tab"> <i class="material-icons">assignment_turned_in</i>
								Finalizadas
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
								<th>Data de Aplicação</th>
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
				<div class="tab-pane" id="finalizada">
					<table class="table finalizada">
						<thead class="text-primary">
							<tr>
								<th>Id</th>
								<th>Descrição</th>
								<th>Data de Aplicação</th>
								<th>Ver nota</th>
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
			</div>
		</div>
	</div>	
</div>






<c:import url="/WEB-INF/paginas/template/rodape.jsp" />