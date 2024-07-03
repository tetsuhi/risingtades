extends State

class_name IdleStateOponente

@export var dragged_state : State
#@export var on_board_state : State

var on_card : bool = false;

func on_enter():
	if not card.is_node_ready():
		await card.ready
	
	var mano_oponente := get_tree().get_first_node_in_group("hand_oponente")
	if mano_oponente:
		card.reparent(mano_oponente)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card and not card.disabled_card:
		next_state = dragged_state

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
