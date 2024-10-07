extends Area2D
@export var n_shape:CollisionShape2D
@export var s_shape:CollisionShape2D
@export var e_shape : CollisionShape2D
@export var w_shape : CollisionShape2D
@export var picking_spot:Node2D

var all_shapes:Array
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			all_shapes.append(child)
	TinyInventoryPrototypeGlobal.item_pickup.connect(picked_up)
func _process(delta: float) -> void:
	if Input.is_action_pressed("movement_action"):
		if Input.is_action_pressed("ui_up"):
			for shape in all_shapes:
				shape.disabled = true
			n_shape.disabled = false
		if Input.is_action_pressed("ui_down"):
			for shape in all_shapes:
				shape.disabled = true
			s_shape.disabled = false
		if Input.is_action_pressed("ui_left"):
			for shape in all_shapes:
				shape.disabled = true
			w_shape.disabled = false
		if Input.is_action_pressed("ui_right"):
			for shape in all_shapes:
				shape.disabled = true
			e_shape.disabled = false


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
	
func picked_up(item:PackedScene):
	var picking = item.instantiate()
	picking_spot.add_child(picking)
	picking.global_transform = picking_spot.global_transform

	
