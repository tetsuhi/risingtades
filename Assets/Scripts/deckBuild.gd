extends Node

const CARD_DATABASE = preload("res://Assets/Scripts/cardDataBase.gd")
const MAX_CARTAS_BARAJA = 60
const MIN_CARTAS_BARAJA = 30


var baraja_jugador1 = []
var cantidad_cartas1 = []
var nombre_cartas1 = []

var baraja_jugador2 = []
var cantidad_cartas2 = []
var nombre_cartas2 = []

var baraja_seleccionada : int

var baraja_jugador_partida = []

var baraja_temp = []
var cantidad_temp = []
var nombre_temp = []

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
