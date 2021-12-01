import wollok.game.*
import personaje.*
import direcciones.*
import artefactos.*
import enemigos.*
import randomizer.*
import config.*

object juego{
	const botiquines = [new Botiquin(cantidadDeGasa = 10,position = game.at(20,13)), new Botiquin(cantidadDeGasa = 20, position = game.at(9,1))]
	const habitacionInicial = new HabitacionConAbertura(xInicial=0,xFinal= 8, yInicial = 0, yFinal=7, aberturas = [game.at(3,7),game.at(8,2)])
	const habitacionInferiorCentral = new HabitacionConAbertura(xInicial=8, xFinal=16, yInicial= 0, yFinal=4, aberturas = [game.at(8,2), game.at(10,4)])
	const habitacionSuperiorIzquierda = new HabitacionConAbertura(xInicial=0, xFinal=6, yInicial= 7, yFinal=14, aberturas = [game.at(3,7), game.at(6,11)])
	const habitacionCentral = new HabitacionConAbertura(xInicial=8, xFinal=16, yInicial= 4, yFinal=14, aberturas = [game.at(10,4), game.at(8,10), game.at(16,8)])
	const habitacionFinal = new HabitacionConAbertura(xInicial=16, xFinal=26, yInicial= 0, yFinal=4, aberturas = [game.at(17,4)])
	const municiones = [new Municion(cantidadDeBalas = 2,position = game.at(18,9))]
	const jefecito = new JefeEnemigo(direccion = izquierda, energia = 30, position = game.at(5,5))

	var property escenaNivel = new Nivel(
		elementos = [
			render.limites(),
			habitacionInicial.toRender(),
			habitacionInferiorCentral.toRender(),
			habitacionCentral.toRender(),
			habitacionSuperiorIzquierda.toRender(),
			habitacionFinal.toRender(),
			[new Puerta(position = game.at(26,2))],
			botiquines, municiones
		])
	method iniciar(){
		game.addVisual(inicio)
		config.configuracionTeclasInicio()	
	}
	method iniciarNivel() {
		game.clear()
		
		personaje.position(game.at(1,1))
		game.addVisual(personaje)
		//objeto que configure los limites
		config.configuracionTeclas()
		config.configuracionEnemigos()
		config.reproducirSonido()
		escenaNivel.dibujarNivel()
		game.showAttributes(personaje)
		game.addVisual(jefecito)
		jefecito.atacar()
	}
}


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


object inicio{
	const property position = game.at(10,5)
	const property image = 'inicio.png'
}

object victoria{
	const property position = game.at(12,8)
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
