<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

			</div>
			<div class="modal-body">
				<div class="col-md-12">
					<div class="card card-plain">
						<div class="card-header" data-background-color="green">
							<h4 class="title">Questões</h4>
							<p class="category">Lista de questões para selecionar para
								sua prova</p>
						</div>
					</div>

					<div class="questoes"></div>

					<div class="card-footer text-center">
						<div class="col-md-12">
							<button type="button" class="btn btn-primary btn-sm pull-left"
								id="anteriorativo">
								Anterior
								<div class="ripple-container"></div>
							</button>
							<span id="numeracaoativo" class=""></span>
							<button type="button" class="btn btn-primary btn-sm pull-right"
								id="proximoativo">
								Proximo
								<div class="ripple-container"></div>
							</button>
						</div>
					</div>
				</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger btn-simple"
					data-dismiss="modal">Fechar</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modalQuestoes" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	style="display: none;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					<i class="material-icons">clear</i>
				</button>

			</div>
			<div class="modal-body">

				<div class="col-md-12">
					<div class="card card-plain">
						<div class="card-header" data-background-color="green">
							<h4 class="title">Questões Selecionadas</h4>
							<p class="category">Questões selecionadas para a sua prova</p>
						</div>
					</div>

					<div class="col-md-12" id="questoesSelecionadas">

						<c:if test="${prova.id != null }">
							<c:forEach var="questaoDaProva" items="${prova.questoesDaProva }">

								<div id="s${questaoDaProva.questao.id }"
									class="card questao q${questaoDaProva.questao.id }">
									<div class="row">
										<div class="col-md-2 ">
											<div class="form-group ">
												<label class="">Tipo deQuestão</label>
												<h6>${questaoDaProva.questao.tipoQuestao }</h6>
											</div>
										</div>
										<div class="col-md-2 col-md-offset-1">
											<div class="form-group ">
												<label class="">Nivel de Dificuldade</label>
												<h6>${questaoDaProva.questao.nivel_dificuldade }</h6>
											</div>
										</div>
										<div class="col-md-4 col-md-offset-1">
											<div class="form-group ">
												<label class="">Marcadores</label>
												<h6>
													<c:forEach var="marcadores"
														items="${questaoDaProva.questao.marcadores }">
														<span class="label label-success">${marcadores.descricao }</span>
													</c:forEach>
												</h6>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10">
											<div class="form-group ">
												<label class="control-label">Enunciado</label>
												${questaoDaProva.questao.descricao }
											</div>
										</div>
									</div>

									<div class="row">

										<c:if
											test="${questaoDaProva.questao.tipoQuestao == 'OBJETIVA' }">
											<div class="col-md-10 ">
												<div class="form-group ">
													<div class="row  text-success">
														<div class="col-md-10">
															<label> Alternativa Correta </label>
															<p>
																<c:forEach var="resposta"
																	items="${questaoDaProva.questao.respostas }">
																	<c:if test="${resposta.valor == true }"> 
																 ${resposta.descricao }
																</c:if>

																</c:forEach>
															</p>
														</div>
													</div>
												</div>
											</div>
										</c:if>

										<c:if
											test="${questaoDaProva.questao.tipoQuestao == 'DISSERTATIVA' }">
											<div class="col-md-10">
												<label>Resposta Esperada</label>
												<c:forEach var="resposta"
													items="${questaoDaProva.questao.respostas }">
													<p>${resposta.resp_esperada }</p>
												</c:forEach>
											</div>
										</c:if>


									</div>



									<div class="row">
										<div class="col-md-12 ">
											<a class="btn btn-danger btn-sm pull-right"
												onclick="removerQuestao(this)" id="${questaoDaProva.questao.id }"> Retirar Questão</a>
										</div>
									</div>
								</div>


							</c:forEach>
						</c:if>



					</div>

				</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger btn-simple"
					data-dismiss="modal">Fechar</button>
			</div>
		</div>
	</div>
