<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />

<script src="<c:url value="/resources/ckeditor/ckeditor.js"/>"></script>
<link href="<c:url value="/resources/fileinput/css/fileinput.css"/>"
	rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/fileinput/js/fileinput.min.js"/>"
	type="text/javascript">
	
</script>
<script src="<c:url value="/resources/jquery/jquery.validate.min.js"/>"></script>


<script>
	function buscarAjax(url) {
		
		var str = window.location.pathname.split('/')[2]
		if(str == 'editar_questao'){
		  url = "../"+url;	
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



	$(function() {	
		$('#select-tools')
				.selectize(
						{
							maxItems : null,
							valueField : 'id',
							labelField : 'descricao',
							searchField : 'descricao',
							options :buscarAjax("../listarMarcadores"),
							create : false,
						});
	});

	function getvalAlternativa() {
		criarAlternativas();
	}

	function getvalNumero() {
		criarAlternativas();
	}

	function criarAlternativas() {

		var enunciado;
		var alternativa = $("#alternativas");
		alternativa.empty();

		var quantidade = $('#numeroAlternativas').find(":selected").text();

		var tipo = $('#tipoDeAlternativa').find(":selected").text();

		for (var i = 1; i <= quantidade; i++) {

			if (i == 1) {
				enunciado = "A)"
			} else if (i == 2) {
				enunciado = "B)"
			} else if (i == 3) {
				enunciado = "C)"
			} else if (i == 4) {
				enunciado = "D)"
			} else if (i == 5) {
				enunciado = "E)"
			}

			alternativa
					.append($("<div class='col-md-12' id='alternativa"+i+"' >")
							.append(
									$("<div class='col-md-1'>")
											.append(
													"<input class='btn btn-danger btn-just-icon desativo' id='"+i+"' style='width: 50px; padding: 10px;' name='valores' value='F'  onclick='changeButton(this)'>"))
							.append(
									$("<div class='col-md-10 panel'>")
											.append(
													$(
															"<div class='panel-heading accordion-toggle question-toggle collapsed' data-toggle='collapse' data-parent='#faqAccordion'	data-target='#question"+i+"'>")
															.append(
																	$(
																			"<h4 class='panel-title'>")
																			.append(
																					$(
																							"<a >")
																							.append(
																									""
																											+ enunciado)
																							.append(
																									"<div id='enunciado"+i+"'>"))))
											.append(
													$(
															"<div id='question"+i+"' class='panel-collapse collapse'	style='height: 0px;'>")
															.append(
																	$("<div class='panel-body' id='respTexto'>"))
															.append(
																	$(
																			"<div class='col-md-11 col-md-offset-1'>")
																			.append(
																					"<textarea name='enunciados' required class='alternativ"
																							+ i
																							+ "' id='alternativ"
																							+ i
																							+ "' rows='10' onkeyup='setEnunciado"
																							+ i
																							+ "()' cols='80'>     </textarea>")))));

			$('.alternativ' + i).each(function() {
				CKEDITOR.replace(this.id);
				var editor

				if (i == 1) {
					editor = CKEDITOR.instances.alternativ1;
					editor.on('key', function() {
						var data = editor.getData();
						$('#enunciado1').html(data);
					});
				} else if (i == 2) {
					editor = CKEDITOR.instances.alternativ2
					editor.on('key', function() {
						var data = editor.getData();
						$('#enunciado2').html(data);
					});
				} else if (i == 3) {
					editor = CKEDITOR.instances.alternativ3;
					editor.on('key', function() {
						var data = editor.getData();
						$('#enunciado3').html(data);
					});
				} else if (i == 4) {
					editor = CKEDITOR.instances.alternativ4;
					editor.on('key', function() {
						var data = editor.getData();
						$('#enunciado4').html(data);
					});
				} else if (i == 5) {
					editor = CKEDITOR.instances.alternativ5;
					editor.on('key', function() {
						var data = editor.getData();
						$('#enunciado5').html(data);
					});
				}

			});
		}
	};

	function setEnunciado1() {
		var editorText = CKEDITOR.instances.enunciados.getData();
	}

	function changeButton(value) {
		var id = $(value).attr('id');
		if($(value).hasClass("desativo")){
			
			if (id == 1) {
				$(value).replaceWith("<input  class='btn btn-primary btn-just-icon ativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='V' onclick='changeButton(this)'> </input>");				
				$("#2").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#3").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#4").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#5").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 2){
				$("#1").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$(value).replaceWith("<input  class='btn btn-primary btn-just-icon ativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='V' onclick='changeButton(this)'> </input>");				
				$("#3").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#4").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#5").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 3){
				console.log("aa")
				$("#1").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#2").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$(value).replaceWith("<input  class='btn btn-primary btn-just-icon ativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='V' onclick='changeButton(this)'> </input>");	
				$("#4").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#5").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 4){
				$("#1").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#2").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#3").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$(value).replaceWith("<input  class='btn btn-primary btn-just-icon ativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='V' onclick='changeButton(this)'> </input>");
				$("#5").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 5){
				$("#1").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#2").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#3").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$("#4").replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
				$(value).replaceWith("<input  class='btn btn-primary btn-just-icon ativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='V' onclick='changeButton(this)'> </input>");				
			}
										
		}else{
			
			if (id == 1) {
				$(value).replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='1' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 2){
				$(value).replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='2' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 3){
				$(value).replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='3' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 4){
				$(value).replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='4' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}else if (id == 5){
				$(value).replaceWith("<input class='btn btn-danger btn-just-icon desativo' id='5' style='width: 50px; padding: 10px; ' name='valores' value='F' onclick='changeButton(this)'> </input>");
			}
			
			
			
		}
		
		
		
	
	}

	$(document).ready(function() {
		$("input").keyup(function() {
			$("input").css("background-color", "pink");
		});

		criarAlternativas();
		
		var str = window.location.pathname.split('/')[2]
		

		$("#tipoDaQuestao").change(function() {

			$("#tipoDaQuestao option:selected").each(function() {
				
				var sel = $(this).val() + "";

				if (sel != 'objetiva') {
					$("#objetiva").hide();
					$("#dissertativa").show();
				if(str == 'editar_questao' ){	
					$('#form').attr('action', '../criarQuestaoDissertativa');
				}else{
					$('#form').attr('action', 'criarQuestaoDissertativa');
				}	
				} else {
					$("#objetiva").show();
					$("#dissertativa").hide();
				if(str == 'editar_questao' ){
					$('#form').attr('action', '../criarQuestaoObjetiva');
				}else{
					$('#form').attr('action', 'criarQuestaoObjetiva');
				}						
				}
			});

		}).change();

	});
</script>

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li><a href='<c:url value="../listasMinhasQuestoes"></c:url>'>Minhas
			Questões</a></li>
	<li class="active">Criar Questão</li>
</ol>


<div class="col-md-12">
	<div class="card">
		<div class="card-header" style="text-align: center;"
			data-background-color="green">
			<h4 class="title">Criar Questão</h4>
		</div>
		<div class="card-content">
			<form
				action="<c:if test="${questao.id != null }"> ../criarQuestaoObjetiva  </c:if> <c:if test="${questao.id == null }"> criarQuestaoObjetiva </c:if>"
				method="post" id="form" enctype="multipart/form-data">

				<c:if test="${questao.id != null }">
					<input type="number" name="id" value="${questao.id }"
						style="display: none;">

				</c:if>

				<div class="row">
					<div class="col-md-10 col-md-offset-1 ">
						<label> Tipo de Questão</label> <select name="tipoDaQuestao"
							<c:if test="${questao.id != null }"> disabled="disabled" </c:if>
							id="tipoDaQuestao" class="form-control input-lg"
							style="margin-top: 0px;">
							<option value="objetiva"
								<c:if test="${questao.id != null && questao.tipoQuestao == 'OBJETIVA' }"> 
							     selected="selected"</c:if>>
								Objetiva</option>
							<option value="dissertativa"
								<c:if test="${questao.id != null && questao.tipoQuestao == 'DISSERTATIVA' }"> 
							     selected="selected"</c:if>>Dissertativa</option>
						</select> <span class="material-input"></span>

					</div>

					<div class="col-md-6 col-md-offset-1 ">
						<label> Marcadores </label> <select name="marcSelecionados"
							required id="select-tools" multiple
							placeholder="Escolha um	 marcador...">

							<c:if test="${questao.id != null }">
								<c:forEach var="marcador" items="${questao.marcadores }">
									<option value="${marcador.id}" selected="selected">
										${marcador.descricao }</option>
								</c:forEach>

							</c:if>
						</select>
					</div>


					<div class="col-md-2 col-md-offset-1">
						<label> Nivel de Dificuldade </label> <select
							name="nivel_dificuldade" class="form-control input-lg">
							<c:forEach var="i" begin="1" end="5">
								<option value="${i}"
									<c:if test="${questao.id != null && questao.nivel_dificuldade == i }"> 
							     selected="selected" 				</c:if>>
									${i}</option>
							</c:forEach>
						</select>
					</div>

					<div class="col-md-10 col-md-offset-1">
						<label> Enunciado </label>
						<textarea name="descricao" id="descricao" rows="10" cols="80"> 
						 
						 <c:if test='${questao.id != null }'>
						 ${questao.descricao }
						 </c:if>
 
                        </textarea>
					</div>
					<script>
						CKEDITOR.replace('descricao');
					</script>

				</div>
				<div class="col-md-11 col-md-offset-1" id="objetiva">

					<div class="col-md-5 ">
						<label> Numero de alternativas </label> <select
							<c:if test="${questao.id != null }"> disabled="disabled" </c:if>
							id="numeroAlternativas" onchange="getvalNumero();"
							name="numero_alternativas" class="form-control input-lg">
							<option value="3"
								<c:if test="${questao.id != null && questao.numero_alternativas == 3  && questao.tipoQuestao == 'OBJETIVA'}"> 
							     selected="selected" 				</c:if>>3</option>
							<option value="4"
								<c:if test="${questao.id != null && questao.numero_alternativas == 4  && questao.tipoQuestao == 'OBJETIVA'}"> 
							     selected="selected" 				</c:if>>4</option>
							<option value="5"
								<c:if test="${questao.id != null && questao.numero_alternativas == 5 && questao.tipoQuestao == 'OBJETIVA'}"> 
							     selected="selected" 				</c:if>>5</option>
						</select>

						<c:if test="${questao.id != null }">
							<input value="${questao.numero_alternativas }"
								name="numero_alternativas" style="display: none;">
						</c:if>


					</div>

					<c:if test="${questao.id == null}">
						<div id="alternativas"></div>
					</c:if>

					<c:if
						test="${questao.id != null &&  questao.tipoQuestao == 'OBJETIVA' }">
						<c:forEach var="i" begin="0"
							end="${(questao.numero_alternativas) - 1}">

							<div class="col-md-12">
								<div class="col-md-1">
									<c:if test="${questao.respostas[i].valor == false }">
										<input class='btn btn-danger btn-just-icon' id='desativo'
											style='width: 50px; padding: 10px;' name='valores' value='F'
											onclick='changeButton(this)'>
									</c:if>

									<c:if test="${questao.respostas[i].valor == true }">
										<input class="btn btn-primary btn-just-icon" id="ativo"
											style="width: 50px; padding: 10px;" name="valores" value="V"
											onclick="changeButton(this)">
									</c:if>
								</div>
								<div class="col-md-11 panel">
									<div
										class="panel-heading accordion-toggle question-toggle collapsed"
										data-toggle="collapse" data-parent="#faqAccordion"
										data-target="#question${i }">
										<h4 class="panel-title">
											<a href="#" class="ing"> <c:if test="${i == 0 }"> A)</c:if>
												<c:if test="${i == 1 }"> B)</c:if> <c:if test="${i == 2 }"> C)</c:if>
												<c:if test="${i == 3 }"> D)</c:if> <c:if test="${i == 4 }"> E)</c:if>
											</a>
											<div id="enunciado${i}"></div>
										</h4>
									</div>
									<div id="question${i }" class="panel-collapse collapse"
										style="height: 0px;">
										<div class="panel-body">
											<div class="col-md-12">
												<textarea name='enunciados' class="alternativ${i}"
													id="alternativ${i }" rows="10" cols="80">													
													${questao.respostas[i].descricao }													
											   </textarea>
											</div>
											<script>											
											$('.alternativ' + ${i}).each(function() {
												CKEDITOR.replace(this.id);
											});										
											</script>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>


					</c:if>
				</div>

				<div class="col-md-10 col-md-offset-1" id="dissertativa"
					style="display: none;">
					<div class="form-group">
						<div class="form-group label-floating is-empty">
							<label class="control-label"> Resposta esperada na
								questão.</label>
							<textarea class="form-control" rows="5" name="resp_esperada"><c:if
									test="${questao.id != null && questao.tipoQuestao == 'DISSERTATIVA' }">${questao.respostas[0].resp_esperada }	</c:if></textarea>
							<span class="material-input"></span>
						</div>
					</div>
				</div>
		</div>

		<c:if test="${questao.id != null }">
			<c:if test="${questao.tipoEstadoQuestao != 'ATIVO' }">
				<a href="../ativar_questao/${questao.id }"
					class="btn btn-success pull-left">Reativar Questão</a>
			</c:if>

			<c:if test="${questao.tipoEstadoQuestao == 'ATIVO' }">
				<a href="../inativar_questao/${questao.id }"
					class="btn btn-danger pull-left">Inativar Questão</a>
			</c:if>

			<button type="submit" class="btn btn-primary pull-right">Editar
				Questão</button>
		</c:if>

		<c:if test="${questao.id == null }">
			<button type="submit" class="btn btn-primary pull-right">Criar
				Questão</button>
		</c:if>

		<div class="clearfix"></div>



		</form>




	</div>

</div>









<c:import url="/WEB-INF/paginas/template/rodape.jsp" />