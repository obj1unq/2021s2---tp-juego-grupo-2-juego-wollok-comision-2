import wollok.game.*
import personaje.*
//Artefactos (Armamento y Llaves)
object cuchillo{	
	const balas = 0
	
	method image() {
		
	}
	
	method factorAtaque(){
		return 3
	}
	
	method usar() {
		// No hace nada por el polimorfismo
	}
	method abrePuerta(){
		return false
	}
}

class ArmaDeFuego {
	var property balas
	var property poder
	
	method usar (){
		balas -= 1
	}
	method factorAtaque(){
		return poder.min(10+balas)
	}
	
	method abrePuerta(){
		return false
	}
}

class Bala {
	var property poder
	var property position
	var property direccionBala
	
	method image() = "Bala.png"//Cuando tengamos mas fotos: "Bala" + self.sufijo() + ".png"
	
	method sufijo() = direccionBala.sufijo()
	
	method desplazarse(){
		self.actualizarPosicion(direccionBala.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method impacto(objeto) {
		objeto.sufrir(poder)
	}
	
	method sufrir(dano) {}
}

class Tarjetas {
	var property puertaQueAbre
	
	method abrePuerta(){
		return true
	}

}

class Puerta{
	const property esSolido = true
	const property position
	const property image = "puerta.png"
	
	method abrir(){
		if(personaje.tieneTarjeta()){
			game.removeVisual(self)
			game.say(personaje, "¡Escapé!")
			game.schedule(2000,{
				game.stop()
			})			
		} else {
			game.say(personaje, "No puedo abrir la puerta")
		}
	}
}







