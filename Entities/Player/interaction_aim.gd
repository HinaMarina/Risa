extends Area2D
@export var n_shape:CollisionShape2D
@export var s_shape:CollisionShape2D
@export var e_shape : CollisionShape2D
@export var w_shape : CollisionShape2D
@export var picking_spot:Node2D
var item_to_store : PackedScene

var enable_store:bool

var all_shapes:Array
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			all_shapes.append(child)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("movement_action"):
		if Input.is_action_pressed("ui_up"):
			for shape in all_shapes:
				if shape == n_shape:
					shape.disabled = false
				else:
					shape.disabled = true
		if Input.is_action_pressed("ui_down"):
			for shape in all_shapes:
				if shape == s_shape:
					shape.disabled = false
				else:
					shape.disabled = true
		if Input.is_action_pressed("ui_left"):
			for shape in all_shapes:
				if shape == w_shape:
					shape.disabled = false
				else:
					shape.disabled = true
		if Input.is_action_pressed("ui_right"):
			for shape in all_shapes:
				if shape == e_shape:
					shape.disabled = false
				else:
					shape.disabled = true


func _on_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.
	
