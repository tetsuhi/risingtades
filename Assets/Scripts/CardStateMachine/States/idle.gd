extends State

class_name IdleState

@export var mouse_entered_state : State
@export var dragged_state : State

var on_card : bool = false;

func on_enter():
	if not card.is_node_ready():
		await card.ready
	card.reparent_requested.emit(card)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		next_state = dragged_state
	

func _on_carta_ui_mouse_entered():
	on_card = true

func _on_carta_ui_mouse_exited():
	on_card = false
