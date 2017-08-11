package br.senai.informatica.sp.resolution.model.usuarios;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("Administrador")
public class Administrador extends Usuario {

}
