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


func _input(event: InputEvent) -> void:
	if picking_spot.get_child_count()>0:
		enable_store = true
	else:
		enable_store = false
	if Input.is_action_just_pressed("Harvest") && enable_store:
		TinyInventoryPrototypeGlobal.store_item(item_to_store)
		picking_spot.get_child(0).queue_free()
		enable_store = false
		
func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			all_shapes.append(child)
	TinyInventoryPrototypeGlobal.item_pickup.connect(picked_up)
func _process(delta: float) -> void:
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


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
	
func picked_up(item:PackedScene):
	var picking = item.instantiate()
	item_to_store = item
	picking_spot.add_child(picking)
	picking.global_transform = picking_spot.global_transform
