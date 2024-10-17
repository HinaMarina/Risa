class_name Slot extends Control
var item:Node2D
signal slot_equip(item:Node,slot:Slot)
signal slot_info(item:Node,slot:Slot)
signal slot_off(item:Node,slot:Slot)

@export var toggle_type:bool
var slotbutton:Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			child.global_position = self.global_position + size/2
			item = child
		if child is Button:
			slotbutton = child
			slotbutton.toggle_mode = toggle_type
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
		
