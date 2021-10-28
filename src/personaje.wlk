import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 200 
	var property position = game.origin()
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
		if(self.hayEnemigo()) {
			self.lastimar(game.uniqueCollider(self))
		    self.sufrir(game.uniqueCollider(self).fuerza())
		}
		
	}
	
	method hayEnemigo() {
		return game.colliders(self).any({algo => algo.fuerza() > 0})//Modifico cuando esten las paredes
	}
	
	method lastimar(_enemigo) {
		self.armaMasPoderosa().usar()
		_enemigo.sufrir(self.fuerza())
	}
	
	method sufrir(danoRecibido){
		energia -= danoRecibido
		if (self.validarEnergia()) {
			self.perder()
		}
	}
	
	method validarEnergia() {
		return energia <= 0
	}
	
	method perder(){
		game.say(self,"YOU LOST")
		game.schedule(5000, {game.stop()})
		//Opcionalmente ponemos una foto del cadaver
	}
	
	
//	method tirarArma() {
//		game.addVisual(self.arma())
//		artefactos.remove(self.arma())
//	}
	
	
}