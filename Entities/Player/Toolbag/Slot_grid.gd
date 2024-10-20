extends GridContainer
var current_pressed : Button
var all_buttons:Array[Button]
var all_slots:Array[Slot]

func _ready() -> void:
	for child in get_children():
		if child is Slot:
			all_slots.append(child)
			for control_child in child.get_children():
				if control_child is Button:
					all_buttons.append(control_child)
	for button in all_buttons:
		if button.toggle_mode == true:
			button.toggled.connect(_on_button_toggled.bind(button))
		else:
			button.pressed.connect(_on_button_toggled.bind(true,button))
			
func _on_button_toggled(toggled_on: bool,button:Button) -> void:
	if toggled_on == true:
		var button_slot = button.get_parent() as Slot
		for each in all_slots:
			if each != button_slot and each.slotbutton.button_pressed == true and button.toggle_mode:
				await button_slot.swap_item(each)
				button.button_pressed = false
				each.slotbutton.button_pressed = false
			elif button_slot.item != null:
				if button_slot.item.tool_name == "Unequip":
					for slot in all_slots:
						slot.slot_off.emit(slot.item,slot)
						current_pressed = null
					return
		current_pressed = button
	
	else:
		if button == current_pressed:
			var slot = button.get_parent() as Slot
			slot.equip(true)
			current_pressed = null
