import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 100 
	var property position = game.at(10, 10)
	var property artefactos = #{cuchillo}
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
		position = nuevaPosicion
	}
	
	method pelear(){
		if(self.esMasFuerteQue(enemigo1)){
			self.arma().usar()
			self.ganarPelea()
		}else{
			self.arma().usar()
			self.perder()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method fuerza(){
		return 10 + self.arma().factorAtaque()
	}
	
	method perder(){
		
	}
	
	method recogerArtefacto(_artefacto){
		self.validarRecoger()
		artefactos.add(_artefacto)
	}
	
	method validarRecoger() {
		if (artefactos.any({cosa => self.esArma(cosa)})) {
			self.error("Ya tenes un arma")
		}
	}
	
	method arma() {
		return artefactos.find({cosa => self.esArma(cosa)})
	}
	
	method esArma(_cosa) {
		return _cosa.factorAtaque() > 0
	}
	
	method tirarArma() {
		game.addVisual(self.arma())
		artefactos.remove(self.arma())
	}
	
	
	method ganarPelea() {
		
	}

}