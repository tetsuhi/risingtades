extends Control

@onready var menu = $menu
@onready var opciones = $opciones
@onready var confirmar_mazo = $confirmar_mazo
@onready var coleccion = $coleccion
@onready var confirmar_mazo_coleccion = $confirmar_mazo_coleccion
@onready var mazo_descripcion_confirmar = $confirmar_mazo/Panel/mazo_descripcion_confirmar
@onready var mazo_descripcion_coleccion = $confirmar_mazo_coleccion/Panel/mazo_descripcion_coleccion
@onready var personaliza = $personaliza
@onready var menu_info_mazo = $menu_info_mazo


@onready var cardData = preload("res://Assets/Scripts/cardDataBase.gd")
@onready var carta_ui = preload("res://Assets/Scenes/cartaPreview.tscn")

func _ready() -> void:
	if SceneTransition.empezado:
		$AnimationPlayer.play("pulsar_empezar")
		$AnimationPlayer.seek(3, false)
		
	$background_animator.play("background_loop")

func _input(event: InputEvent) -> void:
	#Pulsa cualquier botón para empezar
	if Input.is_anything_pressed() and not SceneTransition.empezado:
		if event.pressed:
			#get_tree().change_scene_to_file("res://Assets/Scenes/menuNuevo.tscn")
			$AnimationPlayer.play("pulsar_empezar")
			SceneTransition.empezado = true
			await $AnimationPlayer.animation_finished

#*********************************************************
#menu principal
#*********************************************************

func _on_boton_jugar_pressed():
	if DeckBuild.baraja_seleccionada == 0:
		if DeckBuild.nombre_cartas1.size() != 0:
			mazo_descripcion_confirmar.text = "Player 1's deck has " + str(DeckBuild.baraja_jugador1.size()) + " cards."
			for i in DeckBuild.nombre_cartas1.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas1[i]) + "x " + DeckBuild.nombre_cartas1[i]
		else:
			mazo_descripcion_confirmar.text = "Player 1 has no cards in their deck."
	elif DeckBuild.baraja_seleccionada == 1:
		if DeckBuild.nombre_cartas2.size() != 0:
			mazo_descripcion_confirmar.text = "Player 2's deck has " + str(DeckBuild.baraja_jugador2.size()) + " cards."
			for i in DeckBuild.nombre_cartas2.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas2[i]) + "x " + DeckBuild.nombre_cartas2[i]
		else:
			mazo_descripcion_confirmar.text = "Player 2 has no cards in their deck."
	$AnimationPlayer.play("ir_confirmar_mazo_jugar")

func _on_boton_opciones_pressed():
	$AnimationPlayer.play("ir_opciones")

func _on_boton_coleccion_pressed():
	$AnimationPlayer.play("ir_baraja")

func _on_boton_salir_pressed():
	get_tree().quit()

func _on_itch_button_pressed() -> void:
	OS.shell_open("https://tetsuhi.itch.io/")

func _on_tutorial_area_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB"):
		$AnimationPlayer.play("ir_tutorial")


#*********************************************************
#opciones menu
#*********************************************************

func _on_volver_button_pressed():
	$AnimationPlayer.play_backwards("ir_opciones")

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
	$AnimationPlayer.play_backwards("ir_baraja")

func _on_boton_editar_mazo_pressed():
	if DeckBuild.baraja_seleccionada == 0: 
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador1
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas1
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas1
	else:
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador2
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas2
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas2
	$AnimationPlayer.play("ir_personaliza")


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
	$AnimationPlayer.play("ir_confimar_mazo_personalizar")

func _on_boton_volver_personaliza_pressed():
	DeckBuild.baraja_temp = []
	DeckBuild.cantidad_temp = []
	DeckBuild.nombre_temp = []
	$AnimationPlayer.play_backwards("ir_personaliza")

