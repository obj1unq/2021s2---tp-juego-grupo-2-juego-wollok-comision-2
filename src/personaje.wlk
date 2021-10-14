import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 100 
	var property position = game.at(10, 10)
	var property artefactos = #{cuchillo, pistola}
	var direccion = abajo 
	

	method image() {
		return 	"policia-" + self.sufijo() + ".png" 
	}
	
	method sufijo() {
		return direccion.sufijo()
	}
	
	method moverA(_direccion) {
		//Validar movimiento con all o any
		direccion = _direccion
		self.actualizarPosicion(_direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method fuerza(){
		return 10 + self.armaMasPoderosa().factorAtaque()
	}
	
	
	method recogerArtefacto(_artefacto){
		artefactos.add(_artefacto)
	}
	
	
	method armaMasPoderosa() {
		return artefactos.max({cosa => cosa.factorAtaque()})
	}
	
	method pegarYSufrir(){
		self.lastimar(game.uniqueCollider(personaje))
		self.sufrir(game.uniqueCollider(personaje).fuerza())
		self.validarEnergia()
	}
	
	
	method lastimar(_enemigo) {
		self.armaMasPoderosa().usar()
		_enemigo.sufrir(self.fuerza())
		
	}
	
	method sufrir(danoRecibido){
		energia  -= danoRecibido
	}
	
	method validarEnergia() {
		if (energia <= 0) {
			self.perder()
		}
	}
	
	method perder(){
		self.error("YOU LOST")
		//Opcionalmente ponemos una foto del cadaver
	}
	
//	method tirarArma() {
//		game.addVisual(self.arma())
//		artefactos.remove(self.arma())
//	}
	
	
//	method ganarPelea(enemigo) {
//		enemigo.morir()
//		self.deduccionDeVida()
//	}
	
//	method deduccionDeVida() {
//		
//	}
	
	
}