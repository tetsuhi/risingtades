extends TextureRect

const CARD_DELAY_SPEED = 10.0

@export var manoNodo: Node
var isClicked: bool = false

func _process(delta):
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	if Input.is_action_pressed("click"):
		if isClicked or mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
			isClicked = true
			position = position.lerp(mousePos - size/2, delta * CARD_DELAY_SPEED)
	
	if Input.is_action_just_released("click") and isClicked:
		isClicked = false
		
	if not isClicked:
		global_position = global_position.lerp(Vector2(manoNodo.position.x, manoNodo.position.y - size.y/2), delta * CARD_DELAY_SPEED)

	if not isClicked and mousePos.x <= position.x + size.x and mousePos.y <= position.y + size.y and mousePos.x >= position.x and mousePos.y >= position.y:
		scale = scale.lerp(Vector2(1.2, 1.2), delta*30)
	else:
		scale = scale.lerp(Vector2(1, 1), delta*30)
