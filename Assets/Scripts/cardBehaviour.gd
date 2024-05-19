extends Control

const CARD_DELAY_SPEED = 12.0

@onready var state_machine : CardStateMachine = $CardStateMachine

var isClicked: bool = false
var lastPosition:= Vector2(0.0, 0.0)

func _process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	if Input.is_action_pressed("LMB"):
		lastPosition = position
		if isClicked or mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
			isClicked = true
			position = position.lerp(mousePos - size/2, delta * CARD_DELAY_SPEED)
	
	if Input.is_action_just_released("LMB") and isClicked:
		isClicked = false
	
	#if isClicked and Input.is_action_pressed("RMB"):
		#position = lastPosition
		#isClicked = false 
		
	#if not isClicked and manoNodo != null:
	#	global_position = global_position.lerp(Vector2(manoNodo.position.x, manoNodo.position.y - size.y/2), delta * CARD_DELAY_SPEED)

	if not isClicked and mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)
