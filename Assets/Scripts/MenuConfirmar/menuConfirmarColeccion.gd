extends Control

@onready var mazo_descripcion = $Panel/mazo_descripcion

func _ready():
	var cantidad = []
	var tipo = []
	for i in DeckBuild.barajaJugador.size():
		var nombre_posicion = tipo.find(DeckBuild.barajaJugador[i].card_name)
		if nombre_posicion == -1:
			tipo.append(DeckBuild.barajaJugador[i].card_name)
			nombre_posicion = tipo.size() - 1
			cantidad.append(0)
			cantidad[nombre_posicion] += 1
		else:
			cantidad[nombre_posicion] += 1

	mazo_descripcion.text = "Tu mazo contiene " + str(DeckBuild.barajaJugador.size()) + " cartas. Esta es la distribución:"
	for i in tipo.size():
		mazo_descripcion.text += "\n" + str(cantidad[i]) + "x " + tipo[i]

func _on_boton_confirmar_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_principal.tscn")

func _on_boton_cancelar_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/menus/menu_coleccion.tscn")
