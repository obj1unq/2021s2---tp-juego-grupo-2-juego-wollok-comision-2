import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 100 
	var property position = game.at(10, 10)
	var property artefactos = #{}
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
	
	method pelear(){
		if(self.esMasFuerteQue(enemigo1)){
//self.arma().usar()
			self.ganarPelea()
		}else{
//self.arma().usar()
			self.perder()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method fuerza(){
		return 10 //+ self.arma().factorAtaque()
	}
	
	
	method recogerArtefacto(_artefacto){
//		self.validarRecogerArma()
		artefactos.add(_artefacto)
	}
	
//	method validarRecogerArma() {
//		if (artefactos.any({cosa => self.esArma(cosa)})) {
//			self.error("Ya tenes un arma")
//		}
//	}
	
	method armaPoderosa() {
//		return artefactos.max({cosa => self.esArma(cosa)})
	}
	
//	method tirarArma() {
//		game.addVisual(self.arma())
//		artefactos.remove(self.arma())
//	}
	
	
	method ganarPelea() {
		
	}
	
	method perder(){
		
	}
}