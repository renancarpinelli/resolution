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

	$(function() {
		$('.select-tools').selectize({
			maxItems : 3,
			valueField : 'id',
			labelField : 'descricao',
			searchField : 'descricao',
			options : buscarAjax("../listarMarcadores"),
			create : false,
		});
	});
</script>


<style>
.buscar {
	background-color: #fff;
	border-radius: 10px;
	padding-top: 20px;
	padding-bottom: 20px;
}

.card {
	box-shadow: 0 1px 10px 1px rgba(0, 0, 0, 0.14);
}
</style>


<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Simulado</li>
</ol>

<div class="col-md-10  col-md-offset-1">
	<div class="card card-plain">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Gerar Simulado</h4>
		</div>
	</div>
</div>

<div class="col-md-10 col-md-offset-1 buscar">
	<form method="post" action="gerarSimulado">
		<div class="col-md-9">
			<div class="col-md-12">
				<div class="col-md-6 col-md-offset-1">
					<label> Tipo de Questões</label> <select name="tipoDaQuestao"
						id="tipoDaQuestao" class="form-control input-lg"
						style="margin-top: 0px;">
						<option value="objetiva">Objetiva</option>
						<option value="dissertativa">Dissertativa</option>
						<option value="Mista">Mista</option>
					</select> <span class="material-input"></span>
				</div>
				<div class="col-md-4 col-md-offset-1">
					<div class="form-group ">
						<label class="control-label">Numero de Questões</label> <input
							type="number" min="0" max="20" id="numerQuestoes"
							required="required" name="numerQuestoes" class="form-control">
						<span class="material-input"></span>
					</div>
				</div>
				<div class="col-md-10 col-md-offset-1">

					<label> Marcadores </label> <select name="marcSelecionados"
						required class="select-tools" multiple
						placeholder="Escolha um marcador...">
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-3" style="padding-top: 50px;">
			<button type="submit" class="btn btn-lg btn-primary">
				<i class="material-icons">description</i> Gerar Simulado
				<div class="ripple-container"></div>
			</button>
			</button>
		</div>
	</form>
</div>


<c:if test="${erro != null }">
	<div class="row">
		<div class="col-md-4 col-md-offset-2">
			<script type="text/javascript">
				$
						.notify(
								'Nosso banco de questões não possui a quantidade suficiente ',
								{
									type : 'danger',
									placement : {
										from : 'top',
										align : 'center'
									}
								});
			</script>
		</div>
	</div>
</c:if>
<c:import url="/WEB-INF/paginas/template/rodape.jsp" />