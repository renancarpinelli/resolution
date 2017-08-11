<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>






<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />



<script type="text/javascript">
	$(window)
			.load(
					function() {
						$
								.notify(
										' ${alunoLogado.nome} ${professorLogado.nome} seja bem vindo ao Resolution ! ',
										{
											type : 'success',
											placement : {
												from : 'top',
												align : 'center'
											}
										});
					});

	function cancelar() {
		$('.cancelar').hide();
		$('.salvar').hide();
		$('.editar').show();
	}

	function editar() {
		$('.cancelar').show();
		$('.salvar').show();
		$('.editar').hide();
	}
	
</script>



<c:if test="${alunoLogado != null}">
	<div class="col-md-12">

		<div class="col-md-6 col-md-offset-3">
			<div class="card card-profile">
				<div class="card-avatar">
					<a href="#pablo"> <img class="img"
						src="data:image/jpeg;base64,${alunoLogado.foto64 }">
					</a>
				</div>

				<div class="content">
					<h6 class="category text-gray">Aluno</h6>
					<h4 class="card-title">${alunoLogado.nome }</h4>
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">E-mail</label> <input type="text"
									class="form-control" disabled="" value="${alunoLogado.email }">
								<span class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Celular</label> <input type="text"
									class="form-control" name="celular"
									value="${alunoLogado.celular }"> <span
									class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Senha</label> <input
									type="password" class="form-control"
									value="${alunoLogado.senha }"> <span
									class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Confirmar senha</label> <input
									type="password" class="form-control" name="celular"
									value="${alunoLogado.senha }"> <span
									class="material-input"></span>
							</div>
						</div>

					</div>
					<div class="col-md-12">

						<a onclick="cancelar()"
							class="btn btn-danger btn-sm pull-left cancelar"
							style="display: none;">Cancelar</a> <a onclick="editar()"
							class="btn btn-primary btn-sm pull-right editar">Editar</a>
						<button type="submit"
							class="btn btn-primary btn-sm pull-right salvar"
							style="display: none;">Salvar</button>
					</div>
				</div>
			</div>
		</div>


	</div>
</c:if>
<c:if test="${professorLogado != null}">
	<div class="col-md-12">
		<div class="col-md-6 col-md-offset-3">
			<div class="card card-profile">
				<div class="card-avatar">
					<a href="#pablo"> <img class="img"
						src="data:image/jpeg;base64,${professorLogado.foto64 }">
					</a>
				</div>

				<div class="content">
					<h6 class="category text-gray">Professor</h6>
					<h4 class="card-title">${professorLogado.nome }</h4>
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">E-mail</label> <input type="text"
									class="form-control" disabled="" value="${professorLogado.email }">
								<span class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Celular</label> <input type="text"
									class="form-control" name="celular"
									value="${professorLogado.celular }"> <span
									class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Senha</label> <input
									type="password" class="form-control"
									value="${professorLogado.senha }"> <span
									class="material-input"></span>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group label-floating">
								<label class="control-label">Confirmar senha</label> <input
									type="password" class="form-control" name="celular"
									value="${professorLogado.senha }"> <span
									class="material-input"></span>
							</div>
						</div>

					</div>
					<div class="col-md-12">

						<a onclick="cancelar()"
							class="btn btn-danger btn-sm pull-left cancelar"
							style="display: none;">Cancelar</a> <a onclick="editar()"
							class="btn btn-primary btn-sm pull-right editar">Editar</a>
						<button type="submit"
							class="btn btn-primary btn-sm pull-right salvar"
							style="display: none;">Salvar</button>
					</div>
				</div>
			</div>
		</div>


	</div>
</c:if>

<c:import url="/WEB-INF/paginas/template/rodape.jsp" />