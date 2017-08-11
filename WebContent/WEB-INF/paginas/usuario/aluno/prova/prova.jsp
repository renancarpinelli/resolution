<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />

<script src="<c:url value="/resources/timer/TimeCircles.js"/>"></script>

<link href="<c:url value="/resources/timer/TimeCircles.css"/>"
	rel="stylesheet" />

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header"></div>
			<div class="modal-body">
				<div class="col-md-12">

					<div class="col-md-5 col-md-offset-1">
						<img src='data:image/jpeg;base64,${QRCode }'
							class="img-rounded img-responsive"
							style="height: 240px; width: 240">
					</div>
					<div class="col-md-6 ">
						<h2>Libere sua prova</h2>
						<h6>Abra nosso aplicativo pelo celular e libere sua prova
							lendo o código</h6>
					</div>


				</div>
				<div class="modal-footer">
					<div class="col-md-2">
						<a href="../listaProvasAluno"
							class="btn btn-sm  btn-danger pull-left"> <i
							class="material-icons"> undo</i> Voltar
							<div class="ripple-container"></div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>





<c:import url="/WEB-INF/paginas/template/corpo.jsp" />



<script>
	function enviarAjax(data) {
		var json;
		jQuery.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			url : "../../services/aluno/prova",
			type : "POST",
			dataType : "json",
			data : JSON.stringify(data),
			async : false,
			success : function() {
				console.log("foi")
			},
		});
	}

	(function($) {
		$.fn.serializeFormJSON = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name]) {
					if (!o[this.name].push) {
						o[this.name] = [ o[this.name] ];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};
	})(jQuery);

	function liberarProva() {
		var json;
		jQuery.ajax({
			url : "../../services/aluno/iniciarProva/${alunoLogado.id}/${codigo}",
			type : "GET",
			dataType : "json",
			async : false,
			success : function(data) {
				json = data;
				clearInterval(interval);
				iniciarProva(json);
			},
			error : function() {
				console.log("Bloqueada")
			}
		});
	}

	function gerarTempo(timeInMilles) {
		var date = new Date(timeInMilles);
		var data = date.getFullYear() + "-" + (date.getMonth() + 1) + "-"
				+ date.getDate() + "-" + " " + date.getHours() + ":"
				+ date.getMinutes() + ":00";
		$('#DateCountdown').attr('data-date', data)
	}

	function gerarTempoQuestao(timeInMilles) {
		$("#tquestao").empty();
		$("#tquestao")
				.append(
						'<div id="DateQuestao'
								+ qSelecionada
								+ '" data-timer="'
								+ (timeInMilles * 0.001)
								+ '" style="height: 125px; padding: 0px; box-sizing: border-box; background-color: transparent;"></div>');

		$("#DateQuestao" + qSelecionada).TimeCircles({
			"animation" : "ticks",
			"bg_width" : 0.2,
			"fg_width" : 0.03,
			"circle_bg_color" : "#90989F",
			"time" : {
				"Days" : {
					"text" : "Days",
					"color" : "#40484F",
					"show" : false
				},
				"Hours" : {
					"text" : "Horas",
					"color" : "#4caf50",
					"show" : true
				},
				"Minutes" : {
					"text" : "Minutos",
					"color" : "#4caf50",
					"show" : true
				},
				"Seconds" : {
					"text" : "Seconds",
					"color" : "#4caf50",
					"show" : true
				}
			}
		});

		$("#DateQuestao" + qSelecionada).TimeCircles().addListener(
				function(unit, value, total) {
					if (total <= 0) {
						$("#DateQuestao" + qSelecionada).TimeCircles()
								.destroy();
						console.log(indiceQuestao)
						console.log(sizeProva)
						if (indiceQuestao == sizeProva) {
							$('form').submit();
						} else {
							abrirQuestao(indiceQuestao + 1);
						}

					}
				});

	}

	function iniciarProva(json) {
		$('#myModal').modal('hide');
		$('#prova').show();

		if (json.prova.questoesDaProva[0].tempo_questao == null) {
		gerarTempo(json.prova.data_final)

		$("#DateCountdown").TimeCircles({
			"animation" : "ticks",
			"bg_width" : 0.2,
			"fg_width" : 0.03,
			"circle_bg_color" : "#90989F",
			"time" : {
				"Days" : {
					"text" : "Days",
					"color" : "#40484F",
					"show" : false
				},
				"Hours" : {
					"text" : "Horas",
					"color" : "#4caf50",
					"show" : true
				},
				"Minutes" : {
					"text" : "Minutos",
					"color" : "#4caf50",
					"show" : true
				},
				"Seconds" : {
					"text" : "Seconds",
					"color" : "#4caf50",
					"show" : true
				}
			}

		});

		$("#DateCountdown").TimeCircles().addListener(
				function(unit, value, total) {
					if (total <= 0) {
						$('form').submit();
						window.onbeforeunload = null;
						window.location = "../listaProvasAluno";
					}
				});

		window.onbeforeunload = function(e) {
			return confirm('Are you sure you want to leave the page?');
		};
		}

		gerarProva(json);

	}

	var qSelecionada;
	var jsonDaProva;
	var sizeProva;
	var indiceQuestao = 0;

	function abrirQuestao(idQuestao) {

		indiceQuestao = idQuestao;

		if (qSelecionada != null) {
			$('#' + qSelecionada).hide();
		}
		$('#q' + idQuestao).show();
		qSelecionada = "q" + idQuestao;

		if (jsonDaProva.questoesDaProva[idQuestao].tempo_questao != null) {
			$('.DateCountdown').hide();
			$('.DateQuestao').show();
			gerarTempoQuestao(jsonDaProva.questoesDaProva[idQuestao].tempo_questao)
		}
		console.log(sizeProva)
		if (idQuestao == sizeProva) {
			$("#btnSalvar").show();
			$("#btnProximo").hide();
		} else {
			$("#btnProximo").show();
			$("#btnSalvar").hide();
		}
	}

	function gerarProva(json) {
		var prova = $('.prova');
		var questao;
		var txtResposta = '';
		var respostaa;
		var input;
		var alternativa;
		var questaoDaProva;
		var btn;
		var btns = $('#btns');
		jsonDaProva = json.prova;
		sizeProva = json.prova.questoesDaProva.length - 1;

		$('#inputId').attr('value', json.id);
		for (var i = 0; i < json.prova.questoesDaProva.length; i++) {

			questaoDaProva = json.prova.questoesDaProva[i];
			questao = json.prova.questoesDaProva[i].questao;

			if (questaoDaProva.tempo_questao != null) {
				btn = '<button class="btn btn-primary btn-sm disabled btn'+i+' "  id=' + i
						+ '> '
						+ (i + 1) + '  </button>';
			} else {
				btn = '<button class="btn btn-primary btn-sm btn' + i
						+ '"  id=' + i + ' onclick="abrirQuestao(this.id)"> '
						+ (i + 1) + '  </button>';
			}

			btns.append(btn)

			if (questao.tipoQuestao == 'DISSERTATIVA') {
				txtResposta = '<div>  <textarea name="'+questaoDaProva.id+'" class="form-control" rows="5"></textarea>   </div>';
			} else {
				for (var j = 0; j < questao.respostas.length; j++) {
					resposta = questao.respostas[j];
					input = '<input type="radio" name="' + questaoDaProva.id
							+ '" value="%' + resposta.id + '" >';
					txtResposta += '  <div class="col-md-12">  <div class="col-md-1 resp ">'
							+ input
							+ '</div> <div class="col-md-10">'
							+ resposta.descricao + '</div>   </div> ';
				}
			}
			questao = ' <input value="'+questaoDaProva.id+'"name="questoesDaProva" style="display: none;">  <div class="col-md-12 questao" style="display: none;" id="q'+i+'" > <h5 class="q"> Questão '
					+ (i + 1)
					+ '  </h5>   <div col-md-10 col-md-ofsset-1>  '
					+ questao.descricao
					+ '  </div>  <div> '
					+ txtResposta
					+ ' </div>    </div>';
			prova.append(questao);
			txtResposta = '';
		}

		qSelecionada = 'q0';
		abrirQuestao(0)
	}

	$(window).load(function() {
		$('#myModal').modal('show');
		interval = setInterval(liberarProva, 3000);

		$('form').submit(function(e) {
			e.preventDefault();
			var data = $(this).serializeFormJSON();
			console.log(data)
			enviarAjax(data);
			window.onbeforeunload = null;
			window.location = "../listaProvasAluno";
		});

		$('#btnProximo').click(function() {
			$(".btn" + indiceQuestao).removeClass('btn-primary')
			abrirQuestao(indiceQuestao + 1);
		});
	});
