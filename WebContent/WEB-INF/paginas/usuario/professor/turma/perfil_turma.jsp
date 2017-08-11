<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />


<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					<i class="material-icons">clear</i>
				</button>

			</div>
			<div class="modal-body" style="text-align: center">
				<h5>Deseja realmente inativar esta turma ?</h5>
				<a href="../inativarTurma/${turma.id }"
					class="btn btn-danger btn-lg"> <i class="material-icons">clear</i>
					Inativar turma
				</a>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger btn-simple"
					data-dismiss="modal">Fechar</button>
			</div>
		</div>
	</div>
</div>


<c:import url="/WEB-INF/paginas/template/corpo.jsp" />


<script>
	function editar() {
		$('#descricao').removeAttr("disabled")
		$('#editar').hide();
		$('#salvar').show();
	};

	function cancelar() {
		$('#descricao').attr("disabled", "disabled");
		$('#salvar').hide();
		$('#editar').show();
	};

	$(document).ready(function() {
		$('#salvar').hide();

	});
</script>


<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li><a href='<c:url value="../listaTurmasProfessor"></c:url>'>Lista
			de Turmas</a></li>
	<li class="active">Perfil Turma</li>
</ol>
<div class="col-md-8 col-md-offset-2">


	<div class="card">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Turma ${turma.descricao }</h4>
			<p class="category">Informações da Turma</p>
		</div>
		<form action="../salvarTurma" method="get">
			<div class="card-content">

				<div class="row">
					<input type="text" name="id" value="${turma.id }"
						class="form-control" style="display: none">


					<div class="col-sm-3 col-sm-offset-2">
						<div class="form-group ">
							<label class="control-label ">Descrição</label> <input
								type="text" name="descricao" value="${turma.descricao }"
								class="form-control " id="descricao" disabled="disabled">
							<span class="material-input"></span>
						</div>
					</div>

					<div class="col-sm-3 col-sm-offset-2">
						<div class="form-group ">
							<label class="control-label ">Status da Turma</label> <input
								type="text" name="descricao" value="${turma.tipoEstadoTurma }"
								class="form-control " id="descricao" disabled="disabled">
							<span class="material-input"></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<div class="form-group ">
							<label class="control-label">Codigo para Alunos</label>
							<h6>${turma.codigoAluno }</h6>
						</div>
					</div>

					<div class="col-sm-3 col-sm-offset-2">
						<div class="form-group ">
							<label class="control-label">Codigo para Professores</label>
							<h6>${turma.codigoProfessor }</h6>
						</div>
					</div>
				</div>


				<div class="clearfix"></div>

			</div>
			<c:if test="${turma.tipoEstadoTurma == 'ATIVO' }">
				<c:if test="${turma.idProfessor == professorLogado.id }">
					<div class="col-md-12" id="editar">
						<button type="button" class="btn btn-primary pull-right"
							onclick="editar()">Editar</button>
					</div>

					<div class="col-md-12" id="salvar">
						<button type="button" class="btn btn-danger btn-xs pull-left"
							data-toggle="modal" data-target="#myModal"
							style="margin-top: 25px;">Inativar Turma</button>
						<input type="submit" class="btn btn-primary pull-right"
							value="Salvar" />

						<button type="button" class="btn btn-danger pull-right"
							onclick="cancelar()">Cancelar Edição</button>
					</div>
				</c:if>
			</c:if>
			<c:if test="${turma.idProfessor == professorLogado.id }">
			<c:if test="${turma.tipoEstadoTurma == 'INATIVO' }">
				<div class="col-md-12" id="editar">
					<a href="../ativarTurma/${turma.id }"
						class="btn btn-primary pull-right">Reativar turma</a>
				</div>

			</c:if>
</c:if>

		</form>
	</div>
</div>

<div class="col-md-12">
	<div class="card card-plain">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Lista de Alunos</h4>
			<p class="category">Alunos que fazem parte desta turma</p>
		</div>
		<div class="card-content table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>E-mail</th>
						<c:if test="${turma.idProfessor == professorLogado.id }">
							<th>Remover aluno</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="aluno" items="${turma.alunos }">
						<tr id="linha_${aluno.id }">
							<td>${aluno.id }</td>
							<td>${aluno.nome }</td>
							<td>${aluno.email }</td>
							<c:if test="${turma.idProfessor == professorLogado.id }">
								<td><a href="../remover_aluno_turma/${turma.id }/${aluno.id}" class>
										<i class="material-icons text-danger">clear</i>
								</a></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>




<c:import url="/WEB-INF/paginas/template/rodape.jsp" />