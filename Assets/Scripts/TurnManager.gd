extends Node

@onready var torch_manager = $"../TorchManager"
@onready var tide_manager = $"../TideManager"
@onready var mano_jugador = %Mano
@onready var mano_oponente = %ManoOponente
@onready var collision_jugador = $"../JuegoUI/Area2D/CollisionJugador"
@onready var collision_oponente = $"../JuegoUI/Area2D2/CollisionOponente"
@onready var boton_pasar_turno = $"../JuegoUI/botonPasarTurno"

@onready var numTurno : int = 0
@onready var juegaTurno : String
@onready var turnosMareaVivaJugador : int = 0
@onready var turnosMareaVivaOponente : int = 0
@onready var campo = %Campo
@onready var campo_oponente = %CampoOponente
@onready var turn_label = $"../JuegoUI/turno"

var estadoJuego : String

const MAX_CARTAS_MANO : int = 7
const card_database = preload("res://Assets/Scripts/cardDataBase.gd")

const criatura_activa_jugador = preload("res://Assets/Scenes/CartasJugador/criaturaActivaJugador.tscn")
const criatura_pasiva_jugador = preload("res://Assets/Scenes/CartasJugador/criaturaPasivaJugador.tscn")
const conjuro_jugador = preload("res://Assets/Scenes/CartasJugador/conjuroJugador.tscn")

const criatura_activa_oponente = preload("res://Assets/Scenes/CartasOponente/criaturaActivaOponente.tscn")
const criatura_pasiva_oponente = preload("res://Assets/Scenes/CartasOponente/criaturaPasivaOponente.tscn")
const conjuro_oponente = preload("res://Assets/Scenes/CartasOponente/conjuroOponente.tscn")

func _ready():
	estadoJuego = "decide"
	determinarInicio()
	estadoJuego = "jugando"
	torch_manager.iniciarAntorchas()
	tide_manager.iniciarMareas()

func determinarInicio():
	
	boton_pasar_turno.disabled = true
	collision_jugador.hide()
	collision_oponente.hide()
	
	if DeckBuild.baraja_seleccionada == 0:
		DeckBuild.baraja_jugador_partida = DeckBuild.baraja_jugador1.duplicate()
	elif DeckBuild.baraja_seleccionada == 1:
		DeckBuild.baraja_jugador_partida = DeckBuild.baraja_jugador2.duplicate()
	
	DeckBuild.baraja_oponente_partida = DeckBuild.barajaOponente.duplicate()
	
	DeckBuild.baraja_jugador_partida.shuffle()
	DeckBuild.baraja_oponente_partida.shuffle()
	
	numTurno = 1
	juegaTurno = "Decidiendo..."
	turn_label.text = juegaTurno
	await get_tree().create_timer(1.0).timeout
	boton_pasar_turno.disabled = false
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0, 1) == 0:
		juegaTurno = "jugador"
		esTurnoJugador()
	else:
		juegaTurno = "oponente"
		esTurnoOponente()
		
	change_turn_label()

func esTurnoOponente():
	
	if tide_manager.estadoMareaOponente == "viva":
		turnosMareaVivaOponente += 1
	tide_manager.estadoMareaOponente = tide_manager.comprobarMarea(tide_manager.mareaOponente, tide_manager.estadoMareaOponente)

	despertar_cartas(1)
	activar_cartas_en_mesa(1, 1)
	torch_manager.antorchas_actuales_oponente.text = "Antorchas: " + str(torch_manager.maxAntorchas)
	leerCartasEnMesa(0, 1)
	collision_oponente.disabled = false
	collision_jugador.disabled = true
	collision_oponente.show()
	collision_jugador.hide()
	#tide_manager.mareaOponente += 1
	robaCartaOponente()
	
func esTurnoJugador():
	
	if tide_manager.estadoMareaJugador == "viva":
		turnosMareaVivaJugador += 1
	tide_manager.estadoMareaJugador = tide_manager.comprobarMarea(tide_manager.mareaJugador, tide_manager.estadoMareaJugador)

	despertar_cartas(0)
	activar_cartas_en_mesa(0, 1)
	
	torch_manager.antorchas_actuales_jugador.text = "Antorchas: " + str(torch_manager.maxAntorchas)
	leerCartasEnMesa(0,0)
	collision_oponente.disabled = true
	collision_jugador.disabled = false
	collision_jugador.show()
	collision_oponente.hide()
	#tide_manager.mareaJugador += 1
	robaCartaJugador()

func finalizaTurno():
	if juegaTurno == "jugador":
		activar_cartas_en_mesa(0, 0)
		leerCartasEnMesa(1,0)
		numTurno += 1
		if numTurno % 2 != 0 and numTurno != 1:
			torch_manager.subeMaximo()
		torch_manager.restauraAntorchasOponente()
		juegaTurno = "oponente"
		esTurnoOponente()

	elif juegaTurno == "oponente":
		activar_cartas_en_mesa(1, 0)
		leerCartasEnMesa(1,1)
		numTurno += 1
		if numTurno % 2 != 0 and numTurno != 1:
			torch_manager.subeMaximo()
		torch_manager.restauraAntorchasJugador()
		juegaTurno = "jugador"
		esTurnoJugador()

	change_turn_label()
	comprobar_estado_partida()

