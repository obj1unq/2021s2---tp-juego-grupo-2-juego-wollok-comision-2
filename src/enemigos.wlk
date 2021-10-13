import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*

object enemigo1 {
	var property energia = 5 //Valor que probablemente cambie
	var property position = game.at(5, 5)
	//var property arma
	
	method image() {
		return "pepita.png"
	}
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method pelear() {
		if (self.esMasFuerteQue(personaje)) {
//			arma.usar()
			personaje.perder()			
		}
		else {
//			arma.usar()
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	//method tirarArtefacto() {
	//	game.addVisual(arma)
	//	 
	//}
	
	method fuerza() {
		return 5 //+ arma.factorAtaque()
	}
	
	method morir() {
		energia = 0
		//self.tirarArma()
		//Poner cuerpo de enemigo?
	}
}
