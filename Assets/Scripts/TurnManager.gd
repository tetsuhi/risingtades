extends Node

@onready var torch_manager = $"../TorchManager"
@onready var tide_manager = $"../TideManager"
@onready var mano_jugador = %mano_jugador1
#*****************************************************
@export var curva_distancia_mano : Curve
@export var curva_arco_mano : Curve
@export var curva_arco_mano_player2 : Curve
#@onready var mano_provisional = %mano_provisional
#*****************************************************
@onready var mano_jugador2 = %mano_jugador2
@onready var collision_jugador = $"../Juego/Area2D/CollisionJugador"
@onready var collision_oponente = $"../Juego/Area2D2/CollisionOponente"
@onready var collision_mano_jugador1 = $"../Juego/zona_mano_jugador1/CollisionManoJugador1"
@onready var collision_mano_jugador_2 = $"../Juego/zona_mano_jugador2/CollisionManoJugador2"
@onready var boton_pasar_turno = $"../Juego/botonPasarTurno"
@onready var pause_button: Button = $"../UI/pause_button"
@onready var end_game_menu: Control = $"../UI/end_game_menu"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var background_animator: AnimationPlayer = $"../background_animator"

@onready var numTurno : int = 0
@onready var juegaTurno : String
@onready var turnosMareaVivaJugador : int = 0
@onready var turnosMareaVivaOponente : int = 0
@onready var campo_jugador1 = %campo_jugador1
@onready var campo_oponente = %campo_jugador2
@onready var turn_label = $"../Juego/turno"
@onready var win_label: Label = $"../UI/end_game_menu/Panel/Label"


var estadoJuego : String

const MAX_CARTAS_MANO : int = 7
const HAND_WIDTH : float = 50.0
const BOARD_WIDTH : float = 75.0
const HAND_HEIGHT : float = 5.0
const CARD_WIDTH : float = 170.0
const card_database = preload("res://Assets/Scripts/cardDataBase.gd")

const criatura_activa_jugador = preload("res://Assets/Scenes/CartasJugador/criaturaActivaJugador.tscn")
const criatura_pasiva_jugador = preload("res://Assets/Scenes/CartasJugador/criaturaPasivaJugador.tscn")
const conjuro_jugador = preload("res://Assets/Scenes/CartasJugador/conjuroJugador.tscn")

const criatura_activa_oponente = preload("res://Assets/Scenes/CartasOponente/criaturaActivaOponente.tscn")
const criatura_pasiva_oponente = preload("res://Assets/Scenes/CartasOponente/criaturaPasivaOponente.tscn")
const conjuro_oponente = preload("res://Assets/Scenes/CartasOponente/conjuroOponente.tscn")

func _ready():
	background_animator.play("background_loop")
	estadoJuego = "decide"
	determinarInicio()
	estadoJuego = "jugando"
	torch_manager.iniciarAntorchas()
	tide_manager.iniciarMareas()

	#for i in 7:
		#var id_prov = "2"
		#var info_prov = load(card_database.DATA[id_prov])
		#var carta_prov = criatura_activa_jugador.instantiate()
		#carta_prov.card_info = info_prov
		#mano_provisional.add_child(carta_prov)
	#
	#for card in mano_provisional.get_children():
		#var hand_ratio = 0.5
		#
		#if mano_provisional.get_child_count() > 1:
			#hand_ratio = float(card.get_index())/float(mano_provisional.get_child_count() - 1)
			#
		#var destination = mano_provisional.position
		#destination.x += curva_distancia_mano.sample(hand_ratio) * HAND_WIDTH
		#destination.y += curva_arco_mano.sample(hand_ratio) * HAND_HEIGHT
		#
		#card.position.x = mano_provisional.position.x - destination.x - card.size.x/2
		#card.position.y = mano_provisional.position.y - destination.y - card.size.y/2


func determinarInicio():
	
	boton_pasar_turno.disabled = true
	collision_jugador.hide()
	collision_oponente.hide()
	collision_mano_jugador1.hide()
	collision_mano_jugador_2.hide()
	
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
	boton_pasar_turno.disabled = false
	animation_player.play("decidiendo_turno")
	await animation_player.animation_finished
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0, 1) == 0:
		animation_player.play("primer_turno_jugador1")
		juegaTurno = "jugador"
		esTurnoJugador()
	else:
		animation_player.play("primer_turno_jugador2")
		juegaTurno = "oponente"
		esTurnoOponente()
		
	change_turn_label()

