extends Control

@onready var inicio = $inicio
@onready var menu = $menu
@onready var opciones = $opciones
@onready var confirmar_mazo = $confirmar_mazo
@onready var coleccion = $coleccion
@onready var confirmar_mazo_coleccion = $confirmar_mazo_coleccion
@onready var mazo_descripcion_confirmar = $confirmar_mazo/Panel/mazo_descripcion_confirmar
@onready var mazo_descripcion_coleccion = $confirmar_mazo_coleccion/Panel/mazo_descripcion_coleccion


#menu inicio

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton and inicio.visible:
		if event.is_released():
			menu_transition(inicio, menu)


#menu principal

func _on_boton_jugar_pressed():
	if DeckBuild.nombre_cartas.size() != 0:
		mazo_descripcion_confirmar.text = "Tu mazo contiene " + str(DeckBuild.barajaJugador.size()) + " cartas."
		for i in DeckBuild.nombre_cartas.size():
			mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas[i]) + "x " + DeckBuild.nombre_cartas[i]
	else:
		mazo_descripcion_confirmar.text = "No tienes cartas en el mazo"
	menu_transition(menu, confirmar_mazo)

func _on_boton_opciones_pressed():
	menu_transition(menu, opciones)

func _on_boton_coleccion_pressed():
	menu_transition(menu, coleccion)

func _on_boton_salir_pressed():
	get_tree().quit()


#opciones menu

func _on_volver_button_pressed():
	menu_transition(opciones, menu)

func _on_screen_mode_item_selected(index):

	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)


#coleccion

func _on_boton_volver_coleccion_pressed():
	if DeckBuild.nombre_cartas.size() != 0:
		mazo_descripcion_coleccion.text = "Tu mazo contiene " + str(DeckBuild.barajaJugador.size()) + " cartas."
		for i in DeckBuild.nombre_cartas.size():
			mazo_descripcion_coleccion.text += "\n" + str(DeckBuild.cantidad_cartas[i]) + "x " + DeckBuild.nombre_cartas[i]
	else:
		mazo_descripcion_coleccion.text = "No tienes cartas en el mazo"
	confirmar_mazo_coleccion.show()


#confirmar mazo menu

func _on_boton_proceder_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/mesa_juego.tscn")

func _on_boton_atras_pressed():
	menu_transition(confirmar_mazo, menu)

func _on_boton_coleccion_confirmar_pressed():
	menu_transition(confirmar_mazo, coleccion)


#confirmar mazo coleccion

func _on_boton_guardar_mazo_pressed():
	Save.data["carta_cantidad"] = DeckBuild.cantidad_cartas
	Save.data["carta_nombre"] = DeckBuild.nombre_cartas
	Save.data["baraja_jugador"] = DeckBuild.barajaJugador
	Save.save_game()
	confirmar_mazo_coleccion.hide()
	coleccion.hide()
	menu.show()

func _on_boton_atras_coleccion_pressed():
	confirmar_mazo_coleccion.hide()


func menu_transition(old, new):
	old.hide()
	new.show()
