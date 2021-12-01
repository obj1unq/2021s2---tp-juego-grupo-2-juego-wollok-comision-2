import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*
import randomizer.*
import config.*

class Enemigo{
	var property energia
	var property position
	var property arma
	var property direccion
		
	method esSolido() = false
	
	method image() = "policia.png"
	
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
	
	method actuar() {
		self.cortar(personaje)
	}
	
	method cortar(_enemigo){
		_enemigo.sufrir(self.fuerza())
	}
}

object enemigoFactory {
	
	method nuevoEnemigo() {
		game.addVisual(new Enemigo(direccion = abajo, arma = cuchillo, energia = randomizer.energy(), position = randomizer.emptyPosition()))
	}
}

class JefeEnemigo inherits Enemigo{
	const property tarjeta = new Tarjeta(image = 0, position = self.position())
	
	override method image() = "policia-down.png"
	
	method atacar(){
		game.onTick(1000, "balazo", {self.superDisparoSiVive()})
	}
	
	method superDisparoSiVive() {
		if(energia > 0) {
		self.superDisparo()
		}
	}
	
	method superDisparo() {
		const tiro = new Bala(direccionBala = direccion, position = direccion.siguiente(self.position()), poder = 0)
		const tiro2 = new Bala(direccionBala = direccion, position = direccion.siguiente(self.positionUnder()), poder = 0)
		config.configDisparo(tiro)
		config.configDisparo(tiro2)
	}
	
	method positionUnder() = self.position().down(1)
	
	method tirarArtefacto() {
		game.addVisual(tarjeta) 
	}
	
//	override method morir() {
//		self.tirarArtefacto()
//		super()
		//Poner cuerpo de enemigo?
//	}
}