</div>


<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<script src="<c:url value="/resources/ckeditor/ckeditor.js"/>"></script>

<style>
.questao {
	padding: 20px;
}

.label {
	margin-left: 5px;
	display: inline-block;
	margin: 2px;
}

.buscar {
	background-color: #fff;
	border-radius: 10px;
	padding-top: 20px;
	padding-bottom: 20px;
}

.card {
	box-shadow: 0 1px 10px 1px rgba(0, 0, 0, 0.14);
}
</style>


<script>
	var jsonPagina;
	// buscar questões 
	$(function() {
		//hang on event of form with id=myform
		$("#buscar").submit(function(e) {

			//prevent Default functionality
			e.preventDefault();

			//get the action-url of the form
			var actionurl = e.currentTarget.action;

			//realiza a request e abre o modal
			$.ajax({
				url : actionurl,
				type : "POST",
				data : $("#buscar").serialize(),
				success : function(data) {
					if (data[0] == null) {
						alerta("Nenhuma questão encontrada", "danger");
					} else {
						jsonPagina = data;
						paginar("ativo", data)
						$("#myModal").modal('show');
					}
				},
			});
		});
	});

	$(function() {
		//hang on event of form with id=myform
		$("#gerarProva").submit(
				function(e) {

					//prevent Default functionality
					e.preventDefault();

					//get the action-url of the form
					var actionurl = e.currentTarget.action;

					//realiza a request e abre o modal
					$.ajax({
						url : actionurl,
						type : "POST",
						data : $("#gerarProva").serialize(),
						success : function(data) {
							$(".selectquestoes").empty();
							$(".questoes").empty();
							jsonPagina = data;
							$(data).each(
									function(k, v) {
										$(
												"<option selected='selected' value='"+v.id+"' >"
														+ v.id + "</option>")
												.appendTo('.selectquestoes');
									});
							paginar("ativo", data);
							$("#myModal").modal('show');

						},
						error : function(data) {
							alerta("Não foi possivel gerar a prova", "danger");
						}
					});
				});
	});

	function buscarAjax(url) {

		var str = window.location.pathname.split('/')[2]
		if (str == 'editarProva') {
			url = "../" + url;
		}

		var json;
		jQuery.ajax({
			url : url,
			type : "GET",
			dataType : "json",
			async : false,
			success : function(data) {
				json = data;
			}
		});
		return json;
	}
	// Select de marcadores 
	$(function() {
		$('.select-tools').selectize({
			maxItems : 3,
			valueField : 'id',
			labelField : 'descricao',
			searchField : 'descricao',
			options : buscarAjax("../listarMarcadores"),
			create : false,
		});
	});

	var qtdPorPagina = 1;
	var pagAtual = 0;

	function paginar(tabela, json) {

		var tamanho = Object.keys(json).length;
		var questao;

		$('.questoes').empty();
		var tbody = $('.questoes');
		for (var i = pagAtual * qtdPorPagina; i < tamanho
				&& i < (pagAtual + 1) * qtdPorPagina; i++) {
			questao = json[i];
			var marcadores = '';
			for (var j = 0; j < (questao.marcadores).length; j++) {
				marcadores += '<span class="label label-success">'
						+ (questao.marcadores[j].descricao) + '</span>';
			}
			var resposta = '';
			for (var z = 0; z < (questao.respostas).length; z++) {
				if (questao.tipoQuestao == 'DISSERTATIVA') {
					resposta += '<div class="row" > <div class="col-md-10"> <label >Resposta Esperada</label> '
							+ questao.respostas[z].resp_esperada
							+ ' </div> </div>';
				} else {
					if (questao.respostas[z].valor == true) {
						resposta += '<div class="row  text-success"> <div class="col-md-10">  <label > Alternativa Correta </label>'
								+ questao.respostas[z].descricao
								+ ' </div>  </div>';
					}
				}
			}

			// Botão de Adicionar Questões - Saber se já foi selecionada ou não 
			var btn = "";
			if (!provaAutomatica) {
				$(".selectquestoes")
						.each(
								function() {
									if ($(this).val() == null) {
										btn = "<a class='btn btn-primary btn-sm pull-right'  onclick='addQuestao(this)' id='"
												+ questao.id
												+ "'> Adicionar a Prova </a>";
									}
									$
											.each(
													$(this).val(),
													function(key, value) {
														if (value == questao.id) {
															btn = "<a class='btn btn-danger btn-sm pull-right'  onclick='removerQuestao(this)' id='"
																	+ questao.id
																	+ "'> Retirar Questão</a>";
															return false;
														} else {
															btn = "<a class='btn btn-primary btn-sm pull-right'  onclick='addQuestao(this)' id='"
																	+ questao.id
																	+ "'> Adicionar a Prova </a>";
														}
													});
								});

			}

			// Card de Questão 
			var texto = '<div id="q'+questao.id+'" class="card questao q'+questao.id+'"><div class="row"><div class="col-md-2 "><div class="form-group "><label class="">Tipo deQuestão</label><h6>'
					+ questao.tipoQuestao
					+ '</h6></div></div><div class="col-md-2 col-md-offset-1"><div class="form-group "><label class="">Nivel de Dificuldade</label><h6>'
					+ questao.nivel_dificuldade
					+ ' </h6></div></div><div class="col-md-4 col-md-offset-1"><div class="form-group "><label class="">Marcadores</label><h6>'
					+ marcadores
					+ '</div></div></div><div class="row"><div class="col-md-10"><div class="form-group "><label class="control-label">Enunciado</label>'
					+ questao.descricao
					+ '</div></div></div><div class="row"><div class="col-md-10 "> <div class="form-group ">  '
					+ resposta
					+ '</div></div></div><div class="row"><div class="col-md-12 "> '
					+ btn + ' </div></div></div>'
			tbody.append(texto);
		}

		$("#numeracao" + tabela).text(
				"Página " + (pagAtual + 1) + " de "
						+ Math.ceil(tamanho / qtdPorPagina));

		$("#proximo" + tabela).click(function() {
			if (pagAtual < tamanho / qtdPorPagina - 1) {
				pagAtual++;
				paginar(tabela, jsonPagina);
				configBotoes(tabela);
			}
		});

		$("#anterior" + tabela).click(function() {
			if (pagAtual > 0) {
				pagAtual--;
				paginar(tabela, jsonPagina);
				configBotoes(tabela);
			}
		});
	}

	$('#myModal').on('hidden.bs.modal', function() {
		pagAtual = 0;
	})

	var nQuestoes 
	
	

	function addQuestao(questao) {
		var questao = $(questao).attr("id");

		$('#' + questao)
				.replaceWith(
						"<a class='btn btn-danger btn-sm pull-right'  onclick='removerQuestao(this)' id='"
								+ questao + "'> Retirar Questão</a>");

		$(
				"<option selected='selected' value='"+questao+"' >" + questao
						+ "</option>").appendTo('.selectquestoes');

		$("#q" + questao).clone().attr("id", "s" + questao).appendTo(
				"#questoesSelecionadas");

		$('#qtdquestoes').text( ++nQuestoes );

		alerta("Quatidade de questões selecionadas : " + nQuestoes + "",
				"success");
	}

	function removerQuestao(questao) {
		var questao = $(questao).attr("id");
		$('#' + questao).replaceWith(
				"<a class='btn btn-primary btn-sm pull-right'  onclick='addQuestao(this)' id='"
						+ questao + "'> Adicionar a Prova </a>");
		$(".selectquestoes option[value='" + questao + "']").remove();

		$("#s" + questao).remove();

		$('#qtdquestoes').text( --nQuestoes );
		alerta("Quatidade de questões selecionadas : " + nQuestoes + " ",
				"danger");
	}

	function alerta(texto, type) {
		$.notify(texto, {
			type : type,
			placement : {
				from : 'top',
				align : 'rigth'
			}
		});
	}

	// Submit criar prova 

	var provaAutomatica;

	$(document)
			.ready(
					function() {
						nQuestoes = $('#qtdquestoes').text();

						$('#gerarProvaAutomatica').click(function() {
							if (this.checked) {
								provaAutomatica = true;
								$("#manual").hide();
								$("#nquestoes").hide();
								$("#automatica").show();
								$("#btnProvaAutomatica").show();
							} else {
								provaAutomatica = false;
								$("#automatica").hide();
								$("#btnProvaAutomatica").hide();
								$("#nquestoes").show();
								$("#manual").show();
							}
						});

						$("#btnModalSalvarProva")
								.on(
										'click',
										function() {
											$(".selectquestoes")
													.each(
															function() {
																if ($(this)
																		.val() == null) {
																	alerta(
																			"Você deve selecionar ao menos uma questão para criar a prova !",
																			"danger");
																} else if ($(
																		"#descricao")
																		.val() == "") {
																	alerta(
																			"Você precisa inserir uma descrição !",
																			"danger");

																} else {
																	$(
																			"#salvarProva")
																			.submit();
																}
															})
										});

					});
