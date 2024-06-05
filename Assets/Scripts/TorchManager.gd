extends Node

class_name torchManager



const MAXIMO_ANTORCHAS_JUEGO : int = 10

@onready var antorchasActualesJugador : int = 0
@onready var antorchasActualesOponente : int = 0
@onready var maxAntorchas : int = 0

func iniciarAntorchas():
	maxAntorchas = 1
	antorchasActualesJugador = maxAntorchas
	antorchasActualesOponente = maxAntorchas

func subeMaximo():
	if maxAntorchas < MAXIMO_ANTORCHAS_JUEGO:
		maxAntorchas += 1

func restauraAntorchasJugador():
	antorchasActualesJugador = maxAntorchas

func restauraAntorchasOponente():
	antorchasActualesOponente = maxAntorchas
	

