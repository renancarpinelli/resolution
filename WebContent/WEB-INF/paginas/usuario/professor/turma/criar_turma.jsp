<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
		<li><a href='<c:url value="listaTurmasProfessor"></c:url>'>Lista de Turmas</a></li>
	<li class="active">Criar Turma</li>
</ol>

<div class="col-md-8 col-md-offset-2">
	<div class="card">
		<div class="card-header" style="text-align: center;"
			data-background-color="green">
			<h4 class="title">Criar Turma</h4>
		</div>
		<div class="card-content">
			<form action="criarNovaTurma" method="post">
				<div class="row">
					<div class="col-md-5 col-md-offset-4">
						<div class="form-group label-floating">
							<label class="control-label">Nome </label> <input type="text"
								name="descricao" class="form-control"> <span
								class="material-input"></span>
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-primary pull-right">Criar
					Turma</button>
				<div class="clearfix"></div>
			</form>
		</div>
	</div>
</div>




<c:import url="/WEB-INF/paginas/template/rodape.jsp" />