</script>

<style>
.cabecalho {
	background: #fcf9f8;
	border-radius: 5px;
}

.resp {
	width: 0;
}

.q {
	color: #000000;
}

.containe {
	border-color: #fff;
	background-color: #fff;
	border-radius: 5px;
	margin: 20px;
	padding-right: 0;
	padding-left: 0;
}

.questao {
	margin-top: 10px;
	border-bottom: 1px solid #ccc;
	background-color: #fff;
	padding: 20px 30px;
}
</style>

<div class="col-md-12 containe" style="display: none;" id="prova">
	<div class="col-md-12 cabecalho">
		<div class="col-md-9" id="btns"></div>

		<div class="col-md-3 DateCountdown" style="text-align: center;">
			<label> Tempo restante de prova </label>
			<div id="DateCountdown" data-date=""
				style="height: 125px; padding: 0px; box-sizing: border-box; background-color: transparent;"></div>
		</div>

		<div class="col-md-3  DateQuestao"
			style="text-align: center; display: none;">
			<label> Tempo restante da questão </label>
			<div id="tquestao"></div>
		</div>

	</div>

	<form>
		<input id="inputId" name="id" style="display: none;">
		<div class="col-md-12 prova"></div>
		<button type="submit" id="btnSalvar" style="display: none;">Salvar</button>
		<button type="button" id="btnProximo">Salvar e ir para
			proxima</button>
	</form>




</div>

<c:import url="/WEB-INF/paginas/template/rodape.jsp" />