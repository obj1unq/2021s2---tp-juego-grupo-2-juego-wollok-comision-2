import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

object demo {
	var property escenaNivel = nivel1

	method iniciar() {
		
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()		
		escenaNivel.dibujarParedes()
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
	const property ancho = game.width()
	const property alto = game.height()
	const property paredesX = (0..ancho-1)
	const property paredesY = (0..alto-1)
	
	//Armar lista de posiciones a mano
	method filaPosiciones(xInicial, xFinal, y){
		return (xInicial .. xFinal).map({ x => game.at(x,y) })
	}
	method columnaPosiciones(yInicial, yFinal, x){
		return (yInicial .. yFinal).map({ y => game.at(x,y) })
	}	
	method esFila(pos){
		const y = pos.get(0).y()
		return pos.all({
			p => p.y() == y
		})
	}
}

object sonidos{
	const property audio = new Sound(file = "background-music.mp3")
	
	method loopOn() {audio.shouldLoop(true)}
}
object paredFactory{
	
	method nuevasParedes(positionsList, image){
		positionsList.forEach{
			pos => 
			self.nuevaPared(pos, image)
		}
	}
	
	method nuevaPared(positions, image) {
		positions.forEach{	
			position =>		
			game.addVisual(new Pared(position = position,image = image ))
		}
	}
}
object nivel1{
	const pared = 'pared.png'

	const property paredes = [
		escena.filaPosiciones(0, escena.ancho() , 0),
		escena.filaPosiciones(0, escena.ancho() , escena.alto()-1),
		escena.columnaPosiciones(0, escena.alto() , 0),
		escena.columnaPosiciones(0, escena.alto() , escena.ancho()-1)
	]
	
	method nuevaFila(positions){
		paredFactory.nuevasParedes(positions, pared)
	}
	method nuevaColumna(positions){
		paredFactory.nuevasParedes(positions, pared)
	}
	method dibujarParedes(){			
		paredes.forEach {pos =>
			if(escena.esFila(pos)){
				self.nuevaFila(paredes)
			}else{
				self.nuevaColumna(paredes)
			}
		}
	}
}

class Pared{
	var property position
	var property image
}
}
//object columna{ const property image = 'columna.png'}
//object pared{ const property image = 'pared.png'}