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