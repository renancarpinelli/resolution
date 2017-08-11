<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="main-panel">
			<nav class="navbar navbar-transparent navbar-absolute">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>					
						<c:if test="${alunoLogado != null }"> <a class="navbar-brand" href="#">  Aluno ${alunoLogado.nome } </a> </c:if>
						<c:if test="${professorLogado != null }"> <a class="navbar-brand" href="#">  Professor ${professorLogado.nome } </a> </c:if>
						<c:if test="${escolaLogado != null }"> <a class="navbar-brand" href="#">  Escola ${escolaLogado.nome } </a> </c:if>
						<c:if test="${administradoLogado != null }"> <a class="navbar-brand" href="#">  Administrador ${administradoLogado.nome } </a> </c:if>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav navbar-right">
														<li>
								<a href='<c:url value="/sair" />' >
	 							   <i class="material-icons">exit_to_app</i>
	 							   <p class="hidden-lg hidden-md">Sair</p>
	 						   </a>
							</li>
						</ul>

					</div>
				</div>
			</nav>

	        <div class="content">
	            <div class="container-fluid">