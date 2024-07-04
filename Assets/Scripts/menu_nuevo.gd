extends Control

@onready var inicio = $inicio
@onready var menu = $menu
@onready var opciones = $opciones
@onready var confirmar_mazo = $confirmar_mazo
@onready var coleccion = $coleccion
@onready var confirmar_mazo_coleccion = $confirmar_mazo_coleccion
@onready var mazo_descripcion_confirmar = $confirmar_mazo/Panel/mazo_descripcion_confirmar
@onready var mazo_descripcion_coleccion = $confirmar_mazo_coleccion/Panel/mazo_descripcion_coleccion
@onready var personaliza = $personaliza
@onready var baraja_seleccionada = $personaliza/baraja_seleccionada


func _ready():
	pass


#*********************************************************
#menu principal
#*********************************************************

func _on_boton_jugar_pressed():
	if DeckBuild.baraja_seleccionada == 0:
		if DeckBuild.nombre_cartas1.size() != 0:
			mazo_descripcion_confirmar.text = "Tu mazo seleccionado (1) contiene " + str(DeckBuild.baraja_jugador1.size()) + " cartas."
			for i in DeckBuild.nombre_cartas1.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas1[i]) + "x " + DeckBuild.nombre_cartas1[i]
		else:
			mazo_descripcion_confirmar.text = "No tienes cartas en el mazo"
	elif DeckBuild.baraja_seleccionada == 1:
		if DeckBuild.nombre_cartas2.size() != 0:
			mazo_descripcion_confirmar.text = "Tu mazo seleccionado (2) contiene " + str(DeckBuild.baraja_jugador2.size()) + " cartas."
			for i in DeckBuild.nombre_cartas2.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas2[i]) + "x " + DeckBuild.nombre_cartas2[i]
		else:
			mazo_descripcion_confirmar.text = "No tienes cartas en el mazo"
	menu_transition(menu, confirmar_mazo)

func _on_boton_opciones_pressed():
	menu_transition(menu, opciones)

func _on_boton_coleccion_pressed():
	menu_transition(menu, coleccion)

func _on_boton_salir_pressed():
	get_tree().quit()


#*********************************************************
#opciones menu
#*********************************************************

func _on_volver_button_pressed():
	menu_transition(opciones, menu)

func _on_screen_mode_item_selected(index):

	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)


#*********************************************************
#coleccion
#*********************************************************
func _on_boton_volver_coleccion_pressed():
	menu_transition(coleccion, menu)

func _on_boton_editar_mazo_pressed():
	if DeckBuild.baraja_seleccionada == 0: 
		baraja_seleccionada.text = "Editando baraja 1"
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador1
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas1
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas1
	else:
		baraja_seleccionada.text = "Editando baraja 2"
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador2
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas2
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas2
	menu_transition(coleccion, personaliza)


#*********************************************************
#personaliza
#*********************************************************

func _on_boton_guardar_cambios_pressed():
	print(DeckBuild.nombre_temp)
	if DeckBuild.baraja_seleccionada == 0:
		DeckBuild.baraja_jugador1 = DeckBuild.baraja_temp
		DeckBuild.cantidad_cartas1 = DeckBuild.cantidad_temp
		DeckBuild.nombre_cartas1 = DeckBuild.nombre_temp
		if DeckBuild.nombre_cartas1.size() != 0:
			print("tengo cartas")
			mazo_descripcion_coleccion.text = "Tu mazo seleccionado (1) contiene " + str(DeckBuild.baraja_jugador1.size()) + " cartas."
			for i in DeckBuild.nombre_cartas1.size():
				mazo_descripcion_coleccion.text += "\n" + str(DeckBuild.cantidad_cartas1[i]) + "x " + DeckBuild.nombre_cartas1[i]
		else:
			mazo_descripcion_coleccion.text = "No tienes cartas en el mazo"
	elif DeckBuild.baraja_seleccionada == 1:
		DeckBuild.baraja_jugador2 = DeckBuild.baraja_temp
		DeckBuild.cantidad_cartas2 = DeckBuild.cantidad_temp
		DeckBuild.nombre_cartas2 = DeckBuild.nombre_temp
		if DeckBuild.nombre_cartas2.size() != 0:
			mazo_descripcion_coleccion.text = "Tu mazo seleccionado (2) contiene " + str(DeckBuild.baraja_jugador2.size()) + " cartas."
			for i in DeckBuild.nombre_cartas2.size():
				mazo_descripcion_coleccion.text += "\n" + str(DeckBuild.cantidad_cartas2[i]) + "x " + DeckBuild.nombre_cartas2[i]
		else:
			mazo_descripcion_coleccion.text = "No tienes cartas en el mazo"
	confirmar_mazo_coleccion.show()

