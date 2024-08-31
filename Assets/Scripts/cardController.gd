extends Control

class_name CardUI

#Este script sirve para las cartas del jugador1

const CARD_DELAY_SPEED = 12.0	#Delay al arrastrar la carta con el cursor

@onready var state_machine : CardStateMachine = $CardStateMachine
@onready var torch_manager = $TorchManager
@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")
@onready var tide_manager := get_tree().get_first_node_in_group("tide_manager")
@onready var mano_jugador1 := get_tree().get_first_node_in_group("hand")
@onready var mano_jugador2 := get_tree().get_first_node_in_group("hand_oponente")
@onready var baraja_jugador1 := get_tree().get_first_node_in_group("baraja_jugador1")
@onready var baraja_jugador2 := get_tree().get_first_node_in_group("baraja_jugador2")
@onready var cementerio_jugador1 := get_tree().get_first_node_in_group("cementerio_jugador1")
@onready var cementerio_jugador2 := get_tree().get_first_node_in_group("cementerio_jugador2")
@onready var ui_layer := get_tree().get_first_node_in_group("ui_layer")
@onready var detector_colision: Area2D = $detectorColision

@onready var nombre = $on_hand/Nombre
@onready var descripcion = $on_hand/Descripcion

@onready var ataque_label = $on_hand/Ataque
@onready var marea_label = $on_hand/Marea
@onready var vida_label = $on_hand/Vida

@onready var coste = $on_hand/Coste

@onready var on_hand_tex = $on_hand/on_hand_tex
@onready var on_board_tex = $on_board/on_board_tex

@onready var marea_on_board = $on_board/Marea_on_board
@onready var vida_on_board = $on_board/Vida_on_board
@onready var ataque_on_board = $on_board/Ataque_on_board

@onready var on_hand = $on_hand
@onready var on_board = $on_board
@onready var _animator = $AnimationPlayer
enum player_owner {player1, player2}
@onready var card_owner : player_owner

#Parámetros de la carta, pueden cambiar en el transcurso de la partida
var vida : int
var ataque : int
var marea : int

var card_info : cardResource	#Al crear la carta se le añade su info

var on_card : bool	#Cursor sobre la carta
var disabled_card : bool = false	#Carta desactivada, no se podrá interactuar con ella cuando true
var has_attacked : bool = true	#Para cartas activas, default en true porque el primer turno de ponerlas no atacan
var reorder_pos : int = -1

@onready var finished_zooming : bool = false

var temp_pos_in : Vector2
var temp_pos_out : Vector2

func _ready():
	nombre.text = card_info.card_name
	coste.text = str(card_info.card_cost)
	on_hand_tex.texture = card_info.texture
	on_board_tex.texture = card_info.texture
	descripcion.text = card_info.effect_text
	card_owner = 0
	
	#Si la carta es activa o pasiva
	if card_info.card_type == 0 or card_info.card_type == 1:
		vida_label.text = str(card_info.life)
		vida = card_info.life
		vida_on_board.text = vida_label.text
	
	#Si la carta es activa
	if card_info.card_type == 0:
		ataque_label.text = str(card_info.damage)
		ataque = card_info.damage
		ataque_on_board.text = ataque_label.text
	
	#Si la carta es pasiva
	if card_info.card_type == 1:
		marea_label.text = str(card_info.tide_amount)
		marea = card_info.tide_amount
		marea_on_board.text = marea_label.text
	
	_animator.play("turn_card_around")

func _process(delta):
	
	pass
	
	#if on_card:
		#for card in get_parent().get_children():
			#if card != self:
				#card.disabled_card = true
	#else:
		#for card in get_parent().get_children():
			#if card != self:
				#card.disabled_card = false
	
	##Hacer zoom en la carta solo cuando estén en la mano
	#if on_card and state_machine.current_state.name == "idleState" and not disabled_card and not is_dragged:
		##var pos = position
		##var dest = -10
		##if pos.y > pos.y + dest:
			##position = position.lerp(Vector2(position.x, position.y - 10), delta*30)
			##print("estoy mostrando")
		#scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
		#descripcion.show()
	#else:
		#scale = scale.lerp(Vector2(1, 1), delta*30)
		#descripcion.hide()

