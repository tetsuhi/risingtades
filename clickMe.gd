extends TextureRect


func _ready():
	print("Has robado una carta")

func _process(delta):
	if Input.is_action_pressed("click"):
		#print("Me están clickando")
		position = get_viewport().get_mouse_position()
