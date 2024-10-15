class_name seedpack extends tool

@export var number_of_usages:int = 1
signal item_to_remove(seedpack:seedpack)
@export var seed_crop_scene : PackedScene
signal seed_to_plant (seed_crop_scene:PackedScene)

func on_seedpack_usage():
	if number_of_usages >=1:
		number_of_usages -=1
		seed_to_plant.emit(seed_crop_scene)
	if number_of_usages == 0:
		tool_equipped.emit(tool_name,false)
		item_to_remove.emit(self)
		queue_free()
