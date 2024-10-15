extends GridContainer
var current_toggled : Button
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
		if current_toggled != button:
			current_toggled = button
		for each_button in all_buttons:
			if each_button != current_toggled && each_button.button_pressed == true:
				each_button.button_pressed = false
