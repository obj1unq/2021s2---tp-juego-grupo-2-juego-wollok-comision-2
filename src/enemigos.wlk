import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*
import randomizer.*


class Enemigo{
	var property energia
	var property position
	var property arma
	var property direccion
		
	method esSolido() = false
	
	method image() = "policia-" + self.sufijo() + ".png"
	
	method sufijo() = direccion.sufijo()
	
	method fuerza() = arma.factorAtaque()
	
	method moverA(_direccion) {
		direccion = _direccion
		self.actualizarPosicion(direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = self.posicionActualONueva(nuevaPosicion)
	}
	
	method posicionActualONueva(nuevaPosicion) = if (self.validarPosicion(nuevaPosicion)) {position} else {nuevaPosicion}
	
	method validarPosicion(posicion) = game.getObjectsIn(posicion).any({objeto => objeto.esSolido()})
	
	method sufrir(fuerzaPersonaje) {
		energia -= fuerzaPersonaje
		self.validarEnergia()
	}
		
	method morir() {
		game.removeVisual(self)
//		game.AddVisual() Posible cadaver
	}
	
	method validarEnergia() {
		if (energia <= 0) {
			self.morir()
		} 
	}
}

object enemigoFactory {
	
	method nuevoEnemigo() {
		game.addVisual(new Enemigo(direccion = abajo, arma = cuchillo, energia = randomizer.energy(), position = randomizer.emptyPosition()))
	}
}

class JefeEnemigo inherits Enemigo{
	var property artefacto = new Tarjetas(puertaQueAbre = "edificio")
	
	override method image() {
		return "policia-down.png"
	}	
	
	method pelear() {
		self.ganarPelea()		
		if (self.esMasFuerteQue(personaje)) {
			personaje.perder()			
		}
		else {
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method tirarArtefacto() {
		game.addVisual(artefacto) 
	}
	
	
	
	override method morir() {
		energia = 0
		self.tirarArtefacto()
		//Poner cuerpo de enemigo?
	}
	method ganarPelea(){
		
	}
}
