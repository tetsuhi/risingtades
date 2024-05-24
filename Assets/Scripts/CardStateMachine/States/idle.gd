extends State

class_name IdleState

@export var mouse_entered_state : State

func on_enter():
	if not card.is_node_ready():
		await card.ready
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass


func _on_carta_ui_mouse_entered():
	next_state = mouse_entered_state