func _on_boton_volver_personaliza_pressed():
	DeckBuild.baraja_temp = []
	DeckBuild.cantidad_temp = []
	DeckBuild.nombre_temp = []
	menu_transition(personaliza, coleccion)

func _on_baraja_seleccion_item_selected(index):
	if index == 0:
		baraja_seleccionada.text = "Editando: baraja 1"
		DeckBuild.baraja_seleccionada = 0
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador1
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas1
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas1
	else:
		baraja_seleccionada.text = "Editando: baraja 2"
		DeckBuild.baraja_seleccionada = 1
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador2
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas2
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas2


#*********************************************************
#confirmar mazo menu
#*********************************************************

func _on_boton_proceder_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/mesa_juego.tscn")

func _on_boton_atras_pressed():
	menu_transition(confirmar_mazo, menu)

func _on_boton_seleccionar_mazo_1_pressed():
	DeckBuild.baraja_seleccionada = 0
	print(DeckBuild.baraja_jugador1)
	if DeckBuild.nombre_cartas1.size() != 0:
		mazo_descripcion_confirmar.text = "Tu mazo seleccionado (1) contiene " + str(DeckBuild.baraja_jugador1.size()) + " cartas."
		for i in DeckBuild.nombre_cartas1.size():
			mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas1[i]) + "x " + DeckBuild.nombre_cartas1[i]
	else:
		mazo_descripcion_confirmar.text = "No tienes cartas en el mazo"


func _on_boton_seleccionar_mazo_2_pressed():
	DeckBuild.baraja_seleccionada = 1
	print(DeckBuild.baraja_jugador2)
	if DeckBuild.nombre_cartas2.size() != 0:
			mazo_descripcion_confirmar.text = "Tu mazo seleccionado (2) contiene " + str(DeckBuild.baraja_jugador2.size()) + " cartas."
			for i in DeckBuild.nombre_cartas2.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas2[i]) + "x " + DeckBuild.nombre_cartas2[i]
	else:
		mazo_descripcion_confirmar.text = "No tienes cartas en el mazo"


#*********************************************************
#confirmar mazo coleccion
#*********************************************************

func _on_boton_guardar_mazo_pressed():
	if DeckBuild.baraja_seleccionada == 0:
		Save.data.baraja1.carta_cantidad = DeckBuild.cantidad_cartas1
		Save.data.baraja1.carta_nombre = DeckBuild.nombre_cartas1
		Save.data.baraja1.baraja_jugador = DeckBuild.baraja_jugador1
	elif DeckBuild.baraja_seleccionada == 1:
		Save.data.baraja2.carta_cantidad = DeckBuild.cantidad_cartas2
		Save.data.baraja2.carta_nombre = DeckBuild.nombre_cartas2
		Save.data.baraja2.baraja_jugador = DeckBuild.baraja_jugador2
	Save.save_game()
	DeckBuild.baraja_temp = []
	DeckBuild.cantidad_temp = []
	DeckBuild.nombre_temp = []
	confirmar_mazo_coleccion.hide()
	personaliza.hide()
	coleccion.show()

func _on_boton_atras_coleccion_pressed():
	confirmar_mazo_coleccion.hide()


func menu_transition(old, new):
	old.hide()
	new.show()
