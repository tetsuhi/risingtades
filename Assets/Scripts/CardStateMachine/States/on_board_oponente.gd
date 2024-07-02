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

#func _on_area_2d_input_event(viewport, event, shape_idx):
	#if event.is_action_pressed("LMB"):
		#print("me han clickado jeje")

