import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*
import randomizer.*

class Pared{
	var property position
	var property image
	const property esSolido = true
	
	method esLimite(){
		return self.position().x()==0
				|| self.position().y()==0
				|| self.position().x() == escena.ancho()-1
				|| self.position().y() == escena.alto()-1
	}
	
	method esSolido(){
		return true
	}
	
	method sufrir(nada){
		//No hace nada por el polimorfismo
	}
}

object habitacion{
	var property posiciones = []
	
	method limites(){
		return 
		[
			escena.filaPosiciones(0, escena.ancho() , 0),
			escena.filaPosiciones(0, escena.ancho() , escena.alto()-1),
			escena.columnaPosiciones(0, escena.alto() , 0),
			escena.columnaPosiciones(0, escena.alto() , escena.ancho()-1)
		]
	}
	
	method generarHabitacion(xInicial, xFinal, yInicial, yFinal){
		return posiciones +
			[
				escena.filaPosiciones(xInicial, xFinal, yInicial),
				escena.filaPosiciones(xInicial, xFinal, yFinal),
				escena.columnaPosiciones(yInicial, yFinal, xInicial),
				escena.columnaPosiciones(yInicial, yFinal, xFinal)
			]
	}
	
	method dibujarParedes(positions){
		positions.flatten().forEach {pos =>
			paredFactory.nuevaPared(pos)
		}	
	}
}

object demo{
	var property escenaNivel = new Nivel(paredPosiciones = 
		habitacion.limites() +
		habitacion.generarHabitacion(0,5,0,5) +
		habitacion.generarHabitacion(6,10,5,9)		
	)

	method iniciar() {
		personaje.position(game.at(1,1))
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()	
		habitacion.dibujarParedes(escenaNivel.paredPosiciones())
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
		keyboard.space().onPressDo({ personaje.disparar() })
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
	const pared = 'pared.png'
	
	method hayPared(posicion){
			return game.getObjectsIn(posicion).any({obj => obj.esSolido()})
	}
		
	method nuevaPared(position) {	
				if(self.hayPared(position)){}else {
					game.addVisual(new Pared(position = position,image = pared ))
				}
	}
}

class Nivel{	
	const property paredPosiciones = []
	
	method randomWallPosition(positions){
		return positions.flatten().get(randomizer.index())		
	}
	
	method dibujarPuertaFinal(positions){		
		game.addVisual(
			new Puerta(position = self.randomWallPosition(paredPosiciones))
		)
	}
		
	method dibujarNivel(){
		habitacion.dibujarParedes(paredPosiciones)
	}
}

