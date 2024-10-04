class_name nutrient_receiver extends Node

@onready var target = self.get_parent
var current_bonds:int = 0

func _ready() -> void:
	if target is not Crop:
		queue_free()

func on_bonds_update(new_bonds):
	current_bonds = new_bonds
	if current_bonds >= target.nutrient_bond_number:
		target.nutrient_bond_number = 0
		queue_free()
