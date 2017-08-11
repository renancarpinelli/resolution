<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />


<style>
.prova {
	margin-top: 30px;
}

.questoes {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 1px 10px 1px rgba(0, 0, 0, 0.14);
	padding-bottom: 10px;
	min-height: 700px;
}

.questao {
	display: flex;
	align-items: center;
	margin-top: 10px;
	box-shadow: 0 1px 5px 1px rgba(0, 0, 0, 0.14);
}

.nota {
	width: 40px;
	border: 1px solid #ccc;
	border-radius: 1px;
	text-align: center;
}
</style>

<div class="col-md-12">
	<div class="col-md-6">
		<div class="card prova">
			<div class="card-content" style="padding: 33px 20px 0px 20px;">

				<div class="row">
					<div class="col-md-5 col-md-offset-1 ">
						<div class="form-group label-floating">
							<label class="control-label">Descrição</label> <input
								value="${provaDoAluno.prova.descricao }" type="text"
								class="form-control" disabled="disabled"> <span
								class="material-input"></span>
						</div>
					</div>
					<div class="col-md-2 col-md-offset-1">
						<div class="form-group label-floating">
							<label class="control-label">Valor </label> <input
								value="${provaDoAluno.prova.valor }" type="text"
								class="form-control" disabled="disabled"> <span
								class="material-input"></span>
						</div>
					</div>
					<div class="col-md-2 col-md-offset-1">
						<div class="form-group label-floating">
							<label class="control-label">Nota </label> <input
								value="${provaDoAluno.nota }" type="text" class="form-control"
								disabled="disabled"> <span class="material-input"></span>
						</div>
					</div>
				</div>
				<div class="row">


					<div class="col-md-3 col-md-offset-1">
						<div class="form-group label-floating">
							<label class="control-label">Inicio da prova</label> <input
								value="<fmt:formatDate pattern="dd-MM-yyyy HH:mm" value="${provaDoAluno.prova.data_inicial.time }"/>"
								type="text" class="form-control" disabled="disabled"> <span
								class="material-input"></span>
						</div>
					</div>
					<div class="col-md-3 col-md-offset-1">
						<div class="form-group label-floating">
							<label class="control-label">Fim da prova</label> <input
								value="<fmt:formatDate pattern="dd-MM-yyyy HH:mm" value="${provaDoAluno.prova.data_final.time }"/>"
								type="text" class="form-control" disabled="disabled"> <span
								class="material-input"></span>
						</div>
					</div>

					<div class="col-md-2 col-md-offset-1">
						<div class="form-group label-floating">
							<c:if
								test="${provaDoAluno.tipoEstadoProvaDoAluno == 'REALIZADA' }">
								<span class="label label-warning">Não Corrigida</span>
							</c:if>
							<c:if
								test="${provaDoAluno.tipoEstadoProvaDoAluno == 'CORRIGIDA' }">
								<span class="label label-success">Corrigida</span>
							</c:if>
							<c:if test="${provaDoAluno.tipoEstadoProvaDoAluno == 'ANULADA' }">
								<span class="label label-danger">Anulada</span>
							</c:if>
						</div>
					</div>
				</div>
			</div>


			<div class="clearfix"></div>

		</div>
	</div>

	<div class="col-md-6">
		<div class="card card-profile">
			<div class="card-avatar">
				<a> <img class="img"
					src="data:image/jpeg;base64,${provaDoAluno.aluno.foto64 }">
				</a>
			</div>

			<div class="content">
				<h6 class="category text-gray">Aluno</h6>
				<h4 class="card-title">${provaDoAluno.aluno.nome }</h4>
			</div>
		</div>
	</div>
</div>

<div class="col-md-12 questoes">
	<c:forEach var="resposta" varStatus="i"
		items="${provaDoAluno.respostasDoAluno}">

		<form action="../corrigirQuestao/${provaDoAluno.id }/${resposta.id }"
			method="post">

			<div class="col-md-12 questao">

				<div class="col-md-1">
					<c:if test="${resposta.nota != null }">
						<c:if test="${resposta.nota == 0 }">
							<i class="material-icons text-danger">clear</i>
						</c:if>
						<c:if test="${resposta.nota != 0 }">
							<i class="material-icons text-success">done</i>
						</c:if>
					</c:if>
				</div>

				<div class="col-md-1">
					<input type="number" value="${resposta.nota }" name="nota"
						class="nota" step="1" disabled="disabled"
						max="${provaDoAluno.prova.questoesDaProva[i.count-1].nota}"
						min="0"
						<c:if
					test="${provaDoAluno.prova.questoesDaProva[i.count-1].questao.tipoQuestao == 'OBJETIVA'}">	disabled="disabled" </c:if>>
					<span class="material-input"> </span>
				</div>

				<div class="col-md-10">
					<div>
						<label>Enunciado</label>
					</div>
					<div>${ provaDoAluno.prova.questoesDaProva[i.count-1].questao.descricao}</div>
					<c:if
						test="${provaDoAluno.prova.questoesDaProva[i.count-1].questao.tipoQuestao == 'OBJETIVA'}">
						<div>
							<label>Alternativas</label>
						</div>
						<c:forEach var="alternativa" varStatus="i"
							items="${provaDoAluno.prova.questoesDaProva[i.count-1].questao.respostas }">
							<div class="col-md-10" id="${alternativa.id }">
								<div class="col-md-1">
									<label> <input type="radio"
										<c:if test="${alternativa.id == resposta.resposta }">checked="checked"  </c:if>
										disabled="disabled"><span class="circle"></span><span
										class="check"></span></label>
								</div>
								<div class="col-md-11">${alternativa.descricao }</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if
						test="${provaDoAluno.prova.questoesDaProva[i.count-1].questao.tipoQuestao == 'DISSERTATIVA'}">
						<div>
							<label>Resposta do Aluno</label>
						</div>
						<div>${resposta.resposta }</div>

						<label>Parecer do professor</label>
						<div class="form-group">
							<input type="text" name="parecer" disabled="disabled"
								<c:if test="${resposta.parecer != null   }"> value="${resposta.parecer }" </c:if>
								class="form-control "> <span class="material-input"></span>
						</div>
					</c:if>
				</div>

			</div>
		</form>
	</c:forEach>
</div>










<c:import url="/WEB-INF/paginas/template/rodape.jsp" />