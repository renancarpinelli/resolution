package br.senai.informatica.sp.resolution.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.senai.informatica.sp.resolution.dao.questao.MarcadorDao;
import br.senai.informatica.sp.resolution.model.questao.Marcador;

@RestController
public class MarcadorRestController {

	@Autowired
	private MarcadorDao marcadorDao;

	@RequestMapping(value = "listarMarcadores", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<Marcador> listarMarcadores() {
		return marcadorDao.listar();
	}

}
