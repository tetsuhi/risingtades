extends passive_creature

class_name effect_update_tide

@export_group("Card Effect")

func effect(card):
	card.marea += 1
	card.marea_on_board.text = str(card.marea)
