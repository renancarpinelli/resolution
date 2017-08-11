<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li><a href='<c:url value="listaTurmasAluno"></c:url>'>Lista
			de Turmas</a></li>
	<li class="active">Buscar Turma</li>
</ol>

<div class="col-md-8 col-md-offset-2">
	<div class="card">
		<div class="card-header" style="text-align: center;"
			data-background-color="green">
			<h4 class="title">Buscar Turma</h4>
		</div>
		<div class="card-content">
			<form action="buscarTurmaAluno" method="post">
				<div class="row">
					<div class="col-md-4 col-md-offset-2">
						<div class="form-group label-floating">
							<label class="control-label">Código da turma </label> <input
								required="required" type="number" name="codigo"
								class="form-control"> <span class="material-input"></span>
						</div>
					</div>
					<div class="col-md-3 col-md-offset-2">
						<button type="submit" class="btn btn-primary btn-sm pull-right">
							<i class="material-icons">search</i> Buscar Turma
						</button>
					</div>
			</form>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-2">
				<c:if test="${turma.id != null }">

					<h4>Descrição da Turma: ${turma.descricao }</h4>
			</div>

			<div class="col-md-3 col-md-offset-2">
				<form action="entrarTurmaAluno/${turma.id }" method="post">
					<button type="submit" class="btn btn-primary  pull-right">Entrar
						na Turma</button>
			</div>
			</form>
			</c:if>
		</div>
		<c:if test="${erro != null }">
			<div class="row">
				<div class="col-md-4 col-md-offset-2">
					<script type="text/javascript">
						$.notify('Turma não encontrada', {
							type : 'danger',
							placement : {
								from : 'top',
								align : 'right'
							}
						});
					</script>
				</div>
			</div>
		</c:if>

		<c:if test="${erroentrar != null }">
			<div class="row">
				<div class="col-md-4 col-md-offset-2">
					<script type="text/javascript">
						$.notify('Você já está nessa turma ! ', {
							type : 'danger',
							placement : {
								from : 'top',
								align : 'right'
							}
						});
					</script>
				</div>
			</div>
		</c:if>

		<div class="clearfix"></div>

	</div>
</div>
</div>





<c:import url="/WEB-INF/paginas/template/rodape.jsp" />