import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 200 
	var property position = game.at(1, 1)
	var property artefactos = #{cuchillo, new ArmaDeFuego(balas = 4, poder = 10)}
	var direccion = abajo 
	

	method image() {
		return 	"policia-" + self.sufijo() + ".png" 
	}
	
	method sufijo() {
		return direccion.sufijo()
	}
	
	method moverA(_direccion) {
		direccion = _direccion
		self.actualizarPosicion(_direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = self.posicionActualONueva(nuevaPosicion)
	}
	
	method posicionActualONueva(nuevaPosicion) = if (self.validarPosicion(nuevaPosicion)) {position} else {nuevaPosicion}
	
	method validarPosicion(posicion) = game.getObjectsIn(posicion).any({objeto => objeto.esSolido()})
	
	method fuerza(arma) = 10 + arma.factorAtaque()
	
	method recogerArtefacto(_artefacto){
		artefactos.add(_artefacto)
	}
	
	method armaMasPoderosa() {
		return artefactos.max({cosa => cosa.factorAtaque()})
	}
	
	method disparar() {
		const tiro = new Bala(direccionBala = direccion, position = direccion.siguiente(self.position()), poder = self.fuerza(self.armaMasPoderosa()))
		self.armaMasPoderosa().usar()
		game.addVisual(tiro)
		game.onTick(300, "Ricochet", {tiro.desplazarse()})
		game.onCollideDo(tiro, {enemigo => tiro.impacto(enemigo)
								game.removeTickEvent("Ricochet")
								game.removeVisual(tiro)})
	}
	
	method cuerpoACuerpo(){
		if(self.hayEnemigo()) {
		    self.sufrir(game.uniqueCollider(self).fuerza())
			self.cortar(game.uniqueCollider(self))
		}
	}
	
	method hayEnemigo() {
		return game.colliders(self).any({algo => algo.fuerza() > 0})//Modifico cuando esten las paredes
	}
	
	method cortar(_enemigo) {
		_enemigo.sufrir(self.fuerza(cuchillo))
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
		game.schedule(1000, {game.stop()})
		//Opcionalmente ponemos una foto del cadaver
	}
	
	
//	method tirarArma() {
//		game.addVisual(self.arma())
//		artefactos.remove(self.arma())
//	}
	
	
}


class Botiquin {
	
	
}
class Municion{
	
	method recargarLasBalas(){
		
	}
}