extends Node

class_name torchManager

const MAXIMO_ANTORCHAS_JUEGO : int = 10

@onready var antorchasActualesJugador : int = 0
@onready var antorchasActualesOponente : int = 0
@onready var maxAntorchas : int = 0
@onready var antorchas_max_jugador = $"../Juego/antorchasMaxJugador"
@onready var antorchas_max_oponente = $"../Juego/antorchasMaxOponente"
@onready var antorchas_actuales_jugador = $"../Juego/antorchasActualesJugador"
@onready var antorchas_actuales_oponente = $"../Juego/antorchasActualesOponente"
@onready var antorchas_jugador_1_primera_fila: HBoxContainer = $"../Juego/antorchas_jugador1/primera_fila"
@onready var antorchas_jugador_1_segunda_fila: HBoxContainer = $"../Juego/antorchas_jugador1/segunda_fila"
@onready var antorchas_jugador_2_primera_fila: HBoxContainer = $"../Juego/antorchas_jugador2/primera_fila"
@onready var antorchas_jugador_2_segunda_fila: HBoxContainer = $"../Juego/antorchas_jugador2/segunda_fila"

func iniciarAntorchas():
	maxAntorchas = 1
	max_antorchas(0)
	max_antorchas(1)
	antorchasActualesJugador = maxAntorchas
	antorchas_max_jugador.text = "Max: " + str(maxAntorchas)
	antorchas_actuales_jugador.text = "Antorchas: " + str(0)
	antorchasActualesOponente = maxAntorchas
	antorchas_max_oponente.text = "Max: " + str(maxAntorchas)
	antorchas_actuales_oponente.text = "Antorchas: " + str(0)

func subeMaximo():
	#Cada turno impar, el máximo de antorchas sube
	if maxAntorchas < MAXIMO_ANTORCHAS_JUEGO:
		maxAntorchas += 1
		max_antorchas(0)
		max_antorchas(1)
		antorchas_max_jugador.text = "Max: " + str(maxAntorchas)
		antorchas_max_oponente.text = "Max: " + str(maxAntorchas)

func restauraAntorchasJugador():
	antorchasActualesJugador = maxAntorchas
	for child in antorchas_jugador_1_primera_fila.get_children():
		if child.visible:
			child.texture = load("res://Assets/Textures/antorcha_encendida.png")
		else:
			break
	if maxAntorchas > 5:
		for child in antorchas_jugador_1_segunda_fila.get_children():
			if child.visible:
				child.texture = load("res://Assets/Textures/antorcha_encendida.png")
			else:
				break

func restauraAntorchasOponente():
	antorchasActualesOponente = maxAntorchas
	for child in antorchas_jugador_2_primera_fila.get_children():
		if child.visible:
			child.texture = load("res://Assets/Textures/antorcha_encendida.png")
		else:
			break
	if maxAntorchas > 5:
		for child in antorchas_jugador_2_segunda_fila.get_children():
			if child.visible:
				child.texture = load("res://Assets/Textures/antorcha_encendida.png")
			else:
				break

func max_antorchas(jugador: int):
	var copia_max = maxAntorchas
	if jugador == 0:
		if maxAntorchas <= 5:
			antorchas_jugador_1_primera_fila.get_child(maxAntorchas - 1).visible = true
			antorchas_jugador_1_primera_fila.get_child(maxAntorchas - 1).texture = load("res://Assets/Textures/antorcha_apagada.png")
		else:
			antorchas_jugador_1_segunda_fila.get_child(maxAntorchas - 6).visible = true
			antorchas_jugador_1_segunda_fila.get_child(maxAntorchas - 6).texture = load("res://Assets/Textures/antorcha_apagada.png")
	else:
		if maxAntorchas <= 5:
			antorchas_jugador_2_primera_fila.get_child(maxAntorchas - 1).visible = true
			antorchas_jugador_2_primera_fila.get_child(maxAntorchas - 1).texture = load("res://Assets/Textures/antorcha_apagada.png")
		else:
			antorchas_jugador_2_segunda_fila.get_child(maxAntorchas - 6).visible = true
			antorchas_jugador_2_segunda_fila.get_child(maxAntorchas - 6).texture = load("res://Assets/Textures/antorcha_apagada.png")

func apagar_antorchas(antorchas_restantes : int, jugador : int):
	if jugador == 0:
		for child in antorchas_jugador_1_primera_fila.get_children():
			if antorchas_restantes == 0:
				child.texture = load("res://Assets/Textures/antorcha_apagada.png")
			else:
				child.texture = load("res://Assets/Textures/antorcha_encendida.png")
				antorchas_restantes -= 1
		if antorchas_restantes > 0:
			for child in antorchas_jugador_1_segunda_fila.get_children():
				if antorchas_restantes == 0:
					child.texture = load("res://Assets/Textures/antorcha_apagada.png")
				else:
					child.texture = load("res://Assets/Textures/antorcha_encendida.png")
					antorchas_restantes -= 1
		else:
			for child in antorchas_jugador_1_segunda_fila.get_children():
				child.texture = load("res://Assets/Textures/antorcha_apagada.png")
	else:
		for child in antorchas_jugador_2_primera_fila.get_children():
			if antorchas_restantes == 0:
				child.texture = load("res://Assets/Textures/antorcha_apagada.png")
			else:
				child.texture = load("res://Assets/Textures/antorcha_encendida.png")
				antorchas_restantes -= 1
		if antorchas_restantes > 0:
			for child in antorchas_jugador_2_segunda_fila.get_children():
				if antorchas_restantes == 0:
					child.texture = load("res://Assets/Textures/antorcha_apagada.png")
				else:
					child.texture = load("res://Assets/Textures/antorcha_encendida.png")
					antorchas_restantes -= 1
		else:
			for child in antorchas_jugador_2_segunda_fila.get_children():
				child.texture = load("res://Assets/Textures/antorcha_apagada.png")
