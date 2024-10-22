extends Node

@onready var number_of_harvested : int = 0
var stored_items : Array
var item_numbers : Array
signal item_pickup(item)
signal new_item_stored(item,amount)

func on_picking_item(item:PackedScene):
	item_pickup.emit(item)
	
func store_item(item):
	if stored_items.has(item):
		var position = stored_items.find(item)
		var current_number = item_numbers[position]
		item_numbers[position] = current_number + 1
		new_item_stored.emit(item,item_numbers[position])
		return
	
	stored_items.append(item)
	item_numbers.append(1)
	new_item_stored.emit(item,1)


	
