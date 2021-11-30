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
	
	method actuar() {
		self.impacto(game.uniqueCollider(self))
	}
	
	method sufrir(danio) {
		game.removeVisual(self)
	}
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
	const property image = "door.png"
	
	method posiciones(){
		return [position]
	}
	
	method seAbre(){
		return true
	}
	
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

class Pared{
	var property position
	var property image = 'pared.png'
	const property esSolido = true
	
	method posiciones(){
		return [position]
	}
	
	method esLimite(){
		return self.position().x()==0
				|| self.position().y()==0
				|| self.position().x() == game.width()-1
				|| self.position().y() == game.height()-1
	}
	
	method esSolido(){
		return true
	}
	
	method sufrir(nada){
		//No hace nada por el polimorfismo
	}
	method seAbre(){
		return false
	}
}
class Botiquin {
	
	method actuar() {
		self.curar()
	}
	
	method curar() {
		
	}
}
class Municion{ 
	
	method actuar() {
		self.recargarLasBalas()
	}
	
	method recargarLasBalas(){
		
	}
}






