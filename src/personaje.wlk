import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*

object personaje {
	var property energia = 100 
	var property position = game.origin()
	var property artefactos = #{cuchillo, pistola}
	var direccion = abajo 
	

	method image() {
		return "pepita.png"
		//return 	"policia-" + self.sufijo() + ".png" 
	}
	
	method sufijo() {
		return direccion.sufijo()
	}
	
	method moverA(_direccion) {
		//Validar movimiento con all o any
		direccion = _direccion
		self.actualizarPosicion(_direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method pelear(){
		if(self.esMasFuerteQue(enemigo1)){
			self.armaMasPoderosa().usar()
			self.ganarPelea()
		}else{
			self.armaMasPoderosa().usar()
			self.perder()
		}
	}
	
	method esMasFuerteQue(alguien) {
		return self.fuerza() > alguien.fuerza()
	}
	
	method fuerza(){
		return 10 + self.armaMasPoderosa().factorAtaque()
	}
	
	
	method recogerArtefacto(_artefacto){
		artefactos.add(_artefacto)
	}
	
	
	method armaMasPoderosa() {
		return artefactos.max({cosa => cosa.factorAtaque()})
	}
	
//	method tirarArma() {
//		game.addVisual(self.arma())
//		artefactos.remove(self.arma())
//	}
	
	
	method ganarPelea() {
		
	}
	
	method perder(){
		
	}
}