</script>

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Criar Prova</li>
</ol>

<form   <c:if test="${prova.id !=null }">  action="../salvarProva" </c:if>
		<c:if test="${prova.id ==null }">  action="salvarProva" </c:if> method="post" id="salvarProva">
	<div class="col-md-10  col-md-offset-1">
		<div class="card card-plain">
			<div class="card-header" data-background-color="green">
				<h4 class="title">Criação de Prova</h4>
			</div>
		</div>
		
		<input type="text" value="${prova.id }" name="id" style="display: none;">

		<div class="col-md-10  col-md-offset-1">
			<div class="form-group label-floating">
				<label class="control-label">Descrição</label> <input type="text"
					id="descricao" required="required" name="descricao"
					<c:if test="${prova.id != null }"> value="${prova.descricao }" </c:if>
					class="form-control"> <span class="material-input"></span>
			</div>
		</div>


		<div class="col-md-10  col-md-offset-1">
			<label> Cabecalho </label>

			<c:if test="${prova.id != null }">
				<textarea name="cabecalho" id="cabecalho" rows="10" cols="80"> ${prova.cabecalho}  </textarea>
			</c:if>
			<c:if test="${prova.id == null }">
				<textarea name="cabecalho" id="cabecalho" rows="10" cols="80"> 						
				<p> Nome: __________________________________________&nbsp; &nbsp;Matricula: _______________________<br />
				Turma: _______________________________________________________&nbsp; &nbsp;Data: ____/____/____</p>
            </textarea>
			</c:if>
		</div>
		<script>
			CKEDITOR.replace('cabecalho');
		</script>
	</div>

	<select name="questoes" multiple="multiple" class="selectquestoes"
		style="display: none;">		
		<c:if test="${prova.id != nulll }">
		<c:forEach var="questoesDaProva" items="${prova.questoesDaProva }">
		    <option value="${ questoesDaProva.questao.id}" selected="selected"> ${ questoesDaProva.questao.id}  </option>
		</c:forEach>		
		</c:if>				
	</select>
