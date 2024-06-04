extends Control

@onready var mazo_descripcion = $Panel/mazo_descripcion

func _ready():
	
	mazo_descripcion.text = "Total de cartas: " + str(DeckBuild.barajaJugador.size())
	for i in DeckBuild.tipo_jugador.size():
		mazo_descripcion.text += "\n" + str(DeckBuild.cantidad_jugador[i]) + "x " + DeckBuild.tipo_jugador[i]

func _on_boton_proceder_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/mesa_juego.tscn")

func _on_boton_atras_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")

func _on_boton_coleccion_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_coleccion.tscn")
