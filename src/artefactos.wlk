//import extras.*
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

object tarjetaSeguridad{
	
	method image() {
		
	}
	
	method factorAtaque(){
		return 0
	}
	
	method abrePuerta(){
		return true
		//return seguridad.esPuerta()
	}
}

object tarjetaEdificio{
	
	method image() {
		
	}
	
	method factorAtaque(){
		return 0
	}
	
	method abrePuerta(){
		return true
		//return edificio.esPuerta()
	}
}
class Tarjetas {
	var property puertaQueAbre
	
	method abrePuerta(){
		puertaQueAbre.Abrir()
	}
	method abrir(){
		
	}
}

class ArmaDeFuego {
	var property balas
	
	method usar (){
		balas -=1
	}
	method factorAtaque(){
		return 5
	}
}






