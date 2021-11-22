import wollok.game.*
import nivelesDelJuego.*
 
object randomizer {
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	//Alternativa: 0.randomUpTo(game.width()).truncate(0),
	}
	
	method emptyPosition() {
		const position = self.position()
		if(self.isEmpty(position)) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	method isEmpty(position) {
		return game.getObjectsIn(position).isEmpty()
	}
	
	method energy() {
		return (15..25).anyOne()
	}
	
	method niveles() {
		const nivelesVarios = []
		return 0
	}
	
}