func robaCartaJugador():
	if mano_jugador.get_child_count() < 7:
		if DeckBuild.baraja_jugador_partida.size() != 0:
			var nueva_carta_id = DeckBuild.baraja_jugador_partida.pop_back()
			var nueva_carta_info = load(card_database.DATA[nueva_carta_id])
			var nueva_carta
			if nueva_carta_info.card_type == 0:
				nueva_carta = criatura_activa_jugador.instantiate()
			elif nueva_carta_info.card_type == 1:
				nueva_carta = criatura_pasiva_jugador.instantiate()
			else:
				nueva_carta = conjuro_jugador.instantiate()
			nueva_carta.card_info = nueva_carta_info
			#nueva_carta.card_info.effect_text = "Modifica la marea en " + str(nueva_carta.card_info.tide_amount) + " puntos"
			mano_jugador.add_child(nueva_carta)

func robaCartaOponente():
	if mano_oponente.get_child_count() < 7:
		if DeckBuild.baraja_oponente_partida.size() != 0:
			var nueva_carta_id = DeckBuild.baraja_oponente_partida.pop_back()
			var nueva_carta_info = load(card_database.DATA[nueva_carta_id])
			var nueva_carta
			if nueva_carta_info.card_type == 0:
				nueva_carta = criatura_activa_oponente.instantiate()
			elif nueva_carta_info.card_type == 1:
				nueva_carta = criatura_pasiva_oponente.instantiate()
			else:
				nueva_carta = conjuro_oponente.instantiate()
			nueva_carta.card_info = nueva_carta_info
			mano_oponente.add_child(nueva_carta)

func leerCartasEnMesa(moment, player):
	#moment -> 0 - Inicio del turno
	#			1 - Final del turno
	#player -> 0 - Jugador 1 (jugador normal)
	#			1 - Jugador 2 (IA / segundo jugador)
	var board

	if player == 0:
		board = get_tree().get_first_node_in_group("board")
		tide_manager.marea_seleccionada = 0
	else:
		board = get_tree().get_first_node_in_group("boardOponente")
		tide_manager.marea_seleccionada = 1

	for child in board.get_children():
		if moment == 0:
			#if child.card_info.has_method("effect") and child.card_info.execution == "Start"
			pass
		else:
			if child.card_info.has_method("effect") and child.card_info.execution == child.card_info.Execution.End:
				tide_manager.update_tide(child.card_info.effect())

func comprobar_estado_partida():
	if DeckBuild.baraja_jugador_partida.size() + mano_jugador.get_child_count() == 0 and campo.get_child_count() == 0:
		turn_label.text = "Gana el oponente. Volviendo al menú"
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
	
	if DeckBuild.baraja_oponente_partida.size() + mano_oponente.get_child_count() == 0 and campo_oponente.get_child_count() == 0:
		turn_label.text = "Gana el jugador. Volviendo al menú"
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		print(turn_label.text)
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
		
	if turnosMareaVivaJugador == 3:
		turn_label.text = "Gana el jugador. Volviendo al menú"
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
		
	if turnosMareaVivaOponente == 3:
		turn_label.text = "Gana el oponente. Volviendo al menú"
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")

func _on_boton_pasar_turno_pressed():
	finalizaTurno()

func change_turn_label():
	if juegaTurno == "Decidiendo...":
		turn_label.text = juegaTurno
	else:
		turn_label.text = "Turno de " + juegaTurno + ". Ronda " + str(numTurno)

func despertar_cartas(target : int):
	
	#0 = jugador1 ; 1 = jugador2
	
	if target == 0:
		for i in campo.get_children():
			#i.first_turn_resting = false
			i.has_attacked = false
	else:
		for i in campo_oponente.get_children():
			#i.first_turn_resting = false
			i.has_attacked = false

func activar_cartas_en_mesa(target : int, estado : int):
	
	#target: 0 = jugador1; 1 = jugador2
	#estado: 0 = desactivar; 1 = activar
	
	if target == 0:
		if estado == 0:
			for i in campo.get_children():
				i.disabled_card = true
			for i in mano_jugador.get_children():
				i.disabled_card = true
		else:
			for i in campo.get_children():
				i.disabled_card = false
			for i in mano_jugador.get_children():
				i.disabled_card = false
	else:
		if estado == 0:
			for i in campo_oponente.get_children():
				i.disabled_card = true
			for i in mano_oponente.get_children():
				i.disabled_card = true
		else:
			for i in campo_oponente.get_children():
				i.disabled_card = false
			for i in mano_oponente.get_children():
				i.disabled_card = false