func _on_baraja_seleccion_item_selected(index):
	if index == 0:
		DeckBuild.baraja_seleccionada = 0
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador1
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas1
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas1
	else:
		DeckBuild.baraja_seleccionada = 1
		DeckBuild.baraja_temp = DeckBuild.baraja_jugador2
		DeckBuild.nombre_temp = DeckBuild.nombre_cartas2
		DeckBuild.cantidad_temp = DeckBuild.cantidad_cartas2

func _on_boton_info_mazo_pressed():
	mostrar_cartas_baraja()
	$AnimationPlayer.play("ir_menu_info_mazo")


#*********************************************************
#confirmar mazo menu
#*********************************************************

func _on_boton_proceder_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Scenes/mesa_juego.tscn")

func _on_boton_atras_pressed():
	$AnimationPlayer.play_backwards("ir_confirmar_mazo_jugar")

func _on_boton_seleccionar_mazo_1_pressed():
	#DeckBuild.baraja_seleccionada = 0
	if DeckBuild.nombre_cartas1.size() != 0:
		mazo_descripcion_confirmar.text = "Player 1's deck has " + str(DeckBuild.baraja_jugador1.size()) + " cards."
		for i in DeckBuild.nombre_cartas1.size():
			mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas1[i]) + "x " + DeckBuild.nombre_cartas1[i]
	else:
		mazo_descripcion_confirmar.text = "Player 1 has no cards in their deck."


func _on_boton_seleccionar_mazo_2_pressed():
	#DeckBuild.baraja_seleccionada = 1
	if DeckBuild.nombre_cartas2.size() != 0:
			mazo_descripcion_confirmar.text = "Player 2's deck has " + str(DeckBuild.baraja_jugador2.size()) + " cards."
			for i in DeckBuild.nombre_cartas2.size():
				mazo_descripcion_confirmar.text += "\n" + str(DeckBuild.cantidad_cartas2[i]) + "x " + DeckBuild.nombre_cartas2[i]
	else:
		mazo_descripcion_confirmar.text = "Player 2 has no cards in their deck."


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
	$AnimationPlayer.play_backwards("ir_confimar_mazo_personalizar")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards("ir_personaliza")

func _on_boton_atras_coleccion_pressed():
	$AnimationPlayer.play_backwards("ir_confimar_mazo_personalizar")


#*********************************************************
#menu info mazo
#*********************************************************

func _on_boton_volver_info_mazo_pressed():
	$AnimationPlayer.play_backwards("ir_menu_info_mazo")
	await $AnimationPlayer.animation_finished
	limpiar_vista_baraja()


func mostrar_cartas_baraja():
	var container_info_mazo = $menu_info_mazo/Panel/ScrollContainer/container_info_mazo
	var nombre_cartas_mostrar = []
	for i in DeckBuild.baraja_temp.size():
		print(nombre_cartas_mostrar)
		var resourcePath = cardData.DATA[DeckBuild.baraja_temp[i]]
		var cardInfo = load(resourcePath)
		if nombre_cartas_mostrar.find(cardInfo.card_name) == -1:
			nombre_cartas_mostrar.append(cardInfo.card_name)
			var _card = cardInfo.duplicate()
			var nueva_carta = carta_ui.instantiate()
			nueva_carta.card_info = _card
			container_info_mazo.add_child(nueva_carta)
	for i in container_info_mazo.get_children():
		var index_name = DeckBuild.nombre_temp.find(i.card_info.card_name)
		i.cantidad.text = "x" + str(DeckBuild.cantidad_temp[index_name])

func limpiar_vista_baraja():
	var container_info_mazo = $menu_info_mazo/Panel/ScrollContainer/container_info_mazo
	for i in container_info_mazo.get_children():
		container_info_mazo.remove_child(i)


#*********************************************************
#tutorial
#*********************************************************

func _on_understand_button_pressed() -> void:
	$AnimationPlayer.play_backwards("ir_tutorial")
	await $AnimationPlayer.animation_finished


func menu_transition(old, new):
	old.hide()
	new.show()
