extends Node2D
@export var inventory_grid:GridContainer
@export var Canvas:CanvasLayer

func _ready() -> void:
	#TinyInventoryPrototypeGlobal.new_item_stored.connect(update_inventory)
	Canvas.visible = false

#func update_inventory(item,amount):
	#for child in inventory_grid.get_children():
			#child.queue_free()
	#for each_item in TinyInventoryPrototypeGlobal.stored_items:
		#var position = TinyInventoryPrototypeGlobal.stored_items.find(each_item)
		#var quantity = TinyInventoryPrototypeGlobal.item_numbers[position]
		#var control_node = Control.new()
		#var new_item = each_item.instantiate()
		#control_node.custom_minimum_size = Vector2(16,16)
		#control_node.add_child(new_item)
		#if quantity > 1:
			#var label = Label.new()
			#label.text = str(quantity)
			#control_node.add_child(label)
		#inventory_grid.add_child(control_node)

func Seed_inventory():
	pass

	

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("Menu"):
		Canvas.visible = !Canvas.visible
		get_tree().paused = !get_tree().paused

func toolbag():
	pass
