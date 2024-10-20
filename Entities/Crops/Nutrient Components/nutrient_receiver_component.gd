class_name nutrient_receiver extends Node2D

@onready var target = self.get_parent()
@export var area2d : Area2D
var current_bonds:int = 0
var required_bonds:int 
var is_nourished : bool = false
signal nourished (name:String)

func _ready() -> void:
	if target is Crop:
		required_bonds = target.nutrients_needed
	else:
		queue_free()	

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if current_bonds < required_bonds - 1:
		current_bonds += 1
	else:
		is_nourished = true
		target.nutrients_needed = 0
		nourished.emit()
		print(str(target) + " is nourished")
		queue_free()

func _on_area_2d_area_exited(_area: Area2D) -> void:
	if is_nourished == false:
		current_bonds -= 1
