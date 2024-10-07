class_name Crop extends Node2D

@export var Species : String
@export var Sprite: Sprite2D
@export var next_stage:PackedScene
signal crop_grew

var age : int = 0
var plant_growing_age: int
@export var nutrients_needed : int
var is_watered:bool = true

func _ready() -> void:
	CalendarManager.day_updated.connect(update_age)
	
	for child in get_children():
		if child is Sprite2D && !(Sprite != null):
			Sprite = child	
			
func  update_age():
	if is_watered:
		age += 1
		
func grow():
	var growing = next_stage.instantiate()
	
	if growing is Plant:
		growing.age_to_grow = plant_growing_age
		
	growing.age = age
	growing.nutrients_needed = nutrients_needed
	var parent = get_parent()
	parent.add_child(growing)
	growing.global_transform = global_transform
	crop_grew.emit()
	self.queue_free()
