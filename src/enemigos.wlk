import personaje.*
import direcciones.*

object enemigo1 {
	var property energia = 5 //Valor que probablemente cambie
	var property posicion
	var property arma 
	
	method image() {
		
	}
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.posicion()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		posicion = nuevaPosicion
	}
	
	method pelear() {
		if (self.esMasFuerteQue(personaje)) {
//			personaje.morir()
		}
		else {
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method recogerArma(_arma) {//Podemos agregar que el enemigo considere cambiar 
		arma = _arma		   //el arma segun si el factor ataque del arma nueva es mayor
	}
	
//	method tirarArma() {
//	}
	
	method fuerza() {
		return 5 + arma.factorAtaque()
	}
	
	method morir() {
		energia = 0
//		self.tirarArma() Metodo a definir cuando tengamos al menos un arma modelada
	}
}
