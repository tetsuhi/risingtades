extends State

class_name SpellAimStateOpoonente

@onready var collision := get_tree().get_first_node_in_group("collision_oponente")
@onready var puntero := get_tree().get_first_node_in_group("puntero")
@onready var mouse_pos := get_tree().get_first_node_in_group("mouse_pos")
@onready var campo_jugador := get_tree().get_first_node_in_group("board")
@onready var campo_oponente := get_tree().get_first_node_in_group("boardOponente")
@onready var mano := get_tree().get_first_node_in_group("hand")
@onready var mano_opo := get_tree().get_first_node_in_group("hand_oponente")
@onready var raycast := get_tree().get_first_node_in_group("raycast")
@onready var ui_layer := get_tree().get_first_node_in_group("ui_layer")
@onready var boton_pasar_turno := get_tree().get_first_node_in_group("boton_pasar_turno")
@onready var boton_pausa := get_tree().get_first_node_in_group("boton_pausa")

@export var idle_state : State

var card_pos : Vector2
var on_card : bool
var collider
var apuntando : bool

func on_enter():
	
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	card.position = Vector2(get_viewport().size.x/2 - card.size.x/2, get_viewport().size.y/2 - card.size.y/2)
	
	collision.disabled = true
	boton_pasar_turno.set_disabled(true)
	boton_pausa.set_disabled(true)
	disabling_cards()

func state_process(delta):
	if puntero.points.size() == 0:
		puntero.add_point(Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2))
		puntero.add_point(mouse_pos.get_global_mouse_position())
	puntero.points[0] = Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2)
	puntero.points[1] = mouse_pos.get_global_mouse_position()
	raycast.position = mouse_pos.get_local_mouse_position()
	#raycast.target_position = mouse_pos.get_global_mouse_position()
	
	collider = raycast.get_collider()

func state_input(event : InputEvent):
	if not apuntando and event.is_action_pressed("RMB"):
		card.torch_manager.antorchasActualesOponente += card.card_info.card_cost
		card.torch_manager.antorchas_actuales_oponente.text = "Antorchas: " + str(card.torch_manager.antorchasActualesOponente)
		puntero.hide()
		boton_pasar_turno.set_disabled(false)
		boton_pausa.set_disabled(false)
		collision.disabled = false
		enabling_cards()
		next_state = idle_state
	
	if apuntando and event.is_action_pressed("RMB"):
		apuntando = false
		puntero.hide()

	if not apuntando and event.is_action_pressed("LMB") and on_card:
		apuntando = true
		puntero.show()
	
	if apuntando and event.is_action_released("LMB") and collider != null:
		var card_objective = collider.get_owner()
		if not card_objective.disabled_card and card_objective != card:
			if card.card_info.effect(card_objective) == null:
				next_state = idle_state
			else:
				DeckBuild.cementerio_jugador.append(card.card_info.card_id)
				card.queue_free()

			enabling_cards()
			boton_pasar_turno.set_disabled(false)
			boton_pausa.set_disabled(false)
			collision.disabled = false
			puntero.hide()
		else:
			apuntando = false
			puntero.hide()
	elif event.is_action_released("LMB") and collider == null:
		apuntando = false
		puntero.hide()

func disabling_cards():
	for i in mano_opo.get_children():
		i.disabled_card = true
	if card.card_info.card_target == 7:				#6 es cartas aliadas, 7 es cartas oponentes
		for i in campo_jugador.get_children():
			i.disabled_card = false
	elif card.card_info.card_target == 6:
		for i in campo_oponente.get_children():
			i.disabled_card = false

func enabling_cards():
	for i in mano_opo.get_children():
		i.disabled_card = false
	if card.card_info.card_target == 7:				#6 es cartas aliadas, 7 es cartas oponentes
		for i in campo_jugador.get_children():
			i.disabled_card = true
	elif card.card_info.card_target == 6:
		for i in campo_oponente.get_children():
			i.disabled_card = true

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
