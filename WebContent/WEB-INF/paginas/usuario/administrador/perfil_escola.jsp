
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
				<h4 class="modal-title">Documentação Professor ${escola.nome }</h4>
			</div>
			<div class="modal-body">
				<img src='data:image/jpeg;base64,${escola.documentacao64 }'
					class="img-rounded img-responsive"
					style="height: 100%; width: 100%">
			</div>
			<div class="modal-footer">

				<a download="${escola.nome }"
					href="data:image/jpeg;base64,${escola.documentacao64 }"
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
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li><a href='<c:url value="/listaEscolas"></c:url>'>Lista
			de Escolas</a></li>
	<li class="active">Perfil Escola</li>
</ol>

<div class="col-md-12">
	<div class="card">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Escola ${escola.nome }</h4>
			<p class="category">Informções do perfil</p>
		</div>
		<div class="card-content">

			<div class="row">
				<div class="col-sm-4 ">
					<div class="form-group label-floating is-empty">
						<img src='data:image/jpeg;base64,${escola.foto64 }'
							class="img-rounded img-responsive" style="height: 300px">
					</div>
				</div>

				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">Nome</label> <input type="text"
							value="${escola.nome }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 ">
					<div class="form-group ">
						<label class="control-label">E-mail</label> <input type="text"
							value="${escola.email }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>



				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">CPF</label> <input type="text"
							value="${escola.cnpj }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 ">
					<div class="form-group ">
						<label class="control-label">Celular</label> <input type="text"
							value="${escola.celular }" class="form-control"
							disabled="disabled"> <span class="material-input"></span>
					</div>
				</div>

				<div class="col-sm-3 col-sm-offset-1">
					<div class="form-group ">
						<label class="control-label">Status</label> <input type="text"
							value="${escola.tipoEstadoUsuario }" class="form-control"
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

			<c:if test="${escola.tipoEstadoUsuario == 'AGUARDANDO' }">

				<a href='<c:url value="/recusarEscola/${escola.id}"></c:url>'
					class="btn btn-danger pull-left">Recusar</a>
				<a href='<c:url value="/ativarEscola/${escola.id}"></c:url>'
					class="btn btn-primary pull-right">Aceitar</a>

			</c:if>
			
			<c:if test="${escola.tipoEstadoUsuario == 'RECUSADO' }">

				<a href='<c:url value="/ativarEscola/${escola.id}"></c:url>'
					class="btn btn-primary pull-right">Aceitar</a>

			</c:if>


			<c:if test="${escola.tipoEstadoUsuario == 'ATIVO' }">

				<a href='<c:url value="/inativarEscola/${escola.id}"></c:url>'
					class="btn btn-danger pull-left">Inativar</a>

			</c:if>


			<c:if test="${escola.tipoEstadoUsuario == 'INATIVO' }">

				<a href='<c:url value="/ativarEscola/${escola.id}"></c:url>'
					class="btn btn-primary pull-right">Reativar</a>

			</c:if>
			
			<div class="clearfix"></div>

		</div>

	</div>



	<c:import url="/WEB-INF/paginas/template/rodape.jsp" />