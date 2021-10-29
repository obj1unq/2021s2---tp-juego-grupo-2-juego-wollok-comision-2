import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

object demo {

	method iniciar() { 

		//game.addVisual(jefeEnemigo)
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		escena.agregarParedes()
		game.showAttributes(personaje)
	}

}


object config {
	method configuracionTeclas() {
		keyboard.left().onPressDo( { personaje.moverA(izquierda)  })
		keyboard.right().onPressDo({ personaje.moverA(derecha) })
		keyboard.up().onPressDo({ personaje.moverA(arriba) })
		keyboard.down().onPressDo({ personaje.moverA(abajo) })
		
		keyboard.space().onPressDo({ personaje.pegarYSufrir() })
	//	keyboard.c().onPressDo({ personaje.recogerArtefacto(game.uniqueCollider(personaje)) })
	}
	
	method configuracionColisiones() {
		//game.onCollideDo(personaje,{personaje.pelear(game.uniqueCollider(personaje))})
		//schedule con menos daño otra opcion
	}
	
	method configuracionEnemigos() {
		game.onTick(4000, "ENEMIGOS", {enemigoFactory.nuevoEnemigo()})
	}
}

object escena {
	const ancho = game.width()	
	var property filaParedes = []
	var xs
	
	method positionList(){
		return (0..ancho-1).map({x=>x})
	}
	method agregarParedes(){
		xs = self.positionList()		
		xs.forEach {x => 
			paredFactory.nuevaPared(x,0)
		}		
	}
	
}
object paredFactory{
	method nuevaPared(x,y) {
		game.addVisual(new Pared(position = game.at(x,y)))
	}
}

class Pared {
	var property position
	
	method image(){
		return('pared.png')
	}
}