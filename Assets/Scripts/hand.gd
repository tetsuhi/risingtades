class_name hand
extends HBoxContainer

func _ready():
	for child in get_children():
			var card_ui := child as CardUI
			card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self)

func reparent_card(child: CardUI):
	child.reparent(self)
