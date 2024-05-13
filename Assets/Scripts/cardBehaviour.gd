class_name CartaUI
extends Control

const CARD_DELAY_SPEED = 12.0

var isClicked: bool = false
@onready var targets: Array[Node] = []
@onready var carta_textura = $cartaTextura
@onready var detector_colision = $detectorColision

func _process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	if Input.is_action_pressed("click"):
		if isClicked or mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
			isClicked = true
			position = position.lerp(mousePos - size/2, delta * CARD_DELAY_SPEED)
	
	if Input.is_action_just_released("click") and isClicked:
		isClicked = false
		
	#if not isClicked and manoNodo != null:
	#	global_position = global_position.lerp(Vector2(manoNodo.position.x, manoNodo.position.y - size.y/2), delta * CARD_DELAY_SPEED)

	if not isClicked and mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)


func _on_detector_colision_area_entered(area):
	pass # Replace with function body.


func _on_detector_colision_area_exited(area):
	pass # Replace with function body.
