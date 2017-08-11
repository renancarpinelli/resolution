<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!--   <link rel="apple-touch-icon" sizes="76x76" href="assets/img/favicon.ico">-->

<title>Cadastro</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />



<c:import url="/WEB-INF/paginas/template/imports.jsp" />


<link
	href="<c:url value="/resources/css/material-bootstrap-wizard.css"/>"
	rel="stylesheet" />

<script
	src="<c:url value="/resources/bootstrap/js/material-bootstrap-wizard.js"/>"></script>

<script src="<c:url value="/resources/js/form.js"/>"></script>
<script src="<c:url value="/resources/jquery/jquery.validate.min.js"/>"></script>
<script src="<c:url value="/resources/jquery/jquery-mask.js"/>"></script>


</head>

<body>
	<div class="image-container set-full-height"
		style="background-image: url(<c:url value="/resources/img/wizard-profile.jpg"/>)">
		

		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<!--      Wizard container        -->
					<div class="wizard-container">
						<div class="card wizard-card" data-color="green"
							id="wizardProfile">
							<form action="" method="post" id="form"
								enctype="multipart/form-data">

								<div class="wizard-header">
									<h3 class="wizard-title">Fazendo seu Cadastro</h3>
									<h5>Essas informações vão deixar-nos saber mais sobre
										você.</h5>
								</div>
								<div class="wizard-navigation">
									<ul>
										<li><a href="#tipo" data-toggle="tab">Perfil</a></li>
										<li><a href="#dados" data-toggle="tab">Conta</a></li>
										<li><a href="#pessoais" data-toggle="tab">Dados
												Pessoais</a></li>
									</ul>
								</div>

								<div class="tab-content">

									<div class="tab-pane" id="tipo">
										<h4 class="info-text">O que você é ?</h4>
										<div class="row">
											<div class="col-sm-10 col-sm-offset-1">
												<div class="col-sm-4">
													<div class="choice" data-toggle="wizard-radio">
														<input type="radio" name="tipo" value="aluno"
															class="form-control">
														<div class="icon">
															<i class="material-icons">school</i>
														</div>
														<h6>Aluno</h6>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="choice" data-toggle="wizard-radio">
														<input type="radio" name="tipo" value="professor"
															class="form-control">
														<div class="icon">
															<i class="material-icons">person_outline</i>
														</div>
														<h6>Professor</h6>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="choice" data-toggle="wizard-radio">
														<input type="radio" name="tipo" value="escola"
															class="form-control">
														<div class="icon">
															<i class="material-icons">location_city</i>
														</div>
														<h6>Escola</h6>
													</div>
												</div>
											</div>
										</div>
									</div>


									<div class="tab-pane" id="dados">
										<div class="row">
											<h4 class="info-text">Vamos começar com as informações
												básicas</h4>
											<div class="col-sm-4 col-sm-offset-1">
												<div class="picture-container">
													<div class="picture">
														<img
															src="<c:url value="/resources/img/default-avatar.png"/>"
															class="picture-src" id="wizardPicturePreview" title="" />
														<input type="file" id="wizard-picture"
															data-show-upload="false"
															data-allowed-file-extensions='["jpg", "png"]'
															name="fileFoto">
													</div>
													<h6>Escolha sua foto</h6>
												</div>
											</div>
											<div class="col-sm-6">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">face</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">Nome <small>*</small></label>
														<input name="nome" type="text" class="form-control">
													</div>
												</div>

												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">email</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">Email<small>*</small></label>
														<input name="email" type="email" class="form-control">
													</div>
												</div>
											</div>
											<div class="col-sm-5 col-sm-offset-1">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">security</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">Senha <small>*</small></label>
														<input id="senha" name="senha" type="password"
															class="form-control">
													</div>
												</div>
											</div>
											<div class="col-sm-5 ">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">security</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">Confirmar Senha <small>*</small></label>
														<input name="confirma_senha" type="password"
															class="form-control">
													</div>
												</div>
											</div>
										</div>
									</div>


									<div class="tab-pane" id="pessoais" id="tab-pane">
										<div class="row">
											<div class="col-sm-12">
												<h4 class="info-text">Pra terminar, precisamos de
													alguns dados pessoais !</h4>
											</div>
											<div class="col-sm-5 col-sm-offset-1 " id="cpf">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">assignment_ind</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">CPF <small>*</small></label>
														<input name="cpf" type="text" class="form-control cpf">
													</div>
												</div>
											</div>
											<div class="col-sm-5 " id="cnpj">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">assignment_ind</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">CNPJ <small>*</small></label>
														<input name="cnpj" type="text" class="form-control cnpj">
													</div>
												</div>
											</div>
											<div class="col-sm-5">
												<div class="input-group">
													<span class="input-group-addon"> <i
														class="material-icons">phone</i>
													</span>
													<div class="form-group label-floating">
														<label class="control-label">Celular <small>*</small></label>
														<input name="celular" type="text"
															class="form-control celular">
													</div>
												</div>
											</div>

											<div class="row" id="documento">
												<div class="col-sm-5 col-sm-offset-1">
													<div class="picture-container">
														<div class="picture">
															<img src="<c:url value="/resources/img/fileicon.png"/>"
																class="picture-src" id="wizardPicturePreview" title="" />
															<input type="file" id="wizard-picture"
																data-show-upload="false"
																data-allowed-file-extensions='["jpg", "png"]'
																name="fileDocumento">
														</div>
														<h6>Escolha seu documento</h6>
													</div>
												</div>
												<div class="col-sm-5">
													<div class="form-group label-floating">
														<label class="control-label">Documento</label>
														<p class="description">"Precisamos saber se você é
															realmente profesor ou uma Instituição de ensino, insira
															um documento que comprove isso. "</p>
													</div>
												</div>
											</div>


										</div>
									</div>
								</div>
								<div class="wizard-footer">
									<div class="pull-right">
										<input type="button"
											class='btn btn-next btn-fill btn-success btn-wd' name='next'
											value='Avançar' /> <input type='button'
											class='btn btn-finish btn-fill btn-success btn-wd'
											name='finish' value='Criar Conta' />
									</div>

									<div class="pull-left">
										<input type='button'
											class='btn btn-previous btn-fill btn-default btn-wd'
											name='previous' value='voltar' />
									</div>
									<div class="clearfix"></div>
								</div>
							</form>
						</div>
					</div>
					<!-- wizard container -->
				</div>
			</div>
			<!-- end row -->
		</div>
		<!--  big container -->
		<footer class="footer">
			<div class="container">

				<div class="copyright pull-right">
					&copy; 2016 <i class="fa fa-diamond diamod"></i> <a
						href="<c:url value="index"/>">Resolution</a>
				</div>
			</div>
		</footer>

	</div>

</body>

</html>