func esTurnoOponente():
	
	if tide_manager.estadoMareaOponente == "viva":
		turnosMareaVivaOponente += 1
	tide_manager.estadoMareaOponente = tide_manager.comprobarMarea(tide_manager.mareaOponente, tide_manager.estadoMareaOponente)
	tide_manager.change_bar_color(1)
	torch_manager.antorchas_actuales_oponente.text = "Antorchas: " + str(torch_manager.maxAntorchas)
	leerCartasEnMesa(0, 1)
	collision_oponente.disabled = false
	collision_jugador.disabled = true
	collision_oponente.show()
	collision_mano_jugador_2.show()
	collision_jugador.hide()
	collision_mano_jugador1.hide()
	#tide_manager.mareaOponente += 1
	robaCartaOponente()
	despertar_cartas(1)
	activar_cartas_en_mesa(1, 1)
	
func esTurnoJugador():
	
	if tide_manager.estadoMareaJugador == "viva":
		turnosMareaVivaJugador += 1
	tide_manager.estadoMareaJugador = tide_manager.comprobarMarea(tide_manager.mareaJugador, tide_manager.estadoMareaJugador)	
	tide_manager.change_bar_color(0)
	torch_manager.antorchas_actuales_jugador.text = "Antorchas: " + str(torch_manager.maxAntorchas)
	leerCartasEnMesa(0,0)
	collision_oponente.disabled = true
	collision_jugador.disabled = false
	collision_mano_jugador1.show()
	collision_jugador.show()
	collision_oponente.hide()
	collision_mano_jugador_2.hide()
	#tide_manager.mareaJugador += 1
	robaCartaJugador()
	despertar_cartas(0)
	activar_cartas_en_mesa(0, 1)

func finalizaTurno():
	if juegaTurno == "jugador":
		animation_player.play("cambio_turno_jugador2")
		activar_cartas_en_mesa(0, 0)
		leerCartasEnMesa(1,0)
		numTurno += 1
		if numTurno % 2 != 0 and numTurno != 1:
			torch_manager.subeMaximo()
		torch_manager.restauraAntorchasOponente()
		juegaTurno = "oponente"
		esTurnoOponente()

	elif juegaTurno == "oponente":
		animation_player.play("cambio_turno_jugador1")
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
	
	reajustar_mano(0)

func robaCartaOponente():
	if mano_jugador2.get_child_count() < 7:
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
			mano_jugador2.add_child(nueva_carta)
	reajustar_mano(1)

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
			if child.card_info.has_method("effect") and child.card_info.execution == child.card_info.Execution.Start:
				match child.card_info.card_target:
					0:
						child.card_info.effect(child)
					1:	#tide
						#tide_manager.marea_seleccionada == card.card_info.marea
						#tide_manager.update_tide(card.card_info.tide_sum)
						#card.queue_free()
						pass
					2: #hand
						pass
					3: #oponent hand
						pass
					4: #deck
						pass
					5: #graveyard
						pass 
					6: #allycreatures
						child.card_info.effect(board.get_children())
					7: #enemycreatures
						pass
		else:
			if child.card_info.has_method("effect") and child.card_info.execution == child.card_info.Execution.End:
				match child.card_info.card_target:
					0:
						child.card_info.effect(child)
					1:	#tide
						#tide_manager.marea_seleccionada == card.card_info.marea
						#tide_manager.update_tide(card.card_info.tide_sum)
						#card.queue_free()
						pass
					2: #hand
						pass
					3: #oponent hand
						pass
					4: #deck
						pass
					5: #graveyard
						pass 
					6: #allycreatures
						child.card_info.effect(board.get_children())
					7: #enemycreatures
						pass
			if child.card_info.card_type == 1:
				tide_manager.update_tide(child.marea)

func comprobar_estado_partida():
	if DeckBuild.baraja_jugador_partida.size() + mano_jugador.get_child_count() == 0 and campo_jugador1.get_child_count() == 0:
		turn_label.text = "Gana el oponente. Volviendo al menú"
		win_label.text = "¡Ha ganado el jugador 2!"
		end_game_menu.animation_player.play("end_game_menu")
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		boton_pasar_turno.disabled = true
		pause_button.disabled = true
		#await get_tree().create_timer(1.0).timeout
		#SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
	
	if DeckBuild.baraja_oponente_partida.size() + mano_jugador2.get_child_count() == 0 and campo_oponente.get_child_count() == 0:
		turn_label.text = "Gana el jugador. Volviendo al menú"
		win_label.text = "¡Ha ganado el jugador 1!"
		end_game_menu.animation_player.play("end_game_menu")
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		boton_pasar_turno.disabled = true
		pause_button.disabled = true
		#await get_tree().create_timer(1.0).timeout
		#SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
		
	if turnosMareaVivaJugador == 3:
		turn_label.text = "Gana el jugador. Volviendo al menú"
		win_label.text = "¡Ha ganado el jugador 1!"
		end_game_menu.animation_player.play("end_game_menu")
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		boton_pasar_turno.disabled = true
		pause_button.disabled = true
		#await get_tree().create_timer(1.0).timeout
		#SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
		
	if turnosMareaVivaOponente == 3:
		turn_label.text = "Gana el oponente. Volviendo al menú"
		win_label.text = "¡Ha ganado el jugador 2!"
		end_game_menu.animation_player.play("end_game_menu")
		DeckBuild.cementerio_jugador = []
		DeckBuild.cementerio_oponente = []
		boton_pasar_turno.disabled = true
		pause_button.disabled = true
		#await get_tree().create_timer(1.0).timeout
		#SceneTransition.change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")

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
		for i in campo_jugador1.get_children():
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
			for i in campo_jugador1.get_children():
				i.disabled_card = true
			for i in mano_jugador.get_children():
				i.disabled_card = true
				i._animator.play("hide_card")
				reajustar_mano(0)
		else:
			for i in campo_jugador1.get_children():
				i.disabled_card = false
			for i in mano_jugador.get_children():
				i.disabled_card = false
				i._animator.play("turn_card_around")
				reajustar_mano(0)
	else:
		if estado == 0:
			for i in campo_oponente.get_children():
				i.disabled_card = true
			for i in mano_jugador2.get_children():
				i.disabled_card = true
				i._animator.play("hide_card")
				reajustar_mano(1)
		else:
			for i in campo_oponente.get_children():
				i.disabled_card = false
			for i in mano_jugador2.get_children():
				i.disabled_card = false
				i._animator.play("turn_card_around")
				reajustar_mano(1)

