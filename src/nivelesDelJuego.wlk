import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*
import randomizer.*

class Habitacion{
	var property xInicial
	var property xFinal
	var property yInicial
	var property yFinal	
	
	method posiciones(){
		return 
		[
				disenio.filaPosiciones(xInicial, xFinal, yInicial),
				disenio.filaPosiciones(xInicial, xFinal, yFinal),
				disenio.columnaPosiciones(yInicial, yFinal, xInicial),
				disenio.columnaPosiciones(yInicial, yFinal, xFinal)
			]
	}
	
	method posicionesPlanas(){
		return self.posiciones().flatten()
	}
	
	method toRender(){
		return
			self.posicionesPlanas().map({pos => new Pared(position = pos)})
	}
}

class HabitacionConAbertura inherits Habitacion{
	var property aberturas = []	
	override method toRender(){
		return self.newPos().map({pos => new Pared(position = pos)})
	}	
	method newPos(){
		return self.posicionesPlanas().filter({ posicion => !aberturas.contains(posicion)})
	}
}
//render


object juego{
	//const habitacionConBotiquin = new HabitacionConAbertura(xInicial=0,xFinal= 0, yInicial = 0, yFinal=0, aberturas = [])
	var property escenaNivel = new Nivel(
		elementos = [
			render.limites(),
			new HabitacionConAbertura(xInicial=8, xFinal=16, yInicial= 0, yFinal=4, aberturas = [game.at(8,2), game.at(10,4)]).toRender(),
			[new Puerta(position = game.at(15,2))]
		])

	method iniciar() {
		personaje.position(game.at(1,1))
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()
		escenaNivel.dibujarNivel()
		game.showAttributes(personaje)
	}
}

object config {
	method iniciarJuego(){
		game.addVisualIn(inicio, game.center())
	}
	
	method eliminarObjetos(posicion){
		game.getObjectsIn(posicion).forEach{
			obj => game.removeVisual(obj)
		}
	}
	method configuracionTeclas() {
		keyboard.left().onPressDo( { personaje.moverA(izquierda)  })
		keyboard.right().onPressDo({ personaje.moverA(derecha) })
		keyboard.up().onPressDo({ personaje.moverA(arriba) })
		keyboard.down().onPressDo({ personaje.moverA(abajo) })
		
		keyboard.k().onPressDo({ personaje.cuerpoACuerpo() })
		keyboard.space().onPressDo({ personaje.dispararSiTieneBalas() })
		keyboard.a().onPressDo({personaje.abrirPuerta()})
	//	keyboard.c().onPressDo({ personaje.recogerArtefacto(game.uniqueCollider(personaje)) })
	}
	
	method ganarJuego(position){
		self.eliminarObjetos(position)
		musica.setVolume(0)
		game.clear()
		game.addVisualIn(victoria, game.center())
		game.schedule(3000, {game.stop()})
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
}

object inicio{
	const property position = game.center()
	const property image = 'inicio.png'
}

object victoria{
	const property position = game.center()
	const property image = 'win.png'
}

object disenio {
	const property paredesX = (0..game.width()-1)
	const property paredesY = (0..game.height()-1)
	
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

object render{
		
	method limites(){
		return new Habitacion(xInicial = 0, xFinal = game.width()-1,yInicial = 0,yFinal = game.height()-1).toRender()
	}
	
	method renderizar(instance){
		instanceFactory.nuevaInstancia(instance)		
	}
}

object musica{
	const property audio = new Sound(file = "background-music.mp3")	
	method setVolume(vol){audio.volume(vol)}
	method loopOn() {audio.shouldLoop(true)}
}

object instanceFactory{
	
	method hayAlgoSolido(posicion){
			return game.getObjectsIn(posicion).any({obj => obj.esSolido()})
	}
		
	method nuevaInstancia(instance) {	
				if(!self.hayAlgoSolido(instance.position())){
					game.addVisual(instance)
				} else if(instance.seAbre()){
					game.getObjectsIn(instance.position()).forEach{obj => game.removeVisual(obj)}
					game.addVisual(instance)
				}
	}
}

class Nivel{
	var property elementos = []

	method wallInPosition(pos){
		return game.getObjectsIn(pos)
	}

	method puertaFinal(pos){
		return new Puerta(position = pos)
	}
		
	method dibujarNivel(){
		elementos.flatten().forEach{
			elem => render.renderizar(elem)
		}
	}
}
