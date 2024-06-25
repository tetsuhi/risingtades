extends Node

class_name torchManager



const MAXIMO_ANTORCHAS_JUEGO : int = 10

@onready var antorchasActualesJugador : int = 0
@onready var antorchasActualesOponente : int = 0
@onready var maxAntorchas : int = 0
@onready var antorchas_max_jugador = $"../JuegoUI/antorchasMaxJugador"
@onready var antorchas_max_oponente = $"../JuegoUI/antorchasMaxOponente"
@onready var antorchas_actuales_jugador = $"../JuegoUI/antorchasActualesJugador"
@onready var antorchas_actuales_oponente = $"../JuegoUI/antorchasActualesOponente"

func iniciarAntorchas():
	maxAntorchas = 1
	antorchasActualesJugador = maxAntorchas
	antorchas_max_jugador.text = "Max: " + str(maxAntorchas)
	antorchas_actuales_jugador.text = "Antorchas: " + str(0)
	antorchasActualesOponente = maxAntorchas
	antorchas_max_oponente.text = "Max: " + str(maxAntorchas)
	antorchas_actuales_oponente.text = "Antorchas: " + str(0)

func subeMaximo():
	if maxAntorchas < MAXIMO_ANTORCHAS_JUEGO:
		maxAntorchas += 1
		antorchas_max_jugador.text = "Max: " + str(maxAntorchas)
		antorchas_max_oponente.text = "Max: " + str(maxAntorchas)

func restauraAntorchasJugador():
	antorchasActualesJugador = maxAntorchas

func restauraAntorchasOponente():
	antorchasActualesOponente = maxAntorchas
	

