extends State

class_name AimState
@export var on_board_state : State
@onready var collision := get_tree().get_first_node_in_group("collision_jugador")
var on_card : bool
@onready var puntero := get_tree().get_first_node_in_group("puntero")
@onready var mouse_pos := get_tree().get_first_node_in_group("mouse_pos")
@onready var campo := get_tree().get_first_node_in_group("board")
@onready var mano := get_tree().get_first_node_in_group("hand")
@onready var manoOpo := get_tree().get_first_node_in_group("hand_oponente")
@onready var raycast := get_tree().get_first_node_in_group("raycast")

var card_pos : Vector2

func on_enter():
	collision.disabled = true
	puntero.show()
	for i in mano.get_children():
		i.disabled_card = true
	for i in manoOpo.get_children():
		i.disabled_card = true

func state_process(delta):
	if puntero.points.size() == 0:
		puntero.add_point(Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2))
		puntero.add_point(mouse_pos.get_global_mouse_position())
	puntero.points[0] = Vector2(card.get_global_rect().position.x + card.size.x/2, card.get_global_rect().position.y + card.size.y/2)
	puntero.points[1] = mouse_pos.get_global_mouse_position()

func state_input(event : InputEvent):
	if event.is_action_pressed("RMB"):
		puntero.hide()
		collision.disabled = false
		for i in mano.get_children():
			i.disabled_card = false
		for i in manoOpo.get_children():
			i.disabled_card = false
		next_state = on_board_state

	if event.is_action_pressed("LMB"):
		var collider = raycast.get_collider()
		print(collider)
		if collider == null:
			collision.disabled = false
			puntero.hide()
			next_state = on_board_state
		#card.has_attacked = true
		#puntero.hide()
		#collision.disabled = false
		#next_state = on_board_state
		
func _on_carta_ui_mouse_entered():
	on_card = true

func _on_carta_ui_mouse_exited():
	on_card = false
