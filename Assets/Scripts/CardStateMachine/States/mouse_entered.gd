extends State

class_name EnteredState

@export var dragged_state : State
@export var idle_state : State

func on_enter():
	pass
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if(event.is_action_pressed("LMB")):
		#print(initial_position)
		next_state = dragged_state

func _on_carta_ui_mouse_exited():
	next_state = idle_state
