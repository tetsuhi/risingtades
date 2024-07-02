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
#@onready var ui_layer := get_tree().get_first_node_in_group("ui_layer")

var card_pos : Vector2
var on_card : bool

func on_enter():
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

func state_input(event : InputEvent):
	if event.is_action_pressed("RMB"):
		puntero.hide()
		collision.disabled = false
		for i in mano.get_children():
			i.disabled_card = false
		for i in campo_oponente.get_children():
			i.disabled_card = true
		next_state = on_board_state

	if event.is_action_pressed("LMB"):
		var collider = raycast.get_collider()
		
		if collider != null:
			var card_objective = collider.get_owner()
			if not card_objective.disabled_card:
			
				print(card_objective.card_info.card_name)
				card_objective.queue_free()

				enabling_cards()

				card.has_attacked = true
				collision.disabled = false
				puntero.hide()
				next_state = on_board_state
		else:
			enabling_cards()

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

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
