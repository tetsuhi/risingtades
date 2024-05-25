extends State

class_name BoardState

var on_card : bool

func on_enter():
	pass
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		card.queue_free()

func _on_carta_ui_mouse_entered():
	on_card = true;

func _on_carta_ui_mouse_exited():
	on_card = false
