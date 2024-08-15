extends Node

const CARD_DATABASE = preload("res://Assets/Scripts/cardDataBase.gd")
const MAX_CARTAS_BARAJA = 60
const MIN_CARTAS_BARAJA = 30


#barajas para guardar (jugador1)

var baraja_jugador1 = []
var cantidad_cartas1 = []
var nombre_cartas1 = []

var baraja_jugador2 = []
var cantidad_cartas2 = []
var nombre_cartas2 = []

#baraja del jugador2

var barajaOponente = []


#seleccionar una baraja al empezar una partida

var baraja_seleccionada : int

#arrays para configurar mazos antes de guardarlos

var baraja_temp = []
var cantidad_temp = []
var nombre_temp = []

#arrays usados en partida

var baraja_jugador_partida = []
var baraja_oponente_partida = []
var cementerio_jugador = []
var cementerio_oponente = []

func _ready():
	for i in 1:
		barajaOponente.append("0")
		barajaOponente.append("1")
		barajaOponente.append("2")
		barajaOponente.append("3")
		barajaOponente.append("4")
