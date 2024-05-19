extends Node

const MAXIMO_ANTORCHAS_JUEGO : int = 10

var antorchasActualesJugador : int = 0
var antorchasActualesOponente : int = 0
var maxAntorchas : int = 0

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
