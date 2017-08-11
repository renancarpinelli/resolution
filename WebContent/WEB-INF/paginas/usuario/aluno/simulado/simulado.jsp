<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/WEB-INF/paginas/template/cabecalho.jsp" />
<c:import url="/WEB-INF/paginas/template/corpo.jsp" />





<div class="col-md-10  col-md-offset-1">
	<div class="card card-plain">
		<div class="card-header" data-background-color="green">
			<h4 class="title">Simulado</h4>
		</div>
	</div>
</div>

<script>
	var qSelecionada = 1;

	function verCorreta(id) {				
		$("#respObj" + id).show();
	}

	function proxima(id) {

		console.log(id)

		var n = 0;
		n = (id + 1);

		console.log(n)
		$("#q" + qSelecionada).hide();
		qSelecionada++;
		$("#q" + id).show();

	}
	
	function reload(){
		window.location = "realizar_simulado";
    
	}
	
</script>

<style>
.questao {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 1px 10px 1px rgba(0, 0, 0, 0.14);
	padding: 10px;
}
</style>

<div class="col-md-10  col-md-offset-1">

	<c:forEach var="questao" varStatus="i" items="${questoes }">

		<div class="questao" id="q${i.count }"
			<c:if test="${i.count != 1 }">  style="display:none" </c:if>>
			<div>${questao.descricao }</div>
			<c:if test="${questao.tipoQuestao != 'DISSERTATIVA' }">
				<c:forEach var="alt" items="${questao.respostas }">
					<div class="col-md-12">
						<c:if test="${alt.valor == true }">
							<div class="col-md-1" id="respObj${i.count }" style="display: none;">
								<i class="material-icons text-success">done</i>
							</div>
							</c:if>
						<div class="col-md-11">${alt.descricao }</div>
					</div>
				</c:forEach>

				<button type="button" id="${i.count }" class="btn btn-warning"
					onclick="verCorreta(this.id)">Ver Correta</button>
			</c:if>
			<c:if test="${questao.tipoQuestao == 'DISSERTATIVA' }">
				<c:forEach var="alt" items="${questao.respostas }">

					
					
					<div class="col-md-10" id="respObj${i.count }" style="display: none;">
						<div>${alt.resp_esperada }</div>		
					</div>
					
				</c:forEach>								
				<button type="button" class="btn btn-warning" id="${i.count }"
					onclick="verCorreta(this.id)">Ver Resposta</button>
			</c:if>



			<c:if test="${i.count != fn:length(questoes)  }">
				<button type="button" class="btn btn-success" id="${i.count + 1 }"
					onclick="proxima(this.id)">Proxima</button>
			</c:if>

			<c:if test="${i.count == fn:length(questoes)  }">
				<button type="button" class="btn btn-danger" onclick="reload()">Fim</button>
			</c:if>
			</div>
	</c:forEach>



</div>



</div>


















<c:import url="/WEB-INF/paginas/template/rodape.jsp" />