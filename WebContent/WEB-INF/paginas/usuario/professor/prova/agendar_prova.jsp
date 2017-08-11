<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>



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
			<div class="modal-body" style="text-align: center">
				<h5>Deseja realmente cancelar esta prova ?</h5>
				<a href="../adiarProva/${prova.id }" class="btn btn-danger btn-lg">
					<i class="material-icons">clear</i> Adiar Prova
				</a>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger btn-simple"
					data-dismiss="modal">Fechar</button>
			</div>
		</div>
	</div>
</div>




<c:import url="/WEB-INF/paginas/template/corpo.jsp" />


<link
	href="<c:url value="/resources/material-datetimepicker/bootstrap-material-datetimepicker.css"/>"
	rel="stylesheet" />

<script type="text/javascript"
	src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>

<script src="<c:url value="/resources/jquery/jquery-mask.js"/>"></script>
<script src="<c:url value="/resources/jquery/jquery.validate.min.js"/>"></script>

<script
	src="<c:url value="/resources/material-datetimepicker/bootstrap-material-datetimepicker.js"/>"></script>

<script>

	// Paginar tabela de turmas 
	function buscarAjax(url){
	var json;
	   jQuery.ajax({
	        url: url ,
	        type: "GET",
	        dataType: "json",
	        async: false,
	        success: function (data) {
	        	json = data;            
	        }
	    });	
	   return json;
}

var qtdPorPagina = 5;
var pagAtual = 0

   function paginar(tabela){
	   
       var json = buscarAjax("../../services/professor/turma/${professorLogado.id}");   
	   var tamanho = Object.keys(json).length;
	   var turma;
	   var txt;
	   	   
    		$('.'+tabela+'  > tbody > tr').remove();
    		var tbodyAtivo = $('.'+tabela+' > tbody');
    		for (var i = pagAtual * qtdPorPagina; i < tamanho && i < (pagAtual+1)* qtdPorPagina; i++){
    			turma = json[i];
    			txt = "<div class='checkbox checkbox-group required'>  <label>	<input type='checkbox'  name='turmas' value='"+turma.id+"' ><span class='checkbox-material'><span class='check'></span></span> </label></div>";   			
    			$(".selectTurmas").each(function() {    				  	  				
							$.each($(this).val(),function(key, value) {	
								if (value == turma.id ) {			
									txt = "<div class='checkbox checkbox-group required'>  <label>	<input type='checkbox' checked  name='turmas' value='"+turma.id+"' ><span class='checkbox-material'><span class='check'></span></span> </label></div>";	
				    				$(".selectTurmas option[value='"+turma.id+"']").remove();
				    				return false;
								}
							});
					
						});
    			
    			tbodyAtivo.append($("<tr id='linha_"+turma.id+"'>")
    				    .append($("<td >").append(txt))  				  
    				    .append($("<td>").append(turma.descricao)));		
    		}
    		
    		$("#numeracao"+tabela).text("Página "+ (pagAtual+1)+ " de "+ Math.ceil(tamanho/qtdPorPagina));
    		
    		$("#proximo"+tabela).click(function(){
    			if(pagAtual < tamanho/qtdPorPagina-1){
    				pagAtual++;
    				paginar(tabela);
    				configBotoes(tabela);
    			}
    		});
    		
    		$("#anterior"+tabela).click(function(){
    			if(pagAtual > 0){
    				pagAtual--;
    				paginar(tabela);
    				configBotoes(tabela);
    			}
    		});    		
    	}
    	
    	function configBotoes(tabela){
    		$("#proximo"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual > tamanho/qtdPorPagina+1);
    		$("#anterior"+tabela).prop("disable", tamanho <= qtdPorPagina || pagAtual == 0);
    	}
    	
    	$(function(){ 	
    		paginar("ativo")
    	})	
    	
    	
  

   // Plugin data e hora 
	$(document).ready(function() {
		$('#dataProva').bootstrapMaterialDatePicker({
			format : 'DD-MM-YYYY HH:mm',
			minDate : new Date()
		});
		
		// Mascara campo
		$('.tempoProva').mask('00:00');

		$('#tempoPorQuestao').click(function() {
		     $(".tempoPorQuestaoInput").toggle(this.checked);
		     	    		     
		     if(this.checked){			    	 
		    	 $("#tempoProva").attr('disabled', 'disabled');		
		    	 $(".tempoQuestao").attr('required', 'required');	
		    	 $("#tempoProva").val('');
		     }else{	
		    	 $(".tempoQuestao").removeAttr("required");	
		    	 $("#tempoProva").removeAttr("disabled");
		     }	     
		});
				  	    		    	
		function alerta(texto, type) {
			$.notify(texto, {
				type : type,
				placement : {
					from : 'top',
					align : 'rigth'
				}
			});
		}
		
		$.validator.prototype.checkForm = function() {
		    //overriden in a specific page
		    this.prepareForm();
		    for (var i = 0, elements = (this.currentElements = this.elements()); elements[i]; i++) {
		        if (this.findByName(elements[i].name).length !== undefined && this.findByName(elements[i].name).length > 1) {
		            for (var cnt = 0; cnt < this.findByName(elements[i].name).length; cnt++) {
		                this.check(this.findByName(elements[i].name)[cnt]);
		            }
		        } else {
		            this.check(elements[i]);
		        }
		    }
		    return this.valid();
		};
		
		  jQuery.validator.addMethod("noSpace", function(value, element) { 
			  return value.indexOf(" ") < 0 && value != ""; 
			}, "");
						
		$('#agendarProva').validate({
			rules: {
				tempoProva:{
					required :true,
					minlength: 5
				},
				tempoQuestao:{
					required :true,
					minlength: 5
				},				
				turmas:{
					required :true
				},
				nota:{
					required :true,
					noSpace: true					
				}
			},
	        errorPlacement : function(error, element) {
				$(element).parent('div').addClass('has-error');
			}
	    });
		
		
  	$("#btnAgendarProva").on('click', function() { 		
  			if($('#agendarProva').valid()){
  				$("#agendarProva").submit();
  			};
		});
  		
  	});
    		
