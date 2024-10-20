class_name nutrient_giver extends Node2D


@onready var target = get_parent()
@export var area2d : Area2D
var disposable_bonds:int
signal disposable_bonds_updated (current_number : int)

func _ready() -> void:
	disposable_bonds_updated.connect(on_disposible_bonds_updated)
	
	if target is Crop:
		disposable_bonds = 4
	else:
		queue_free()

func on_disposible_bonds_updated():
	pass
	
func _on_area_2d_area_entered(_area: Area2D) -> void:
	if disposable_bonds > 0:
		disposable_bonds -= 1
		disposable_bonds_updated.emit()
		
func _on_area_2d_area_exited(_area: Area2D) -> void:
	if disposable_bonds < 4:
		disposable_bonds += 1
		disposable_bonds_updated.emit()
