import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

object demo {

	method iniciar() {
		game.addVisual(enemigo1)
		game.addVisualCharacter(personaje)
		
	}

}


object config {
	method configurarTeclas() {
//		keyboard.left().onPressDo( { personaje.moverA(izquierda)  })
//		keyboard.right().onPressDo({ personaje.moverA(derecha) })
//		keyboard.up().onPressDo({ personaje.moverA(arriba) })
//		keyboard.down().onPressDo({ personaje.moverA(abajo) })
		
//		keyboard.space().onPressDo({ personaje.pelear() })
	}
}