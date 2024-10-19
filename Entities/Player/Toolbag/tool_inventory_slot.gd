class_name Slot extends Control
@export var item:Node2D
signal slot_equip(item:Node,slot:Slot)
signal slot_info(item:Node,slot:Slot)
signal slot_off(item:Node,slot:Slot)
signal slot_swaped()
var item_saved:Node2D
var move_item:bool
@export var toggle_type:bool
var slotbutton:Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_children()
	self.child_entered_tree.connect(_on_child_entered_tree)
	self.child_exiting_tree.connect(_on_child_exiting_tree)
	
	if toggle_type and slotbutton!=null:
		slotbutton.toggled.connect(_on_button_toggled)
	elif slotbutton!= null:
		slotbutton.pressed.connect(_on_button_toggled.bind(true))
#func _process(delta: float) -> void:
	#print(name + str(position))

func set_children():
	for child in get_children():
		if child is Node2D:
			child.global_position = self.global_position + size/2
			item = child
		if child is Button:
			slotbutton = child
			slotbutton.toggle_mode = toggle_type

func swap_item(slot:Slot):
	save_item(item)
	if slot.item != null:
		slot.item.reparent(self)
	if item_saved!= null:
		item_saved.reparent(slot)
		item_saved = null		
	
	set_children()
	slot.set_children()


func _on_button_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#slot_equip.emit(item,self)
	#if toggled_on == false:
		#slot_off.emit(item,self)
	move_item = toggled_on

func equip(will_equip:bool):
	if will_equip:
		slot_equip.emit(item,self)
	else:
		slot_off.emit(item,self)
func save_item(item:Node2D):
	item_saved = item
	

func _on_button_focus_entered() -> void:
	slot_info.emit(item,self)
		


func _on_child_entered_tree(node: Node) -> void:
	if node is Node2D:
		item = node

func _on_child_exiting_tree(node: Node) -> void:
	if node == item:
		item = null
