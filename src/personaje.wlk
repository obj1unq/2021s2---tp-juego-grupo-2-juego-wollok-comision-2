import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 5 //Valor que probablemente cambie
	var property posicion = game.at(5, 5)
	var property artefactos = #{}
	

	method image() = "A definir"
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.posicion()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		posicion = nuevaPosicion
	}
	
	method pelear(){
		if(self.esMasFuerteQue(enemigo1)){
			enemigo1.morir()
		}else{
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
		artefactos.add(_artefacto)
	}
	
	method arma() {
		
	}
	

}