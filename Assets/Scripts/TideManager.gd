extends Node

const MAREA_INICIAL : int = 0

#Contador de mareas de la partida
var mareaJugador : int = MAREA_INICIAL
var mareaOponente : int = MAREA_INICIAL

var marea_seleccionada : int 	#Sirve para la función update_tide, permite hacer efectivos los efectos de las cartas relacionados con la marea

#Estados de marea
var estadoMareaJugador : String
var estadoMareaOponente : String
var color_jugador1 : Color = Color.MEDIUM_TURQUOISE
var color_jugador2 : Color = Color.MEDIUM_TURQUOISE
@onready var marea_jugador = $"../Juego/mareaJugador"
@onready var marea_oponente = $"../Juego/mareaOponente"
@onready var turn_manager = $"../TurnManager"
@onready var barra_marea_jugador_1: ProgressBar = $"../Juego/barra_marea_jugador1"
@onready var barra_marea_jugador_2: ProgressBar = $"../Juego/barra_marea_jugador2"

func iniciarMareas():
	estadoMareaJugador = comprobarMarea(mareaJugador, estadoMareaJugador)
	estadoMareaOponente = comprobarMarea(mareaOponente, estadoMareaOponente)
	barra_marea_jugador_1.modulate = color_jugador1
	barra_marea_jugador_2.modulate = color_jugador2

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
		barra_marea_jugador_1.value = mareaJugador
	else:
		if mareaOponente + amount > 20:
			mareaOponente = 20
		elif mareaOponente + amount < -20:
			mareaOponente = -20
		else:
			mareaOponente += amount
		barra_marea_jugador_2.value = mareaOponente

func change_bar_color(marea):
	if marea == 0:
		match estadoMareaJugador:
				"muerta":
					color_jugador1 = Color.DARK_RED
				"baja":
					color_jugador1 = Color.DARK_ORANGE
				"inicial":
					color_jugador1 = Color.MEDIUM_TURQUOISE
				"alta":
					color_jugador1 = Color.TURQUOISE
				"viva":
					color_jugador1 = Color.LIGHT_CYAN
		barra_marea_jugador_1.modulate = color_jugador1
	if marea == 1:
		match estadoMareaOponente:
				"muerta":
					color_jugador2 = Color.DARK_RED
				"baja":
					color_jugador2 = Color.DARK_ORANGE
				"inicial":
					color_jugador2 = Color.MEDIUM_TURQUOISE
				"alta":
					color_jugador2 = Color.TURQUOISE
				"viva":
					color_jugador2 = Color.LIGHT_CYAN
		barra_marea_jugador_2.modulate = color_jugador2

#func _process(delta):
	#marea_jugador.text = "Jug - Cantidad: " + str(mareaJugador) + ". Estado: " + str(estadoMareaJugador) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaJugador)
	#marea_oponente.text = "Opo - Cantidad: " + str(mareaOponente) + ". Estado: " + str(estadoMareaOponente) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaOponente)
