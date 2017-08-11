<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<head>

<!--   <link rel="apple-touch-icon" sizes="76x76" href="assets/img/favicon.ico">-->

<title>Resolution</title>
<meta charset="UTF-8" />
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<c:import url="/WEB-INF/paginas/template/imports.jsp" />

<link href="<c:url value="/resources/css/gaia.css"/>" rel="stylesheet" />

<script src="<c:url value="/resources/js/gaia.js"/>"></script>

<script src="<c:url value="/resources/js/modernizr.js"/>"></script>

</head>

<body>

	<nav class="navbar navbar-default navbar-transparent navbar-fixed-top"
		color-on-scroll="200">
		<!-- if you want to keep the navbar hidden you can add this class to the navbar "navbar-burger"-->
		<div class="container">
			<div class="navbar-header">
				<button id="menu-toggle" type="button" class="navbar-toggle"
					data-toggle="collapse" data-target="#example">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar bar1"></span> <span class="icon-bar bar2"></span>
					<span class="icon-bar bar3"></span>
				</button>
				<a href="index" class="navbar-brand"> Resolution </a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right navbar-uppercase">
					<li><a href="<c:url value="login"/>"
						class="btn btn-danger btn-fill">Entrar</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
	</nav>


	<div class="section section-header">
		<div class="parallax filter ">
			<div class="image">
				<video autoplay loop class="fillWidth">
					<source src="<c:url value="/resources/video/index.mp4"/>"
						type="video/mp4" />

				</video>
			</div>
			<div class="container">
				<div class="content">
					<div class="title-area">
						<h1 class="title-modern">Resolution</h1>
						<h3>Uma nova maneira de aplicar provas</h3>
						<div class="separator line-separator"></div>
					</div>

					<div class="button-get-started">
						<a href="form_usuario" class="btn btn-danger btn-fill btn-lg ">
							Cadastrar-se </a>
					</div>
				</div>

			</div>
		</div>
	</div>


	<div class="section">
		<div class="container">
			<div class="row">
				<div class="title-area">
					<h2>Recursos</h2>
					<div class="separator separator-danger">*</div>
					<p class="description">Prometemos um novo visual e, mais
						importante, uma nova atitude. Feito para, atender suas
						necessidades e facilitar o trabalho chato.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="info-icon">
						<div class="icon text-danger">
							<i class="pe-7s-graph1"></i>
						</div>
						<h3>Banco de Questões</h3>
						<p class="description">Banco de questões dissertativas e
							objetivas a sua disposição.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="info-icon">
						<div class="icon text-danger">
							<i class="pe-7s-note2"></i>
						</div>
						<h3>Aplicar provas</h3>
						<p class="description">Criar provas e aplicar provas de
							maneira fácil e simples.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="info-icon">
						<div class="icon text-danger">
							<i class="pe-7s-music"></i>
						</div>
						<h3>Corrir provas automaticamente</h3>
						<p class="description">Não perca tempo corrigindo provas
							objetivas, nós fazemos isso pra você.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer class="footer footer-big footer-color-black" data-color="black">
		<div class="container">
			<hr>
			<div class="copyright">
				<script>
					document.write(new Date().getFullYear())
				</script>
				- Resolution
			</div>
		</div>
	</footer>

</body>

