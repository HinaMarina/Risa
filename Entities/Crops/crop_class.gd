class_name Crop extends Node2D

#Self basic info
const species : String = ""
@export var Sprite:Sprite2D
var current_age:int = 0
var crop_age:int = 0
@export var age_limit:int
@export var nutrient_bond_number:int
var is_giver:bool = false
var is_watered:bool = false
var is_harvestable:bool = false
signal crop_aged(species:String,crop_age:int)


#next stage info
@export var next_development_stage : PackedScene
@export var next_stage_age_limit:int
@export var normal_range:Vector2i
@export var nourished_range:Vector2i
@onready var randomizer : age_limit_sorter


func _ready() -> void:
	CalendarManager.day_updated.connect(age_developer)
	for child in get_children():
		if child is age_limit_sorter:
			randomizer = child	

func age_developer():
	current_age += 1
	crop_age += 1
	if current_age >= age_limit && next_development_stage != null:
		var next_stage = next_development_stage.instantiate()
		var parent = get_parent()
		parent.add_child(next_stage)
		next_stage.global_transform = self.global_transform
		
		next_stage.age_limit = next_stage_age_limit
		next_stage.nutrient_bond_number = nutrient_bond_number
		next_stage.crop_age = crop_age
		queue_free()
	
	crop_aged.emit()
	
func giving_bonds(): ##############UNFINISHED
	if is_giver:
		pass
