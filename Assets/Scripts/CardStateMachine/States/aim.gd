extends State

class_name AimState

@export var on_board_state : State
@onready var collision := get_tree().get_first_node_in_group("collision_jugador")
@onready var puntero := get_tree().get_first_node_in_group("puntero")
@onready var mouse_pos := get_tree().get_first_node_in_group("mouse_pos")
@onready var campo_oponente := get_tree().get_first_node_in_group("boardOponente")
@onready var mano := get_tree().get_first_node_in_group("hand")
@onready var manoOpo := get_tree().get_first_node_in_group("hand_oponente")
@onready var raycast := get_tree().get_first_node_in_group("raycast")
@onready var ui_layer := get_tree().get_first_node_in_group("ui_layer")
@onready var boton_pasar_turno := get_tree().get_first_node_in_group("boton_pasar_turno")
@onready var boton_pausa := get_tree().get_first_node_in_group("boton_pausa")
@onready var cementerio_jugador2 := get_tree().get_first_node_in_group("cementerio_jugador2")

var card_pos : Vector2
var on_card : bool
var collider

func on_enter():
	boton_pasar_turno.set_disabled(true)
	boton_pausa.set_disabled(true)
	collision.disabled = true
	puntero.show()
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
	if event.is_action_pressed("RMB"):
		puntero.hide()
		boton_pasar_turno.set_disabled(false)
		boton_pausa.set_disabled(false)
		collision.disabled = false
		for i in mano.get_children():
			i.disabled_card = false
		for i in campo_oponente.get_children():
			i.disabled_card = true
		next_state = on_board_state

	if event.is_action_released("LMB") and collider != null:
		var card_objective = collider.get_owner()
		if not card_objective.disabled_card and card_objective != card:
			if card_objective.vida - card.ataque <= 0:
				card_objective.reparent(ui_layer)
				var tween = get_tree().create_tween()
				tween.tween_property(card_objective, "position", cementerio_jugador2.position, 1)
				DeckBuild.cementerio_oponente.append(card_objective.card_info.card_id)
				card_objective.queue_free()
			card_objective.vida -= 1
			card_objective.vida_on_board.text = str(card_objective.vida)

			enabling_cards()

			card.has_attacked = true
			boton_pasar_turno.set_disabled(false)
			boton_pausa.set_disabled(false)
			collision.disabled = false
			puntero.hide()
			next_state = on_board_state
		else:
			enabling_cards()
			
			boton_pasar_turno.set_disabled(false)
			boton_pausa.set_disabled(false)
			collision.disabled = false
			puntero.hide()
			next_state = on_board_state
	
	elif event.is_action_released("LMB") and collider == null:
		enabling_cards()

		boton_pasar_turno.set_disabled(false)
		boton_pausa.set_disabled(false)
		collision.disabled = false
		puntero.hide()
		next_state = on_board_state

func disabling_cards():
	for i in mano.get_children():
		i.disabled_card = true
	for i in campo_oponente.get_children():
		i.disabled_card = false

func enabling_cards():
	for i in mano.get_children():
		i.disabled_card = false
	for i in campo_oponente.get_children():
		i.disabled_card = true

func _on_carta_ui_mouse_entered():
	on_card = true

func _on_carta_ui_mouse_exited():
	on_card = false
