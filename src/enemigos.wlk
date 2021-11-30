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
	var property tarjeta = new Tarjetas(puertaQueAbre = "edificio")
	
	override method image() = "policia-down.png"
	
	method atacar(){
		game.onTick(1000, "balazo", {self.superDisparo()})
	}
	
	method superDisparo() {
		if(energia > 0) {
		const tiro = new Bala(direccionBala = direccion, position = direccion.siguiente(self.position()), poder = 0)
		const tiro2 = new Bala(direccionBala = direccion, position = direccion.siguiente(self.positionUnder()), poder = 0)
		game.addVisual(tiro)
		game.onTick(500, "Ricochet", {tiro.desplazarse()})
		game.onCollideDo(tiro, {enemigo => tiro.impacto(enemigo)
								game.removeTickEvent("Ricochet")
								game.removeVisual(tiro)})
		game.addVisual(tiro2)
		game.onTick(500, "Ricochet2", {tiro2.desplazarse()})
		game.onCollideDo(tiro2, {enemigo => tiro2.impacto(enemigo)
								game.removeTickEvent("Ricochet2")
								game.removeVisual(tiro2)})
		
	}
}
	
	method positionUnder() = self.position().down(1)
	
	method tirarArtefacto() {
		game.addVisual(tarjeta) 
	}
	
	override method morir() {
		self.tirarArtefacto()
		super()
		//Poner cuerpo de enemigo?
	}
}
