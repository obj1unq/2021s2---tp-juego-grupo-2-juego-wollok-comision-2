import wollok.game.*
import personaje.*

class ArmaDeFuego {
	var property balas
	var property poder
	var property image
	
	method usar (){
		balas -= 1
	}
	method factorAtaque(){
		return poder.min(10+balas)
	}
	
	method cargar(_balas) {
		balas += _balas
	}
	
	method actuar() {
		personaje.recogerArma(self)
	}	

}

class Bala {
	var property poder
	var property position
	var property direccionBala
	
	method image() = "bala.png"//Cuando tengamos mas fotos: "Bala" + self.sufijo() + ".png"
	
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



class Tarjeta {
	var property position
	
	method image() = "card.png"
	
	method seAbre() = false
	
	method sufrir(danio){/*No hace nada por el polimorfismo*/}
	
	method actuar() {
		personaje.tengoLaTarjeta()
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
	
//	method abrir(){
//		if(personaje.tieneTarjeta()){
//			game.removeVisual(self)
//			game.say(personaje, "¡Escapé!")
//			game.schedule(2000,{
//				game.stop()
//			})			
//		} else {
//			game.say(personaje, "No puedo abrir la puerta")
//		}
//	}
	
	method sufrir(danio){/*No hace nada por el polimorfismo*/}
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
	var property cantidadDeGasa
	var property image
	
	method actuar() {
		self.curar()
	}
	
	method curar() {
		personaje.curarse(cantidadDeGasa)
	}
	method seAbre() = false
}
class Municion{ 
	var property cantidadDeBalas
	var property image
	
	method actuar() {
		self.recargarLasBalas()
	}
	
	method recargarLasBalas(){
		personaje.recargar(cantidadDeBalas)
	}
	method seAbre() = false
}
