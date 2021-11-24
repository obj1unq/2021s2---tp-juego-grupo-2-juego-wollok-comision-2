import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*

class Pared{
	var property position
	var property image
	
	method esPasable(){
		return false
	}
}

object demo {
	var property escenaNivel = new Nivel()

	method iniciar() {
		
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()		
		escenaNivel.dibujarParedes(escenaNivel.generarHabitacion(3,6,6,10))
		game.showAttributes(personaje)
	}
}

object config {
	method configuracionTeclas() {
		keyboard.left().onPressDo( { personaje.moverA(izquierda)  })
		keyboard.right().onPressDo({ personaje.moverA(derecha) })
		keyboard.up().onPressDo({ personaje.moverA(arriba) })
		keyboard.down().onPressDo({ personaje.moverA(abajo) })
		
		keyboard.k().onPressDo({ personaje.cuerpoACuerpo() })
	//	keyboard.space().onPressDo({ personaje.pegarYSufrir() })
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
		if(!musica.audio().played()){
		game.schedule(1000, {
			musica.loopOn()
			musica.audio().volume(0.5)
			musica.audio().play()
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

object musica{
	const property audio = new Sound(file = "background-music.mp3")	
	method setVolume(vol){audio.volume(vol)}
	method loopOn() {audio.shouldLoop(true)}
}
object paredFactory{
	
	method hayPared(posicion){
			return game.getObjectsIn(posicion).size()>0			
	}
	
	method nuevasParedes(positionsList, image){
		positionsList.forEach{
			pos => 
			self.nuevaPared(pos, image)
		}
	}
	
	method nuevaPared(positions, image) {
		positions.forEach{	
			position =>		
				if(self.hayPared(position)){}else {
					game.addVisual(new Pared(position = position,image = image ))
				}
		}
	}
}

class Nivel{
	const pared = 'pared.png'
	//var property coordenadas = []
	
	method paredes(habitaciones){
		return self.limitesDelNivel() + habitaciones
	}
	method generarHabitacion(xInicial, xFinal, yInicial, yFinal){
		return 
			[
				escena.filaPosiciones(xInicial, xFinal, yInicial),
				escena.filaPosiciones(xInicial, xFinal, yFinal),
				escena.columnaPosiciones(yInicial, yFinal, xInicial),
				escena.columnaPosiciones(yInicial, yFinal, xFinal)
			]
	}
	
	method limitesDelNivel(){
		return 
		[
			escena.filaPosiciones(0, escena.ancho() , 0),
			escena.filaPosiciones(0, escena.ancho() , escena.alto()-1),
			escena.columnaPosiciones(0, escena.alto() , 0),
			escena.columnaPosiciones(0, escena.alto() , escena.ancho()-1)
		]
	}
	
	method nuevaFila(positions){
		paredFactory.nuevasParedes(positions, pared)
	}
	method nuevaColumna(positions){
		paredFactory.nuevasParedes(positions, pared)
	}
	method dibujarParedes(habitaciones){			
		self.paredes(habitaciones).forEach {pos =>
			if(escena.esFila(pos)){
				self.nuevaFila(self.paredes(habitaciones))
			}else{
				self.nuevaColumna(self.paredes(habitaciones))
			}
		}
	}
}

