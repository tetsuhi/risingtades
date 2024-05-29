extends Control

var card_name : String
var card_type : String
var card_cost : int
var on_card : bool

func _input(event : InputEvent):
	if event.is_action_pressed("LMB") and on_card:
		print(card_name)

func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
