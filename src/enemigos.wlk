import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*
import randomizer.*
import config.*

class Enemigo inherits Colisiones{
	var property energia
	var property position
	var property direccion
	const property fuerza = 5
	
	method image() = "policia.png"
	
	method moverA(_direccion) {
		direccion = _direccion
		self.actualizarPosicion(direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = self.posicionActualONueva(nuevaPosicion)
	}
	
	method posicionActualONueva(nuevaPosicion) = if (self.validarPosicion(nuevaPosicion)) {position} else {nuevaPosicion}
	
	method validarPosicion(posicion) = game.getObjectsIn(posicion).any({objeto => objeto.esSolido()})
	
	override method sufrir(fuerzaPersonaje) {
		energia -= fuerzaPersonaje
		self.validarEnergia()
	}
		
	method morir() {
		game.removeVisual(self)
	}
	
	method validarEnergia() {
		if (energia <= 0) {
			self.morir()
		} 
	}
	
	override method actuar() {
		game.whenCollideDo(self, {heroe => self.cortar(heroe)})
	}
	
	method cortar(_enemigo){
		_enemigo.sufrir(fuerza)
	}
}

object enemigoFactory {
	
	method nuevoEnemigo() {
		game.addVisual(new Enemigo(direccion = abajo, energia = randomizer.energy(), position = randomizer.emptyPosition()))
	}
	
	method nuevoEnemigoEn(posicion){
		game.addVisual(new Enemigo(direccion = abajo, energia = randomizer.energy(), position = posicion))
	}
	
}

class JefeEnemigo inherits Enemigo{
	
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
		game.addVisual(new Tarjeta(position = self.position())) 
	}
	
	override method morir() {
		self.tirarArtefacto()
		super()
		//Poner cuerpo de enemigo?
	}
}