func _on_mouse_entered():
	if not finished_zooming and state_machine.current_state.name == "idleState" and not disabled_card:
		zoom_in_card()
	on_card = true

func _on_mouse_exited():
	if finished_zooming and state_machine.current_state.name == "idleState" and not disabled_card and reorder_pos == -1:
		zoom_out_card()
	on_card = false

func zoom_in_card():
	if card_owner == 0:
		for card in turn_manager.mano_jugador.get_children():
			if card != self:
				card.disabled_card = true
	else:
		for card in turn_manager.mano_jugador2.get_children():
			if card != self:
				card.disabled_card = true
	await pull_apart_cards_in_hand()
	var tween_in : Tween = get_tree().create_tween()
	tween_in.connect("finished", on_tween_in_finished)
	tween_in.set_ease(Tween.EASE_IN)
	tween_in.set_trans(Tween.TRANS_BACK)
	tween_in.set_parallel(true)
	tween_in.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	tween_in.tween_property(self, "position", temp_pos_in, 0.1)
	#turn_manager.reajustar_mano(card_owner)
	#z_index = 1
	descripcion.show()

func zoom_out_card():
	if card_owner == 0:
		for card in turn_manager.mano_jugador.get_children():
			if card != self:
				card.disabled_card = false
	else:
		for card in turn_manager.mano_jugador2.get_children():
			if card != self:
				card.disabled_card = false
	#turn_manager.reajustar_mano(card_owner)
	var tween_out : Tween = get_tree().create_tween()
	tween_out.connect("finished", on_tween_out_finished)
	tween_out.set_ease(Tween.EASE_OUT)
	tween_out.set_trans(Tween.TRANS_BACK)
	tween_out.set_parallel(true)
	tween_out.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween_out.tween_property(self, "position", temp_pos_out, 0.1)
	await pull_in_cards_in_hand()
	#turn_manager.reajustar_mano(card_owner)
	#z_index = 0
	descripcion.hide()

func on_tween_in_finished():
	finished_zooming = true

func on_tween_out_finished():
	finished_zooming = false
	
func pull_apart_cards_in_hand():
	if card_owner == 0:
		for card in turn_manager.mano_jugador.get_children():
			if card == self:
				pass
			elif self.get_global_rect().position.x > card.get_global_rect().position.x:
				var reorder_left_tween : Tween = get_tree().create_tween()
				reorder_left_tween.set_ease(Tween.EASE_OUT)
				reorder_left_tween.set_trans(Tween.TRANS_QUART)
				reorder_left_tween.tween_property(card, "position", Vector2(card.position.x - size.x/2, card.position.y), 0.3)
			else:
				var reorder_right_tween : Tween = get_tree().create_tween()
				reorder_right_tween.set_ease(Tween.EASE_OUT)
				reorder_right_tween.set_trans(Tween.TRANS_QUART)
				reorder_right_tween.tween_property(card, "position", Vector2(card.position.x + size.x/2, card.position.y), 0.3)
	else:
		for card in turn_manager.mano_jugador2.get_children():
			if card == self:
				pass
			elif self.get_global_rect().position.x > card.get_global_rect().position.x:
				var reorder_left_tween : Tween = get_tree().create_tween()
				reorder_left_tween.set_ease(Tween.EASE_OUT)
				reorder_left_tween.set_trans(Tween.TRANS_QUART)
				reorder_left_tween.tween_property(card, "position", Vector2(card.position.x - size.x/2, card.position.y), 0.3)
			else:
				var reorder_right_tween : Tween = get_tree().create_tween()
				reorder_right_tween.set_ease(Tween.EASE_OUT)
				reorder_right_tween.set_trans(Tween.TRANS_QUART)
				reorder_right_tween.tween_property(card, "position", Vector2(card.position.x + size.x/2, card.position.y), 0.3)

