extends Node2D
@export var inventory_grid:GridContainer
@export var Canvas:CanvasLayer

func _ready() -> void:
	TinyInventoryPrototypeGlobal.new_item_stored.connect(add_item)
	Canvas.visible = false

func add_item(item:PackedScene,amount:int):
	var new_item = item.instantiate()
	var control_node = Control.new()
	if amount > 1:
		var position = TinyInventoryPrototypeGlobal.stored_items.bsearch(item)
		var control = inventory_grid.get_child(position)
		for child in control.get_children():
			if child is Label:
				child.queue_free()
		var amount_label = Label.new()
		amount_label.text = str(amount)
		control.add_child(amount_label)
		return
	control_node.custom_minimum_size = Vector2(16,16)
	control_node.add_child(new_item)
	inventory_grid.add_child(control_node)
	
		
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Menu"):
		print("aqui")
		Canvas.visible = !Canvas.visible
