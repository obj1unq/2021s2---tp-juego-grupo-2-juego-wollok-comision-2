import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 100 
	var property position = game.at(10, 10)
	var property artefactos = #{}
	

	method image() = "personaje prueba 2.png"
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method pelear(){
		if(self.esMasFuerteQue(enemigo1)){
			self.arma().usar()
			self.ganar()
		}else{
			self.arma().usar()
			self.perder()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method fuerza(){
		return 10//+ arma.factorAtaque()
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
		return artefactos.filter({cosa => self.esArma(cosa)})
	}
	
	method esArma(_cosa) {
		return _cosa.factorAtaque() > 0
	}
	
	method tirarArma() {
		game.addVisual(self.arma())
		artefactos.remove(self.arma())
	}
	
	
	method ganar() {
		
	}

}