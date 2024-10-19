class_name Seed_Slot extends Slot

signal slot_is_full(item:Node,slot:Slot,left_quantity:int)
@warning_ignore("unused_signal")
signal slot_update(item:Node,quantity:int, slot:Slot)
var is_full:bool = false

var quantity_label:Label
var quantity:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func set_children():
	super()
	for child in get_children():
		if child is Label:
			quantity_label = child
			quantity_label.global_position = global_position + Vector2(0,6)
			quantity_label.text = str(quantity)
			if quantity <= 1:
				quantity_label.visible = false
			else:
				quantity_label.visible = true


func swap_item(slot:Slot):		
	save_item(item)
	var slot_item_name : String
	var my_item_name
	if slot.item != null:
		slot_item_name = slot.item.tool_name
		slot.item.reparent(self)
	if item_saved!= null:
		my_item_name = item_saved.tool_name
		item_saved.reparent(slot)
		item_saved = null		
	if slot_item_name == my_item_name:
		var oldquantity = quantity
		quantity = min(9,slot.quantity+self.quantity)
		slot.quantity = max(0,slot.quantity+oldquantity - 9)
		if slot.quantity <=0:
			slot.remove_child(slot.item)
			slot.item = null

		set_children()
		slot.set_children()
		return
		
	var slotoldquantity = slot.quantity
	slot.quantity = self.quantity
	self.quantity = slotoldquantity
	set_children()
	slot.set_children()
	
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
	
func _on_child_entered_tree(node: Node) -> void:
	super(node)

func _on_child_exiting_tree(node: Node) -> void:
	if node == item:
		item = null
