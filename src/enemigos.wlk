import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*

object enemigo1 {
	var property energia = 5 //Valor que probablemente cambie
	var property posicion = game.at(5, 5)
	var property arma 
	
	method image() {
		return "pepita.jpg"
	}
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.posicion()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		posicion = nuevaPosicion
	}
	
	method pelear() {
		if (self.esMasFuerteQue(personaje)) {
			arma.usar()
//			personaje.morir()			
		}
		else {
			arma.usar()
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method recogerArma(_arma) {//Podemos agregar que el enemigo considere cambiar 
		arma = _arma		   //el arma segun si el factor ataque del arma nueva es mayor
	}
	
	method tirarArma() {
		game.addVisual(arma)
	}
	
	method fuerza() {
		return 5 + arma.factorAtaque()
	}
	
	method morir() {
		energia = 0
		self.tirarArma()
		//Poner cuerpo de enemigo?
	}
}
