import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*
import randomizer.*
import nivelesDelJuego.*

object config {
	method eliminarObjetos(posicion){game.removeVisual(game.getObjectsIn(posicion))}
	
	method configuracionTeclas() {
		keyboard.a().onPressDo( { personaje.moverA(izquierda)  })
		keyboard.d().onPressDo({ personaje.moverA(derecha) })
		keyboard.w().onPressDo({ personaje.moverA(arriba) })
		keyboard.s().onPressDo({ personaje.moverA(abajo) })
		
		keyboard.k().onPressDo({ personaje.cuerpoACuerpo() })
		keyboard.space().onPressDo({ personaje.dispararSiTieneBalas() })
		keyboard.e().onPressDo({personaje.abrirPuerta()})
	//	keyboard.c().onPressDo({ personaje.recogerArtefacto(game.uniqueCollider(personaje)) })
	}
	method configuracionTeclasInicio() {		
		keyboard.enter().onPressDo({juego.iniciarNivel()})	
	}
	
	method configuracionColisiones() {
		game.onCollideDo(personaje,{game.uniqueCollider(personaje).actuar()})
		//schedule con menos daño otra opcion
	}
	
	method configuracionEnemigos() {
		game.onTick(4000, "ENEMIGOS", {enemigoFactory.nuevoEnemigo()})
	}
	
	method reproducirSonido(){
		if(!musica.audio().played()){
		game.schedule(1000, {
			musica.loopOn()
			musica.audio().volume(0.5)
			musica.audio().play()
		})
		
		
		}
	}
	
	method configDisparo(tiro) {
		game.addVisual(tiro)
		game.onTick(500, "Ricochet", {tiro.desplazarse()})
		game.onCollideDo(tiro, {enemigo => tiro.impacto(enemigo)
								game.removeTickEvent("Ricochet")
								game.removeVisual(tiro)})
		
	}
	
	method iniciarJuego(){
		game.addVisualIn(inicio, game.center())
	}
	
	method ganarJuego(position){
		self.eliminarObjetos(position)
		musica.setVolume(0)
		game.clear()
		game.addVisualIn(victoria, game.center())
		game.schedule(3000, {game.stop()})
	}
}