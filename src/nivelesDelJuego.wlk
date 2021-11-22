import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

object demo {

	method iniciar() {
		
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()
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
	
	method reproducirSonido(){
		if(!sonidos.audio().played()){
		game.schedule(1000, {
			sonidos.loopOn()
			sonidos.audio().play()
		})
		
		
		}
	}
}

object escena {
	const ancho = game.width()
	const alto = game.height()	
	const property paredesX = (0..ancho-1)
	const property paredesY = (0..alto-1)
	var property paredes = []
	var indice = 0
	
	method mapPositionsInX(){
		paredesX.forEach{
			x => paredes.add(x)
		}
	}
	method mapPositionsInY(){
		paredesY.forEach{
			y => paredes.add(y)
		}
	}
	method positionsAsList(){
		paredes.forEach{ x =>			
			self.armarPosiciones(x,indice)	
			indice++		
		}
	}
	
	method armarPosiciones(coord,i){
		if(i<ancho){
			paredes.add(game.at(coord,0))
		} else {
			paredes.add(game.at(0,coord))
		}
	}

	method agregarParedes(){			
		paredes.forEach {pos => 
			paredFactory.nuevaPared(paredes)
		}		
	}	
}

object sonidos{
	const property audio = new Sound(file = "background-music.mp3")
	
	method loopOn() {audio.shouldLoop(true)}
}
object paredFactory{
	method nuevaPared(position) {
		game.addVisual(new Pared(position = position))
	}
}

class Pared {
	var property position
	
	method image(){
		return('pared.png')
	}
}