extends Control

class_name CardUI

signal reparent_requested(which_card_ui : CardUI)

const CARD_DELAY_SPEED = 12.0

@onready var state_machine : CardStateMachine = $CardStateMachine

var card_name : String
var card_type : String
var card_cost : int

func _process(delta):
	# Escalar la carta segun el estado
	if state_machine.current_state.name == "enteredState":
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	elif state_machine.current_state.name == "idleState" or state_machine.current_state.name == "draggedState":
		scale = scale.lerp(Vector2(1, 1), delta*30)

func get_card_name():
	return card_name
	
func get_card_type():
	return card_type
	
func get_card_cost():
	return card_cost
