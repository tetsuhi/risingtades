extends Node

const MAREA_INICIAL : int = 0

#Contador de mareas de la partida
var mareaJugador : int = MAREA_INICIAL
var mareaOponente : int = MAREA_INICIAL

var marea_seleccionada : int 	#Sirve para la función update_tide, permite hacer efectivos los efectos de las cartas relacionados con la marea

#Estados de marea
var estadoMareaJugador : String
var estadoMareaOponente : String
@onready var marea_jugador = $"../Juego/mareaJugador"
@onready var marea_oponente = $"../Juego/mareaOponente"
@onready var turn_manager = $"../TurnManager"

func iniciarMareas():
	estadoMareaJugador = comprobarMarea(mareaJugador, estadoMareaJugador)
	estadoMareaOponente = comprobarMarea(mareaOponente, estadoMareaOponente)

func comprobarMarea(marea, estado):
	if marea >= -20 and marea < -16:
		estado = "muerta"
	elif marea >= -16 and marea < -8:
		estado = "baja"
	elif marea >= -8 and marea <= 8:
		estado = "inicial"
	elif marea > 8 and marea <= 16:
		estado = "alta"
	elif marea > 16 and marea <= 20:
		estado = "viva"
	
	if marea > 20:
		marea = 20
		estado = "viva"
	if marea < -20:
		marea = -20
		estado = "muerta"
	
		return estado
	return estado

func update_tide(amount):
	if marea_seleccionada == 0:
		if mareaJugador + amount > 20:
			mareaJugador = 20
		elif mareaJugador + amount < -20:
			mareaJugador = -20
		else:
			mareaJugador += amount
	else:
		if mareaOponente + amount > 20:
			mareaOponente = 20
		elif mareaOponente + amount < -20:
			mareaOponente = -20
		else:
			mareaOponente += amount

func _process(delta):
	marea_jugador.text = "Jug - Cantidad: " + str(mareaJugador) + ". Estado: " + str(estadoMareaJugador) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaJugador)
	marea_oponente.text = "Opo - Cantidad: " + str(mareaOponente) + ". Estado: " + str(estadoMareaOponente) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaOponente)
