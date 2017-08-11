<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!--   <link rel="apple-touch-icon" sizes="76x76" href="assets/img/favicon.ico">-->

<title>Login</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<c:import url="/WEB-INF/paginas/template/imports.jsp" />

<link href="<c:url value="/resources/css/material-kit.css"/>"
	rel="stylesheet" />



<script src="<c:url value="/resources/js/material-kit.js"/>"></script>


</head>

<body class="signup-page">
	<nav class="navbar navbar-transparent navbar-absolute">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navigation-example">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href='<c:url value="index" ></c:url>'>Resolution</a>
			</div>

			<div class="collapse navbar-collapse" id="navigation-example">
				<ul class="nav navbar-nav navbar-right">
					<li><a href='<c:url value="form_usuario" ></c:url>'> Criar
							conta </a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="wrapper">
		<div class="header header-filter"
			style="background-image: url(<c:url value="/resources/img/wizard-profile.jpg"/>); background-size: cover; background-position: top center;">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
						<div class="card card-signup">
							<form method="post" action="logar">
								<div class="header header-primary text-center">
									<h4>Acessar o sistema</h4>
								</div>

								<div class="content">
									<div class="input-group">
										<span class="input-group-addon"> <i
											class="material-icons">email</i>
										</span> <input name="email" type="email" required="required"
											class="form-control" placeholder="Email...">
									</div>

									<div class="input-group">
										<span class="input-group-addon"> <i
											class="material-icons">lock_outline</i>
										</span> <input name="senha" type="password" required="required"
											placeholder="Senha..." class="form-control" />
									</div>
								</div>
								<div class="footer text-center">
									<div class="text-center">
										<input type="submit" class="btn  btn-primary btn-lg"
											value="Entrar">
									</div>

									<p>
										<a href="#pablo" class="btn btn-simple btn-primary btn-sm">Esqueci
											minha senha</a> <a href="<c:url value="form_usuario"/>"
											class="btn btn-simple btn-primary btn-sm">Criar conta</a>
									</p>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<footer class="footer">
				<div class="container">

					<div class="copyright pull-right">
						&copy; 2016 <i class="fa fa-diamond diamod"></i> <a
							href="<c:url value="index"/>">Resolution</a>
					</div>
				</div>
			</footer>

		</div>

	</div>

	<c:if test="${erro != null }">
		<div class="row">
			<div class="col-md-4 col-md-offset-2">
				<script type="text/javascript">
					$.notify('Falha ao realizar login ! ', {
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


</body>