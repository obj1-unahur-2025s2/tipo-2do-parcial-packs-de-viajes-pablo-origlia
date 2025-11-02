class Pack {
  var duracion
  var precioBase
  const beneficios = #{}
  var coordinador
  
  method beneficiosVigentes() = beneficios.filter({ b => b.estaVigente() })
  
  method costoFinal() = precioBase + self.beneficiosVigentes().sum({ b => b.costo() })
  
  method esPremium()
}

class PackNacional inherits Pack {
  var property provincia
  const actividades = #{}
  
  override method esPremium() = (duracion > 10) and coordinador.esAltamenteCalificado()
}

class PackInternacional inherits Pack {
  var destino
  var cantidadDeEscalas
  var esInteres
  
  override method costoFinal() = super() * (1 + 0.2)
  
  override method esPremium() = (esInteres and (duracion > 20)) and (cantidadDeEscalas == 0)
}

class Coordinador {
  var cantidadDeViajes
  var estaMotivado
  var experiencia
  var rol
  const rolesValidos = #{guia, asistente, acompaniante}
  
  method rol() = rol
  
  method cambiarRol(unRol) {
    if (not rolesValidos.contains(unRol)) self.error("Rol inválido.")
    rol = unRol
  }
  
  method estaMotivado() = estaMotivado
  
  method experiencia() = experiencia
  
  method esAltamenteCalificado() = (cantidadDeViajes > 20) and rol.condicionAdicional(self)
}

object guia {
  method condicionAdicional(unCoordinador) = unCoordinador.estaMotivado()
}

object asistente {
  method condicionAdicional(unCoordinador) = unCoordinador.experiencia() >= 3
}

object acompaniante {
  method condicionAdicional(unCoordinador) = true
}

object otroRol {
  
}

class Beneficio {
  var tipo
  var costo
  var estaVigente
  
  method costo() = costo
  
  method estaVigente() = estaVigente
}