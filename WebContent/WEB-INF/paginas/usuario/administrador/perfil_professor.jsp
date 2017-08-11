
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
				<h4 class="modal-title">Documentação Professor ${professor.nome }</h4>
			</div>
			<div class="modal-body">
				<img src='data:image/jpeg;base64,${professor.documentacao64 }'
					class="img-rounded img-responsive"
					style="height: 100%; width: 100%">
			</div>
			<div class="modal-footer">

				<a download="${professor.nome }"
					href="data:image/jpeg;base64,${professor.documentacao64 }"
					class="btn btn-warning btn-xs">Baixar Documento</a>

				<button type="button" class="btn btn-danger btn-simple"
					data-dismiss="modal">Fechar</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content"></div>
	</div>
</div>




<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<ol class="breadcrumb">
	<li><a href='<c:url value="../home"></c:url>'>Home</a></li>
	<li><a href='<c:url value="../listaProfessores"></c:url>'>Lista
			de Professores</a></li>
	<li class="active">Perfil Professor</li>
</ol>

<div class="col-md-12">
	<div class="card">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Professor ${professor.nome }</h4>
			<p class="category">Informções do perfil</p>
		</div>
		<div class="card-content">

			<div class="row">
				<div class="col-sm-4 ">
					<div class="form-group label-floating is-empty">
						<img src='data:image/jpeg;base64,${professor.foto64 }'
							class="img-rounded img-responsive" style="height: 300px">
					</div>
				</div>

				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">Nome</label> <input type="text"
							value="${professor.nome }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 ">
					<div class="form-group ">
						<label class="control-label">E-mail</label> <input type="text"
							value="${professor.email }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>



				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">CPF</label> <input type="text"
							value="${professor.cpf }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 ">
					<div class="form-group ">
						<label class="control-label">Celular</label> <input type="text"
							value="${professor.celular }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">Status</label> <input type="text"
							value="${professor.tipoEstadoUsuario }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 col-sm-offset-1" style="margin-top: 55px;">
					<button class="btn btn-info  btn-xs" data-toggle="modal"
						data-target="#myModal">
						<i class="material-icons">content_copy</i> Documentação
						<div class="ripple-container"></div>
					</button>
				</div>



			</div>

			<c:if test="${professor.tipoEstadoUsuario == 'AGUARDANDO' }">

				<a href='<c:url value="/adx/recusarProfessor/${professor.id}"></c:url>'
					class="btn btn-danger pull-left">Recusar</a>
				<a href='<c:url value="/adx/ativarProfessor/${professor.id}"></c:url>'
					class="btn btn-primary pull-right">Aceitar</a>

			</c:if>
			
			<c:if test="${professor.tipoEstadoUsuario == 'RECUSADO' }">

				<a href='<c:url value="/adx/ativarProfessor/${professor.id}"></c:url>'
					class="btn btn-primary pull-right">Aceitar</a>

			</c:if>


			<c:if test="${professor.tipoEstadoUsuario == 'ATIVO' }">

				<a href='<c:url value="/adx/inativarProfessor/${professor.id}"></c:url>'
					class="btn btn-danger pull-left">Inativar</a>

			</c:if>


			<c:if test="${professor.tipoEstadoUsuario == 'INATIVO' }">

				<a href='<c:url value="/adx/ativarProfessor/${professor.id}"></c:url>'
					class="btn btn-primary pull-right">Reativar</a>

			</c:if>
			<div class="clearfix"></div>

		</div>

	</div>



	<c:import url="/WEB-INF/paginas/template/rodape.jsp" />