</form>

<div class="col-md-10 ">
	<div class="togglebutton pull-right" style="margin-top: 15px;">
		<label> <input type="checkbox" id="gerarProvaAutomatica">
			Prova Automática
		</label>
	</div>
</div>



<div class="col-md-8 col-md-offset-2 buscar" id="manual"
	style="margin-top: 10px">
	<form
		<c:if test="${prova.id !=null }">  action="../listarQuestoes" </c:if>
		<c:if test="${prova.id ==null }">  action="listarQuestoes" </c:if>
		id="buscar">
		<div class="col-md-9">
			<div class="col-md-12">
				<div class="col-md-6 col-md-offset-1">
					<label> Tipo de Questão</label> <select name="tipoDaQuestao"
						id="tipoDaQuestao" class="form-control input-lg"
						style="margin-top: 0px;">
						<option value="objetiva">Objetiva</option>
						<option value="dissertativa">Dissertativa</option>
					</select> <span class="material-input"></span>
				</div>
				<div class="col-md-4 col-md-offset-1">
					<label> Nivel de Dificuldade </label> <select
						name="nivel_dificuldade" class="form-control input-lg">
						<c:forEach var="i" begin="1" end="5">
							<option value="${i}">${i}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-10 col-md-offset-1">

					<label> Marcadores </label> <select name="marcSelecionados"
						required class="select-tools" multiple
						placeholder="Escolha um marcador...">
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-3" style="padding-top: 50px;">
			<button type="submit" class="btn btn-lg btn-primary">
				<i class="material-icons">search</i> Buscar
				<div class="ripple-container"></div>
			</button>
		</div>
	</form>
