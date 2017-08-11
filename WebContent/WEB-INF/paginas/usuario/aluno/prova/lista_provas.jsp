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
		var provas = 0;
		var h;
		$('.' + tabela).empty();
		var tbody = $('.' + tabela);
		for (var i = 0; i < tamanho; i++) {

			prova = json[i];
			h = new Date();
			var horaFinal = new Date(prova.data_final);
			var horaInicial = new Date(prova.data_inicial);
			if (h >= horaInicial && h < horaFinal ) {
				if (prova.tipoPlataforma == 'DESKTOP') {
					btn = '<a class="btn btn-"> Abrir no desktop  </a>'
				} else {
					btn = '<a class="btn btn-success" href="realizarProva/'+prova.id+'" " > Iniciar Prova  </a>'
				}
				var div = '<div class="card col-md-12  questao"><div class="col-md-4"><label> Descrição </label><h6> '
						+ prova.descricao
						+ ' </h6></div><div class="col-md-4"><label> Fim da prova às: </label><h6> '
						+ horaFinal.toLocaleTimeString()
						+ ' </h6></div><div class="col-md-4">'
						+ btn
						+ '</div></div> '
			}
			
			tbody.append(div);

		}

	}

	$(function() {
		paginar("abertas")
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
	<li class="active">Realizar Prova</li>
</ol>

<div class="col-md-10 col-md-offset-1">
	<div class="card card-plain">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Provas ABERTAS</h4>
			<p class="category">Lista de provas que estão abertas para serem
				realizadas</p>
		</div>
	</div>

	<table class="table abertas">
				
	</table>
	


</div>







<c:import url="/WEB-INF/paginas/template/rodape.jsp" />