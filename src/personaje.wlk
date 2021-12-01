import wollok.game.*
import direcciones.*
import artefactos.*
import enemigos.*
import nivelesDelJuego.*
import config.*


object personaje {
	var property energia = 200 
	var property position = game.at(1, 1)
	var property armas = #{cuchillo}
	var direccion = abajo 
	const property esSolido = false
	var property tieneTarjeta = false

	method image() = "policia-" + self.sufijo() + ".png"
	
	method sufijo() = direccion.sufijo()
	
	method moverA(_direccion) {
		direccion = _direccion
		self.actualizarPosicion(_direccion.siguiente(self.position()))
	}
	
	method actualizarPosicion(nuevaPosicion) {
		position = self.posicionActualONueva(nuevaPosicion)
	}
	
	method posicionActualONueva(nuevaPosicion) = if (self.validarPosicion(nuevaPosicion)) {position} else {nuevaPosicion}
	
	method validarPosicion(posicion) = game.getObjectsIn(posicion).any({objeto => objeto.esSolido()})
	
	method fuerza(arma) = 10 + arma.factorAtaque()
	
	method armaMasPoderosa() {
		return armas.max({cosa => cosa.factorAtaque()})
	}
	
	method armaEstaCargada(arma) = arma.balas() > 0
	
	method dispararSiTieneBalas() {
		if (self.armaEstaCargada(self.armaMasPoderosa())) {
			self.disparar()
		}
	}
	
	method disparar() {
		const tiro = new Bala(direccionBala = direccion, position = direccion.siguiente(self.position()), poder = self.fuerza(self.armaMasPoderosa()))
		self.armaMasPoderosa().usar()
		config.configDisparo(tiro)
	}
	
	method cuerpoACuerpo(){
		if(self.hayEnemigo()) {
		    self.sufrir(game.uniqueCollider(self).fuerza())
			self.cortar(game.uniqueCollider(self))
		}
	}
	
	method hayEnemigo() = game.colliders(self).any({algo => algo.fuerza() > 0})
	
	method cortar(_enemigo) {
		_enemigo.sufrir(self.fuerza(cuchillo))
	}
	
	method sufrir(danoRecibido){
		energia -= danoRecibido
		self.validarEnergia()
	}
	
	method validarEnergia() {
		if(self.noEstoyVivo()) {
			self.perder()
		}
	}
	
	method noEstoyVivo() = energia <= 0
	
	method perder(){
		game.say(self,"¡ME ATRAPARON!")
		game.schedule(1000, {game.stop()})
		//Clear y cambiar fondo
	}
	
	method curarse(gasa) {
		energia += gasa
	}
	
	method tengoLaTarjeta() {
		tieneTarjeta = true
	}
	
	method recargar(balas) {
		self.armaMasPoderosa().cargar(balas)
	}

	method abrirPuerta(){
		if(self.hayPuerta() && self.tieneTarjeta()){
			config.ganarJuego(direccion.siguiente(self.position()))			
		} else if(self.hayPuerta()){
			game.say(self, "No puedo escapar! :(")
		}
	}
	
	method hayPuerta(){
		return game.getObjectsIn(direccion.siguiente(position)).any({obj=>obj.seAbre()})
	}
	
	method tirarArma() {
		self.validarTirar()
	}
	
	method recogerArma(_arma){
		self.validarRecoger(_arma)
		
	}
	
	method validarRecoger(arma) {
		if (!self.estoyArmado()) {
			armas.add(arma)
		}
	}
	
	method validarTirar() {
		if(self.estoyArmado()) {
			game.addVisual(self.armaMasPoderosa())
			armas.remove(self.armaMasPoderosa())	
		}
	}
	
	method estoyArmado() = armas.size() > 1
}