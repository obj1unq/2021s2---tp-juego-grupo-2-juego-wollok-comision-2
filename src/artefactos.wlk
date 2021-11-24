//import extras.*
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
	
	method image() = "Bala.png"
	
	
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
//		puertaQueAbre.Abrir()
	}

}






