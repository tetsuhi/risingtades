extends Control

@onready var mazo_descripcion = $Panel/mazo_descripcion

func _ready():

	mazo_descripcion.text = "Tu mazo contiene " + str(DeckBuild.barajaJugador.size()) + " cartas."
	for i in DeckBuild.nombre_cartas.size():
		mazo_descripcion.text += "\n" + str(DeckBuild.cantidad_cartas[i]) + "x " + DeckBuild.nombre_cartas[i]

func _on_boton_confirmar_pressed():
	#Save.data["carta_id"] = DeckBuild.id_jugador
	Save.data["carta_cantidad"] = DeckBuild.cantidad_cartas
	Save.data["carta_nombre"] = DeckBuild.nombre_cartas
	Save.data["baraja_jugador"] = DeckBuild.barajaJugador
	Save.save_game()
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")

func _on_boton_cancelar_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_coleccion.tscn")
