extends Node

@onready var number_of_harvested : int = 0
signal item_pickup(item)

func on_picking_item(item:PackedScene):
	item_pickup.emit(item)
