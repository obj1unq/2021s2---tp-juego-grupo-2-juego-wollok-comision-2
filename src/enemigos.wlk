import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*

class Enemigo{
	var property energia
	var property position
	var property arma
		
	method image() {
		return "pepita.png"
	}
	
	//Agregar comportamiento IA
	method moverA(direccion) {
		//if(self.sePuedeMoverA(direccion)){
		self.actualizarPosicion(direccion.siguiente(self.position()))
		//}
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method pelear() {
			
		if (self.esMasFuerteQue(personaje)){
			self.ganarPelea()		
		}
		else {
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
		
	method fuerza() {
		return arma.factorAtaque()
	}
	
	method ganarPelea(){
		personaje.perder()
	}
	
	method morir() {
		energia = 0
	}
}

object jefeEnemigo {
	var property energia = 5 //Valor que probablemente cambie
	var property position = game.at(8, 5)
	var property artefacto = tarjetaEdificio
	
	method image() {
		return "policia-down.png"
	}
	
	method moverA(direccion) {
		self.actualizarPosicion(direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method pelear() {
		self.ganarPelea()		
		if (self.esMasFuerteQue(personaje)) {
			personaje.perder()			
		}
		else {
			self.morir()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method tirarArtefacto() {
		game.addVisual(artefacto) 
	}
	
	method fuerza() {
		return escopeta.factorAtaque()
	}
	
	method morir() {
		energia = 0
		self.tirarArtefacto()
		//Poner cuerpo de enemigo?
	}
	method ganarPelea(){
		
	}
}
