import wollok.game.*
import personaje.*
//Artefactos (Armamento y Llaves)
object cuchillo{	
	method image() {
		
	}
	
	method factorAtaque(){
		return 3
	}
	
	method usar() {
		// No hace nada por el polimorfismo
	}
	method abrePuerta(){
		return false
	}
}

object pistola{
	var usos = 0
	//var balas = 3
	
	method image() {
		
	}
		
	method factorAtaque(){		
		return 5.min(8 - usos)	//(8 - usos) || 5
	}
	
	method usar(){
		usos += 1
		//balas -= 1
	}

	method abrePuerta(){
		return false
	}
}

object escopeta{
	var usos = 0
	
	method image() {
		
	}
	
	method factorAtaque(){
		return 10.min(20-usos*3)//(20 - usos x 3) || 10 
	}
	
	method usar(){
		usos += 1		
	}
	
	method abrePuerta(){
		return false
	}
}
//class artefacto {
//	
//}


class ArmaDeFuego {
	var property balas
	var property poder
	
	method usar (){
		balas -=1
	}
	method factorAtaque(){
		return poder.min(10+balas)
	}
	
	method abrePuerta(){
		return false
	}
}

class Tarjetas {
	var property puertaQueAbre
	
	method abrePuerta(){
		return true
	}

}

class Puerta{
	const property esSolido = true
	const property position
	const property image = "puerta.png"
	
	method abrir(){
		if(personaje.tieneTarjeta()){
			game.removeVisual(self)
			game.say(personaje, "¡Escapé!")
			game.schedule(2000,{
				game.stop()
			})			
		} else {
			game.say(personaje, "No puedo abrir la puerta")
		}
	}
}







