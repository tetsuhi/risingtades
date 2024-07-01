extends State

class_name BoardStateOponente

var on_card : bool

func on_enter():
	var board := get_tree().get_first_node_in_group("boardOponente")
	if board:
		card.reparent(board)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	#if event.is_action_pressed("LMB") and on_card:
		#card.queue_free()
	pass

func _on_carta_ui_oponente_mouse_entered():
	on_card = true;

func _on_carta_ui_oponente_mouse_exited():
	on_card = false