func reajustar_mano(jugador : int):
	if jugador == 0:
		for card in mano_jugador.get_children():
			var hand_ratio = 0.5
			
			if mano_jugador.get_child_count() > 1:
				hand_ratio = float(card.get_index())/float(mano_jugador.get_child_count() - 1)
				
			var destination = mano_jugador.position
			destination.x += - 1 * curva_distancia_mano.sample(hand_ratio) * (HAND_WIDTH * mano_jugador.get_child_count())
			destination.y += curva_arco_mano.sample(hand_ratio) * HAND_HEIGHT
			
			card.position.x = mano_jugador.position.x - destination.x - card.size.x/2
			card.position.y = mano_jugador.position.y - destination.y - card.size.y/2
			card.temp_pos_in = Vector2(card.position.x, card.position.y - 90)
			card.temp_pos_out = card.position
	else:
		for card in mano_jugador2.get_children():
			var hand_ratio = 0.5
			
			if mano_jugador2.get_child_count() > 1:
				hand_ratio = float(card.get_index())/float(mano_jugador2.get_child_count() - 1)
				
			var destination = mano_jugador2.position
			destination.x += - 1 * curva_distancia_mano.sample(hand_ratio) * (HAND_WIDTH * mano_jugador2.get_child_count())
			destination.y += curva_arco_mano_player2.sample(hand_ratio) * HAND_HEIGHT
			
			card.position.x = mano_jugador2.position.x - destination.x - card.size.x/2
			card.position.y = mano_jugador2.position.y - destination.y - card.size.y/2
			card.temp_pos_in = Vector2(card.position.x, card.position.y + 90)
			card.temp_pos_out = card.position

func reajustar_mesa(jugador : int):
	if jugador == 0:
		var board_left_limit : float = -CARD_WIDTH/2 * campo_jugador1.get_child_count()
		var new_position : float = board_left_limit
		for card in campo_jugador1.get_children():
			card.position.y = -card.size.y/2
			card.position.x = new_position
			new_position += card.size.x
	else:
		var board_left_limit : float = -CARD_WIDTH/2 * campo_oponente.get_child_count()
		var new_position : float = board_left_limit
		for card in campo_oponente.get_children():
			card.position.y = -card.size.y/2
			card.position.x = new_position
			new_position += card.size.x
		
func reordenar_mano(position) -> int:
	var i : int = 0
	while i < mano_jugador.get_child_count():
		if position > mano_jugador.get_child(i).get_global_rect().position.x:
			i += 1
		else:
			#reajustar_mano()
			return i
	#reajustar_mano()
	return mano_jugador.get_child_count()

func reordenar_mano_oponente(position) -> int:
	var i : int = 0
	while i < mano_jugador2.get_child_count():
		if position > mano_jugador2.get_child(i).get_global_rect().position.x:
			i += 1
		else:
			#reajustar_mano()
			return i
	#reajustar_mano()
	return mano_jugador2.get_child_count()

func reordenar_mesa(position) -> int:
	var i : int = 0
	while i < campo_jugador1.get_child_count():
		if position > campo_jugador1.get_child(i).get_global_rect().position.x:
			i += 1
		else:
			#reajustar_mano()
			return i
	#reajustar_mano()
	return campo_jugador1.get_child_count()

func reordenar_mesa_oponente(position) -> int:
	var i : int = 0
	while i < campo_oponente.get_child_count():
		if position > campo_oponente.get_child(i).get_global_rect().position.x:
			i += 1
		else:
			#reajustar_mano()
			return i
	#reajustar_mano()
	return campo_oponente.get_child_count()
