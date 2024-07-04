extends State

class_name ActiveBoardState

var on_card : bool
var mouse_left_down : bool
@export var aim_State : State
@onready var turn_manager := get_tree().get_first_node_in_group("turn_manager")

func on_enter():
	var board := get_tree().get_first_node_in_group("board")
	if board:
		card.reparent(board)
	#card.card_on_board = true
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	
	if event.is_action_pressed("LMB") and on_card and not card.has_attacked and not card.disabled_card and turn_manager.juegaTurno == "jugador":
		next_state = aim_State

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
