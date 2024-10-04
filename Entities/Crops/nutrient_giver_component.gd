class_name nutrient_giver extends Node


@onready var target = get_parent()
var disposable_bonds:int

func _ready() -> void:
	if target is Crop:
		disposable_bonds = target.nutrient_bond_number
		target.is_giver = true
	else:
		queue_free()

func on_add_bonds():
	disposable_bonds -= 1

func on_removing_bonds():
	disposable_bonds += 1
