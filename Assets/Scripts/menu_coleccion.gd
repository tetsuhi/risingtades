extends Control

@onready var menu_confirmar = preload("res://Assets/Scenes/menus/menu_confirmar_coleccion.tscn")
@onready var canvas_layer = get_node("CanvasLayer")

func _on_boton_volver_pressed():
	var confirm = menu_confirmar.instantiate()
	canvas_layer.add_child(confirm)
	#DeckBuild.save()