</script>

<style>
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

.input {
	margin-bottom: -5 !important;
}

.tempoProva {
	text-align: center;
}

.error {
	border-bottom-color: red;
}

.checkbox {
	width: 0;
}
</style>

<ol class="breadcrumb">
	<li><a href='<c:url value="home"></c:url>'>Home</a></li>
	<li class="active">Agendar Prova</li>
</ol>

<div class="card card-plain" style="text-align: center;">
	<div class="card-header" data-background-color="green">
		<h4 class="title">Agendar Prova</h4>
	</div>
</div>


<div class="col-md-12">

	<form action="../agendarProvaSistema/${prova.id }" method="post"
		id="agendarProva">

		<div class="col-md-8 questoes">

			<div class="col-md-12 ">
				<div class="col-md-1">
					<h6>Nota</h6>
				</div>

				<div class="col-md-2 tempoPorQuestaoInput"
					<c:if test="${prova.stringTempoProva != nulll || prova.tipoEstadoProva == 'CRIADA' }"> style="text-align: center; display: none;"   </c:if>>
					<h6>Tempo</h6>
				</div>

				<div class="col-md-9 ">
					<div class="col-md-2 col-md-offset-1">
						<h6>Questões</h6>
					</div>
					<div class="col-md-5 col-md-offset-4">
						<div class="togglebutton" style="margin-top: 15px;">
							<label> <input type="checkbox"
								<c:if test="${prova.stringTempoProva == null && prova.tipoEstadoProva == 'AGENDADA' }"> checked="checked" </c:if>
								id="tempoPorQuestao"> Tempo por questão
							</label>
						</div>
					</div>
				</div>
			</div>
			<c:forEach var="questaoDaProva" items="${prova.questoesDaProva }">
				<div class="col-md-12 questao ">
					<div class="col-md-1">
						<input
							<c:if test="${questaoDaProva.nota != null }" > value="${questaoDaProva.nota }"  </c:if>
							name="nota" class="nota" required="required"> <span
							class="material-input"></span>
					</div>

					<div class="col-md-2 tempoPorQuestaoInput"
						<c:if test="${questaoDaProva.stringTempo == null || prova.tipoEstadoProva == 'CRIADA' }"> style="display: none;"   </c:if>>
						<div class="form-group">
							<label class="control-label">Tempo da Questão </label> <input
								<c:if test="${questaoDaProva.stringTempo != null }" > value="${questaoDaProva.stringTempo }"  </c:if>
								required="required" name="tempoQuestao"
								class="form-control input tempoProva tempoQuestao"
								placeholder="00:00"><span class="material-input"></span>
						</div>
					</div>

					<div class="col-md-9 ">
						<div class="">
							<div class="col-md-12">
								<div class="form-group ">
									${questaoDaProva.questao.descricao }</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="col-md-4  ">
			<div class="card">
				<div class="card-header" style="text-align: center;"
					data-background-color="green">
					<h4 class="title">Configurações</h4>
				</div>
				<div class="card-content">
					<div class="row">
						<div class="col-md-6">
							<div class="input-group">
								<span class="input-group-addon"> <i
									class="material-icons">date_range</i>
								</span>
								<div class="form-group">
									<label class="control-label">Data e hora da prova </label> <input
										<c:if test="${prova.data_inicial != null }" >  
										value="<fmt:formatDate pattern="dd-MM-yyyy HH:mm" value="${prova.data_inicial.time }"/>"
										 </c:if>
										required="required" name="dataProva" id="dataProva"
										class="form-control input" placeholder="00/00/0000"><span
										class="material-input"></span>
								</div>
							</div>
						</div>

						<div class="col-md-6 ">
							<div class="input-group">
								<span class="input-group-addon"> <i
									class="material-icons">schedule</i>
								</span>
								<div class="form-group">
									<label class="control-label">Tempo de Prova </label> <input
										<c:if test="${prova.stringTempoProva != null || prova.tipoEstadoProva == 'CRIADA' }"> value="${prova.stringTempoProva }"  </c:if>
										required="required" name="tempoProva" id="tempoProva"
										<c:if test="${prova.stringTempoProva == null && prova.tipoEstadoProva == 'AGENDADA' }"> disabled="disabled"  </c:if>
										class="form-control input tempoProva" placeholder="00:00"><span
										class="material-input"></span>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-8 col-md-offset-2  ">
						<div class="form-group">
							<label class="control-label">Plataforma </label> <select
								name="plataforma" class="form-control">
								<option value="Web"
									<c:if test="${prova.tipoPlataforma != null && prova.tipoPlataforma == 'WEB' }"> selected="selected" </c:if>>Web</option>
							</select>
						</div>
					</div>
				</div>

			</div>
			<div class="clearfix"></div>
		</div>


		<select name="selectTurmas" multiple="multiple" class="selectTurmas" disabled="disabled" style="display: none;" >
			<c:if test="${prova.turmas[0].id != nulll }">
				<c:forEach var="turma" items="${prova.turmas }">
					<option value="${turma.id}" selected="selected">
						${turma.id}</option>
				</c:forEach>
			</c:if>
		</select>



		<div class="col-md-4 ">
			<div class="card card-plain" style="text-align: center;">
				<div class="card-header" data-background-color="green">
					<h4 class="title">Turmas</h4>
					<p class="category">Selecione as turmas que deseja aplicar a
						prova</p>
				</div>
				<div class="card-content table-responsive">
					<table class="table table-hover ativo ">
						<thead>
							<tr>
								<th>Selecione</th>
								<th>Descrição</th>
							</tr>
						</thead>
						<tbody>
							<!-- 							<c:if test="${prova.tipoEstadoProva == 'AGENDADA' }">
								<c:forEach var="turma" items="${prova.turmas }">
									<tr>
										<td>
											<div class='checkbox checkbox-group required'
												style="width: 0px;">
												<label> <input type='checkbox' checked="checked"
													disabled="disabled" name='turmas' value='${turma.id }'><span
													class='checkbox-material'></span>
												</label>
											</div>
										</td>
										<td>${turma.descricao }</td>
									</tr>
								</c:forEach>
							</c:if> -->
						</tbody>
					</table>
					<div class="card-footer text-center">
						<div class="col-md-12" style="padding: 0">
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
					<h6 style="color: #f44336; display: none;" id="erroturmas">
						Você deve selecionar uma turma</h6>
				</div>
			</div>
		</div>
</div>

<div class="col-md-12 col-offset-1">
	<c:if
		test="${prova.tipoEstadoProva != 'ADIADA' && prova.tipoEstadoProva != 'CRIADA'}">
		<button type="button" class="btn btn-danger pull-left"
			data-toggle="modal" data-target="#myModal"">Adiar Prova</button>
	</c:if>
	<button type="button" id="btnAgendarProva"
		class="btn btn-primary pull-right ">Agendar Prova</button>
</div>

</form>



<c:import url="/WEB-INF/paginas/template/rodape.jsp" />