extends Node

class_name Card

var card_name : String
var card_type : String
var card_cost : int

func _init(c_name, c_type, c_cost):
	card_name = c_name
	card_type = c_type
	card_cost = c_cost


func get_card_name():
	return card_name
	
func get_card_type():
	return card_type
	
func get_card_cost():
	return card_cost
