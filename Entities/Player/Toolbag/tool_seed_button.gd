extends TextureButton
var on_focus:bool

func _gui_input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
			var node = get_node(focus_neighbor_bottom) as Control
			node.grab_focus()
			accept_event()
	if (event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left")) && on_focus:
		button_pressed = !button_pressed
		toggled.emit(button_pressed)
		accept_event()
			
func _on_focus_entered() -> void:
	on_focus = true


func _on_visibility_changed() -> void:
	grab_focus()


func _on_focus_exited() -> void:
	on_focus = false # Replace with function body.
	
