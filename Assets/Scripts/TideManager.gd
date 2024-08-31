extends Node

const MAREA_INICIAL : int = 0

#Contador de mareas de la partida
var mareaJugador : int = MAREA_INICIAL
var mareaOponente : int = MAREA_INICIAL

var marea_seleccionada : int 	#Sirve para la función update_tide, permite hacer efectivos los efectos de las cartas relacionados con la marea

#Estados de marea
var estadoMareaJugador : String
#var estado_marea_jugador1_anterior : String = estadoMareaJugador
var estadoMareaOponente : String
#var estado_marea_jugador2_anterior : String = estadoMareaOponente
var color_jugador1 : Color = Color.MEDIUM_TURQUOISE
var color_jugador2 : Color = Color.MEDIUM_TURQUOISE
@onready var marea_jugador = $"../Juego/mareaJugador"
@onready var marea_oponente = $"../Juego/mareaOponente"
@onready var turn_manager = $"../TurnManager"
@onready var barra_marea_jugador_1: ProgressBar = $"../Juego/barra_marea_jugador1"
@onready var barra_marea_jugador_2: ProgressBar = $"../Juego/barra_marea_jugador2"
@onready var turno_marea_viva_jugador_1: Label = $"../Juego/turno_marea_viva_jugador1"
@onready var turno_marea_viva_jugador_2: Label = $"../Juego/turno_marea_viva_jugador2"
@onready var tide_animator: AnimationPlayer = $"../tide_animator"

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
	var tide_animation : String = ""
	if marea == 0:
		match estadoMareaJugador:
				"muerta":
					color_jugador1 = Color.DARK_RED
					turno_marea_viva_jugador_1.visible = false
					tide_animation = "player1_muerta_tide"
				"baja":
					color_jugador1 = Color.DARK_ORANGE
					turno_marea_viva_jugador_1.visible = false
					tide_animation = "player1_baja_tide"
				"inicial":
					color_jugador1 = Color.MEDIUM_TURQUOISE
					tide_animation = "player1_initial_tide"
					turno_marea_viva_jugador_1.visible = false
				"alta":
					color_jugador1 = Color.TURQUOISE
					tide_animation = "player1_alta_tide"
					turno_marea_viva_jugador_1.visible = false
				"viva":
					color_jugador1 = Color.LIGHT_CYAN
					tide_animation = "player1_viva_tide"
		if barra_marea_jugador_1.modulate != color_jugador1 and tide_animation != "":
			tide_animator.play(tide_animation)
			#await tide_animator.animation_finished
		barra_marea_jugador_1.modulate = color_jugador1
	if marea == 1:
		match estadoMareaOponente:
				"muerta":
					color_jugador2 = Color.DARK_RED
					turno_marea_viva_jugador_2.visible = false
					tide_animation = "player2_muerta_tide"
				"baja":
					color_jugador2 = Color.DARK_ORANGE
					turno_marea_viva_jugador_2.visible = false
					tide_animation = "player2_baja_tide"
				"inicial":
					color_jugador2 = Color.MEDIUM_TURQUOISE
					tide_animation = "player2_initial_tide"
					turno_marea_viva_jugador_2.visible = false
				"alta":
					color_jugador2 = Color.TURQUOISE
					tide_animation = "player2_alta_tide"
					turno_marea_viva_jugador_2.visible = false
				"viva":
					color_jugador2 = Color.LIGHT_CYAN
					tide_animation = "player2_viva_tide"
					turno_marea_viva_jugador_2.visible = true
		if barra_marea_jugador_2.modulate != color_jugador2 and tide_animation != "":
			tide_animator.play(tide_animation)
			#await tide_animator.animation_finished
		barra_marea_jugador_2.modulate = color_jugador2

#func _process(delta):
	#marea_jugador.text = "Jug - Cantidad: " + str(mareaJugador) + ". Estado: " + str(estadoMareaJugador) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaJugador)
	#marea_oponente.text = "Opo - Cantidad: " + str(mareaOponente) + ". Estado: " + str(estadoMareaOponente) + ". Turnos marea viva: " + str(turn_manager.turnosMareaVivaOponente)
