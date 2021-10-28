import personaje.*
import direcciones.*
import artefactos.*
import wollok.game.*
import randomizer.*


class Enemigo{
	var property energia
	var property position
	var property arma
		
method image() {
		return "policia-down.png"
	}
	
	//Agregar comportamiento IA
	method moverA(direccion) {
		//if(self.sePuedeMoverA(direccion)){Para no pararse sobre una pared o puerta
		self.actualizarPosicion(direccion.siguiente(self.position()))
		//}
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method sufrir(fuerzaPersonaje) {
		energia -= fuerzaPersonaje
		self.validarEnergia()
	}
		
	method fuerza() {
		return arma.factorAtaque()
	}
	
	method morir() {
		game.removeVisual(self)
//		game.AddVisual() Posible cadaver
	}
	method validarEnergia() {
		if (energia <= 0) {
			self.morir()
		} 
	}
}

object enemigoFactory {
	
	method nuevoEnemigo() {
		game.addVisual(new Enemigo(arma = cuchillo, energia = randomizer.energy(), position = randomizer.emptyPosition()))
	}
}

object jefeEnemigo {
	var property energia = 5 //Valor que probablemente cambie
	var property position = game.at(8, 5)
	var property artefacto = new Tarjetas(puertaQueAbre = "edificio")
	
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
