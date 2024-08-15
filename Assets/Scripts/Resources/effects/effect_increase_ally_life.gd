extends active_creature

@export_group("Card Effect")
@export var life_upgrade : int = 1

func effect(ally_creatures):
	for i in ally_creatures:
		i.vida += life_upgrade
		i.vida_on_board.text = str(i.vida)