func pull_in_cards_in_hand():
	if card_owner == 0:
		for card in turn_manager.mano_jugador.get_children():
			if card == self:
				pass
			elif self.get_global_rect().position.x > card.get_global_rect().position.x:
				var reorder_left_tween : Tween = get_tree().create_tween()
				reorder_left_tween.set_ease(Tween.EASE_OUT)
				reorder_left_tween.set_trans(Tween.TRANS_BACK)
				reorder_left_tween.tween_property(card, "position", Vector2(card.position.x + size.x/2, card.position.y), 0.3)

			else:
				var reorder_right_tween : Tween = get_tree().create_tween()
				reorder_right_tween.set_ease(Tween.EASE_OUT)
				reorder_right_tween.set_trans(Tween.TRANS_EXPO)
				reorder_right_tween.tween_property(card, "position", Vector2(card.position.x - size.x/2, card.position.y), 0.3)
	else:
		for card in turn_manager.mano_jugador2.get_children():
			if card == self:
				pass
			elif self.get_global_rect().position.x > card.get_global_rect().position.x:
				var reorder_left_tween : Tween = get_tree().create_tween()
				reorder_left_tween.set_ease(Tween.EASE_OUT)
				reorder_left_tween.set_trans(Tween.TRANS_BACK)
				reorder_left_tween.tween_property(card, "position", Vector2(card.position.x + size.x/2, card.position.y), 0.3)

			else:
				var reorder_right_tween : Tween = get_tree().create_tween()
				reorder_right_tween.set_ease(Tween.EASE_OUT)
				reorder_right_tween.set_trans(Tween.TRANS_EXPO)
				reorder_right_tween.tween_property(card, "position", Vector2(card.position.x - size.x/2, card.position.y), 0.3)

func card_death():
	self.detector_colision.monitoring = false
	self.reparent(ui_layer)
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	if card_owner == 0:
		if card_info.card_type == 0 or card_info.card_type == 1:
			tween.tween_property(self, "position", cementerio_jugador1.position, 0.75)
			await tween.finished
			#DeckBuild.cementerio_jugador.append(self.card_info.card_id)
			#cementerio_jugador1.texture = self.on_hand_tex.texture
		elif card_info.card_type == 2:
			tween.tween_property(self, "position", cementerio_jugador1.position, 0.75)
			await tween.finished
		else:
			tween.tween_property(self, "position", Vector2(get_viewport().size.x/2 - self.size.x/2, get_viewport().size.y/2 - self.size.y/2), 0.75)
			tween.tween_property(self, "position", cementerio_jugador1.position, 0.75)
			await tween.finished
		DeckBuild.cementerio_jugador.append(self.card_info.card_id)
		cementerio_jugador1.texture = self.on_hand_tex.texture
	else:
		if card_info.card_type == 0 or card_info.card_type == 1:
			tween.tween_property(self, "position", cementerio_jugador2.position, 0.75)
			await tween.finished
			#DeckBuild.cementerio_oponente.append(self.card_info.card_id)
			#cementerio_jugador2.texture = self.on_hand_tex.texture
		elif card_info.card_type == 2:
			tween.tween_property(self, "position", cementerio_jugador2.position, 0.75)
			await tween.finished
		else:
			tween.tween_property(self, "position", Vector2(get_viewport().size.x/2 - self.size.x/2, get_viewport().size.y/2 - self.size.y/2), 0.75)
			tween.tween_property(self, "position", cementerio_jugador2.position, 0.75)
			await tween.finished
		DeckBuild.cementerio_oponente.append(self.card_info.card_id)
		cementerio_jugador2.texture = self.on_hand_tex.texture
	self.queue_free()

func card_draw():
	if card_owner == 0:
		var in_hand_pos : Vector2 = turn_manager.posiciones_cartas_jugador1[turn_manager.posiciones_cartas_jugador1.size() - 1] + mano_jugador1.position
		self.detector_colision.monitoring = false
		self.reparent(ui_layer)
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUART)
		tween.set_ease(Tween.EASE_OUT)
		self.position = baraja_jugador1.position
		tween.tween_property(self, "position", in_hand_pos, 0.75)
		await tween.finished
		self.reparent(mano_jugador1)
	else:
		var in_hand_pos : Vector2 = turn_manager.posiciones_cartas_jugador2[turn_manager.posiciones_cartas_jugador2.size() - 1] + mano_jugador2.position
		self.detector_colision.monitoring = false
		self.reparent(ui_layer)
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUART)
		tween.set_ease(Tween.EASE_OUT)
		self.position = baraja_jugador2.position
		tween.tween_property(self, "position", in_hand_pos, 0.75)
		await tween.finished
		self.reparent(mano_jugador2)
	self.detector_colision.monitoring = true
