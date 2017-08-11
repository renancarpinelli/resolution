package br.senai.informatica.sp.resolution.restcontroller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import br.senai.informatica.sp.resolution.dao.usuario.UsuarioDao;
import br.senai.informatica.sp.resolution.model.usuarios.Aluno;
import br.senai.informatica.sp.resolution.model.usuarios.Usuario;

@RestController
@RequestMapping("/services/usuario")
public class UsuarioRestController {

	@Autowired
	private UsuarioDao usuarioDao;
	private Usuario usuario;

	@RequestMapping(value = "/logar", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Usuario> logar(@RequestBody String json) {
		try {
			JSONObject job = new JSONObject(json);
			usuario = usuarioDao.logar(job.getString("email"), job.getString("senha"));
			if (usuario != null ) {
				return ResponseEntity.ok().body(usuario);
			} else {
				return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
			}
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
