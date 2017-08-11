<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<head>
<meta charset="utf-8" />
<link rel="shortcut icon"
	href="<c:url value="/resources/img/Logo.png"/>" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Home</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<c:import url="/WEB-INF/paginas/template/imports.jsp" />



<link href="<c:url value="/resources/css/material-dashboard.css"/>"
	rel="stylesheet" />

<script src="<c:url value="/resources/js/material-dashboard.js"/>"></script>

<script src="<c:url value="/resources/js/material-kit.js"/>"></script>

<script src="<c:url value="/resources/js/material.min.js"/>"></script>

<link href="<c:url value="/resources/css/selectize.legacy.css"/>"
	rel="stylesheet" />

<script src="<c:url value="/resources/js/selectize/selectize.js"/>"></script>





</head>
<body>
	<div class="wrapper">
		<div class="sidebar" data-color="green"
			data-image="<c:url value="/resources/img/sidebar-3.jpg"/>">
			<div class="logo">
				<a href="<c:url value="home"/>" class="simple-text"> Resolution
				</a>
			</div>

			<div class="sidebar-wrapper">
				<ul class="nav">
					<li class="active"><c:if test="${administradorLogado != null}">
							<a href='<c:url value="/adx/listaProfessores"></c:url>'> <i
								class="material-icons">person_outline</i>
								<p>Professores</p>
							</a>
							
						</c:if> <c:if test="${professorLogado != null}">
							<a href='<c:url value="/pfx/listaTurmasProfessor"></c:url>'> <i
								class="material-icons">person_outline</i>
								<p>Turmas</p>
							</a>
							<a href='<c:url value="/pfx/listasMinhasQuestoes"></c:url>'> <i
								class="material-icons">done_all</i>
								<p>Minhas Questões</p>
							</a>
							<a href='<c:url value="/pfx/listaProvas"></c:url>'> <i
								class="material-icons">description</i>
								<p>Provas</p>
							</a>
						</c:if> <c:if test="${alunoLogado != null}">
							<a href='<c:url value="/alx/listaTurmasAluno"></c:url>'> <i
								class="material-icons">person_outline</i>
								<p>Turmas</p>
							</a>

							<a href='<c:url value="/alx/listaProvasAluno"></c:url>'> <i
								class="material-icons">description</i>
								<p>Realizar Prova</p>
							</a>

							<a href='<c:url value="/alx/listaProvasAluno2"></c:url>'> <i class="material-icons">done_all</i>
								<p>Provas</p>
							</a>

							<a href='<c:url value="/alx/realizar_simulado"></c:url>'> <i
								class="material-icons">description</i>
								<p>Simulado</p>
							</a>

						</c:if></li>
				</ul>
			</div>
		</div>