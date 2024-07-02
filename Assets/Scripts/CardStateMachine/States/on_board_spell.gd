extends State

class_name SpellBoardState

@export var aim_State : State

var on_card : bool

func on_enter():
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	card.position = Vector2(get_viewport().size.x/2 - card.size.x/2, get_viewport().size.y/2 - card.size.y/2)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		next_state = aim_State

func _on_detector_colision_mouse_entered():
	on_card = true

func _on_detector_colision_mouse_exited():
	on_card = false
