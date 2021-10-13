import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

object demo {

	method iniciar() {
		game.addVisual(enemigo1)
		game.addVisualCharacter(personaje)
		config.configuracionTeclas()
		
	}

}


object config {
	method configuracionTeclas() {
		keyboard.left().onPressDo( { personaje.moverA(izquierda)  })
		keyboard.right().onPressDo({ personaje.moverA(derecha) })
		keyboard.up().onPressDo({ personaje.moverA(arriba) })
		keyboard.down().onPressDo({ personaje.moverA(abajo) })
		
	//	keyboard.space().onPressDo({ personaje.pelear() })
	//	keyboard.c().onPressDo({ personaje.recogerArtefacto(game.uniqueCollider(personaje)) })
	}
	
	method configuracionColisiones() {
		//game.whenCollideDo(personaje,{personaje.pelear(game.uniqueCollider(personaje))})
	}
}