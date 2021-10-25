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
		return 5.max(8 - usos)	//(8 - usos) || 5
		//Correjir calcula mal
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
		return 10.max(20-usos*3)//(20 - usos x 3) || 10
		//Aca tambien
	}
	
	method usar(){
		usos += 1		
	}
	
	method abrePuerta(){
		return false
	}
}
//Clase
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