class_name Crop extends Node2D

#Self basic info
const species : String = ""
@export var Sprite:Sprite2D
var current_age:int = 0
var crop_age:int = 0
var age_limit:int
var nutrient_bond_number:int
var is_giver:bool = false
var is_watered:bool = false
var is_harvestable:bool = false
signal crop_aged(species:String,crop_age:int)


#next stage info
@export var next_development_stage : PackedScene
var next_stage_age_limit:int
var normal_range:Range
var nourished_range:Range
@onready var randomizer : age_limit_sorter

func ready():
	CalendarManager.day_updated.connect(age_developer)
	
	for child in get_children():
		if child is age_limit_sorter:
			randomizer = child

func age_developer():
	if current_age >= age_limit:
		crop_aged.emit(species,crop_age)
		var parent = get_parent()
		var next_stage = next_development_stage.instantiate()
		if next_stage is Crop:
			parent.add_child(next_stage)
			
			if randomizer != null:
				await randomizer.age_limited_sorted
						
			next_stage.age_limit = next_stage_age_limit
			next_stage.current_age = 0
			next_stage.nutrient_bond_number = nutrient_bond_number
			next_stage.global_transform = self.global_transform
			next_stage.crop_age = crop_age
			next_stage.normal_range = normal_range
			next_stage.nourished_range = nourished_range
			
		else:
			print(species + " " + name + "next_stage is not a crop") #error message
		self.queue_free()
	else:
		current_age += 1
		crop_age += 1

func giving_bonds():
	if is_giver:
		pass
