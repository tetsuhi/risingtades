class_name Mano
extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		var carta_ui := child as CartaUI
		carta_ui.reparent_requested.connect(_on_carta_ui_reparent_requested)

func _on_carta_ui_reparent_requested(child: CartaUI) -> void:
	child.reparent(self)
