import wollok.game.*
import personaje.*
import config.*
//Artefactos (Armamento y Llaves)
class ArmaDeFuego inherits Colisiones{
	var property balas
	var property poder
	const property image
	const property position
	
	method usar (){
		balas -= 1
	}
	method factorAtaque(){
		return poder.min(10+balas)
	}
	
	method cargar(_balas) {
		balas += _balas
	}
	
	override method actuar() {
		personaje.recogerArma(self)
	}	

}

class Bala inherits Colisiones{
	var property poder
	var property position
	var property direccionBala
	
	method image() = "bala" + self.sufijo() + ".png"
	
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
	
	override method actuar() {
		self.impacto(game.uniqueCollider(self))
	}
	
	override method sufrir(danio) {
		game.removeVisual(self)
	}
}



class Tarjeta inherits Colisiones{
	var property image = 'card.png'
	var property position
	
	override method actuar() {
		personaje.tengoLaTarjeta()
		game.removeVisual(self)
	}
}

class Puerta inherits Colisiones{
	const property position
	const property image = "door.png"
	const property seAbre = true
	
	method posiciones(){
		return [position]
	}
	
	override method esSolido() = false
	
	method abrirPuerta(){
		config.ganarJuego()
		
	}
	
	override method actuar() {
		self.validarAbrir()
	}
	
	method validarAbrir() {
		if (personaje.tieneTarjeta()) {
			self.abrirPuerta()
		}else{
			personaje.actualizarPosicion(personaje.position().left(1))
			game.say(personaje, "No puedo escapar! :(")
		}
	}
}

class Pared inherits Colisiones{
	var property position
	var property image = 'pared.png'
	const property seAbre = false
	
	override method esSolido() = true
	
	method posiciones(){
		return [position]
	}
	
	method esLimite(){
		return self.position().x()==0
				|| self.position().y()==0
				|| self.position().x() == game.width()-1
				|| self.position().y() == game.height()-1
	}
}
class Botiquin inherits Colisiones{
	var property cantidadDeGasa
	const property position
	const property image = 'botiquin.png'
	
	override method actuar() {
		self.validarCurar()
	}
	
	method validarCurar() {
		if(!personaje.estoyImpecable()){
			self.curar()
		}
	}
	
	method curar() {
		personaje.curarse(cantidadDeGasa)
		game.removeVisual(self)
	}
}
class Municion inherits Colisiones{ 
	var property cantidadDeBalas
	const property position
	var property image = 'ammo.png'
	
	override method actuar() {
		self.validarRecarga()
	}
	
	method validarRecarga() {
		if(personaje.estoyArmado()) {
			self.recargarLasBalas()
		}
	}
	
	method recargarLasBalas(){
		personaje.recargar(cantidadDeBalas)
		game.removeVisual(self)
	}
}
