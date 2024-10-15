extends TextureButton
var on_focus:bool

func _input(event: InputEvent) -> void:
	if on_focus:
		if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left"):
			button_pressed = !button_pressed
			toggled.emit(button_pressed)
		
func _on_focus_entered() -> void:
	on_focus = true


func _on_visibility_changed() -> void:
	grab_focus()


func _on_focus_exited() -> void:
	on_focus = false # Replace with function body.
