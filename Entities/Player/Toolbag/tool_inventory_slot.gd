class_name Slot extends Control
var item:Node2D
signal slot_equip(item:Node,slot:Slot)
signal slot_info(item:Node,slot:Slot)
signal slot_off(item:Node,slot:Slot)
signal slot_is_full(item:Node,slot:Slot,left_quantity:int)
signal slot_update(item:Node,quantity:int, slot:Slot)
var is_full:bool = false

@export var toggle_type:bool
var slotbutton:Button
var quantity_label:Label
var quantity:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			child.global_position = self.global_position + size/2
			item = child
		if child is Button:
			slotbutton = child
			slotbutton.toggle_mode = toggle_type
		if child is Label:
			quantity_label = child
			quantity_label.global_position = global_position + Vector2(0,6)
	if toggle_type and slotbutton!=null:
		slotbutton.toggled.connect(_on_button_toggled)
	elif slotbutton!= null:
		slotbutton.pressed.connect(_on_button_toggled.bind(true))
	



func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		slot_equip.emit(item,self)
	if toggled_on == false:
		slot_off.emit(item,self)



func _on_button_focus_entered() -> void:
	slot_info.emit(item,self)
		
func add_item(new_item:Node,new_quantity:int):
	if quantity < 9:
		if item == null:
			item = new_item as Node2D
			self.add_child(item)
			item.global_position = self.global_position + size/2
			quantity = new_quantity
			quantity_label.text = str(quantity)
			if quantity <= 1:
				quantity_label.visible = false
		else:
			quantity += new_quantity
			quantity_label.text = str(quantity)
			quantity_label.visible = true
			if quantity >= 9:
				slot_is_full.emit(item,self,quantity - 9)
				is_full = true
	else:
		slot_is_full.emit(new_item,self,new_quantity)
		
func remove_item(number_to_remove:int):
	if quantity >= number_to_remove && item != null:
		quantity -= number_to_remove
		quantity_label.text = str(quantity)
		is_full = false
		if quantity <= 0:
			self.remove_child(item)
			item = null
			quantity = 0
			
	if quantity > 1:
		quantity_label.visible = true
	else:
		quantity_label.visible = false