</div>

<div class="col-md-8 col-md-offset-2 buscar" id="automatica"
	style="margin-top: 10px; display: none;">
	<form
		<c:if test="${prova.id !=null }">  action="../gerarProvaAutomatica" </c:if>
		<c:if test="${prova.id ==null }">  action="gerarProvaAutomatica" </c:if>
		id="gerarProva">
		<div class="col-md-9">
			<div class="col-md-12">
				<div class="col-md-6 col-md-offset-1">
					<label> Tipo de Questões</label> <select name="tipoDaQuestao"
						id="tipoDaQuestao" class="form-control input-lg"
						style="margin-top: 0px;">
						<option value="objetiva">Objetiva</option>
						<option value="dissertativa">Dissertativa</option>
						<option value="Mista">Mista</option>
					</select> <span class="material-input"></span>
				</div>
				<div class="col-md-4 col-md-offset-1">
					<div class="form-group ">
						<label class="control-label">Numero de Questões</label> <input
							type="number" min="0" max="20" id="numerQuestoes"
							required="required" name="numerQuestoes" class="form-control">
						<span class="material-input"></span>
					</div>
				</div>
				<div class="col-md-10 col-md-offset-1">

					<label> Marcadores </label> <select name="marcSelecionados"
						required class="select-tools" multiple
						placeholder="Escolha um marcador...">
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-3" style="padding-top: 50px;">
			<button type="submit" class="btn btn-lg btn-primary">
				<i class="material-icons">description</i> Gerar Prova
				<div class="ripple-container"></div>
			</button>
			</button>
		</div>
	</form>
</div>



<div class="col-md-10 col-md-offset-1">
	<div class="col-md-10 col-md-offset-1">
		<button id="nquestoes" class="btn btn-warning pull-left"
			data-toggle="modal" data-target="#modalQuestoes"> Questões
			selecionadas (<a style="color: #fff;" id="qtdquestoes"><c:if test="${prova.id == nul }">0</c:if><c:if test="${prova.id != nul }"> ${fn:length(prova.questoesDaProva)}  </c:if>   </a>)</button>
		<button id="btnProvaAutomatica" class="btn btn-warning pull-left"
			data-toggle="modal" data-target="#myModal" style="display: none;">
			Visualizar prova gerada</button>
		<c:if test="${prova.id != nul }">
			<a href="../agendarProva/${prova.id }" class="btn btn-success pull-right"> <i class='material-icons'>date_range</i>   Agendar Prova </a>
			</c:if>	
		<button type="button" class="btn btn-primary pull-right"
			id="btnModalSalvarProva">  <c:if test="${prova.id != null }"> <i class='material-icons'>create</i> Editar Prova   </c:if> <c:if test="${prova.id == null }"> Criar Prova  </c:if>    </button>
			
			
	</div>
</div>

<c:import url="/WEB-INF/paginas/template/rodape.jsp" />