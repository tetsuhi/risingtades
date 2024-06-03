extends Control

@onready var menu_confirmar = preload("res://Assets/Scenes/menus/menu_confirmar_jugar.tscn")
@onready var canvas_layer = get_node("CanvasLayer")

func _on_boton_jugar_pressed():
	var confirm = menu_confirmar.instantiate()
	canvas_layer.add_child(confirm)

func _on_boton_opciones_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_opciones.tscn")

func _on_boton_coleccion_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_coleccion.tscn")

func _on_boton_salir_pressed():
	get_tree().quit()
