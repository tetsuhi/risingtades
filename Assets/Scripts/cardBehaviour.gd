extends Control

class_name CardUI

signal reparent_requested(which_card_ui : CardUI)

const CARD_DELAY_SPEED = 12.0

@onready var state_machine : CardStateMachine = $CardStateMachine

var card_name : String
var card_type : String
var card_cost : int
var on_card : bool

func _process(delta):
	
	if on_card and state_machine.current_state.name == "idleState":
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	elif not on_card:
		scale = scale.lerp(Vector2(1, 1), delta*30)
	
func get_card_name():
	return card_name
	
func get_card_type():
	return card_type
	
func get_card_cost():
	return card_cost


func _on_mouse_entered():
	on_card = true

func _on_mouse_exited():
	on_card = false
