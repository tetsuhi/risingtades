extends Node

const CARD_DATABASE = preload("res://Assets/Scripts/cardDataBase.gd")
const MAX_CARTAS_BARAJA = 60
const MIN_CARTAS_BARAJA = 30


var barajaJugador = []
var cantidad_cartas = []
var nombre_cartas = []
#var id_jugador = []
#var barajaOponente = []

#func build_deck():
	#barajaJugador = []
	#for i in tipo_jugador.size():
		#for j in cantidad_jugador[i]:
			#var carta_id = CARD_DATABASE.DATA[id_jugador[i]]
			#var carta_info = load(carta_id)
			#var nueva_carta = carta_info.duplicate()
			#barajaJugador.append(nueva_carta)
	#print("he hecho lo que no va")
