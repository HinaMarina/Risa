class_name age_limit_sorter extends Node

@onready var target = get_parent()
signal age_limited_sorted(new_age_limit:int)


func _ready() -> void:
	if target is Crop:
		target.crop_aged.connect(on_crop_aged)
		
func on_crop_aged():
	if target is Crop:
		var min_value :int
		var max_value :int
		
		if target.nutrient_bond_number == 0:
			min_value = int(target.nourished_range.x)
			max_value = int(target.nourished_range.y)
		else:
			min_value = int(target.normal_range.x)
			max_value = int(target.normal_range.y)
		
		var new_age_limit = randi_range(min_value,max_value)
		target.next_stage_age_limit = new_age_limit
		
		age_limited_sorted.emit()
		self.queue_free()
