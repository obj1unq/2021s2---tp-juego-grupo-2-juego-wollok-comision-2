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
//		puertaQueAbre.Abrir()
	}

}






