class_name Plant extends Crop

var age_to_grow : int
@export var regrowable : bool
@export var regrowth_number : int
@export var harvested_plant : PackedScene
@export var harvest_area2d: Area2D
signal is_being_harvested(fruit:PackedScene)
var next_step : float
var pacing : float
var harvestable : bool

func _ready() -> void:
	super()
	harvest_area2d.monitoring = false
	harvest_area2d.area_entered.connect(_on_area_2d_area_entered)
	harvest_area2d.area_exited.connect(_on_area_2d_area_exited)

	arrange_pacing()
	calculate_next_step()

func _input(event: InputEvent) -> void:
	if event.is_action("Harvest") && harvestable:
		harvest()
	
func arrange_pacing():
	if regrowable:
		pacing = float(age_to_grow - age)/2
	else:
		pacing = age_to_grow - age
		regrowth_number = 0
		
func calculate_next_step():
	next_step = age + pacing
	if next_step >= age_to_grow:
		next_step = age_to_grow

func update_age():
	super()
	if age >= next_step and age <= age_to_grow:
		aging_sprite()
		calculate_next_step()	
	if age == age_to_grow:
		enable_harvest()
		
func aging_sprite():
	Sprite.frame += 1
	
func enable_harvest():
	harvest_area2d.monitoring = true

		
func harvest():
	ItemPickManager.on_picking_item(harvested_plant)
	var result = await ItemPickManager.harvest_answer
	if result == true:
		ItemPickManager.number_of_harvested += 1
		if regrowth_number <= 0:
			self.queue_free()	
		else:
			age = round(age_to_grow - pacing)
			Sprite.frame -= 1
			harvestable = false
			harvest_area2d.monitoring = false
		
		regrowth_number -= 1
	else:
		pass


func _on_area_2d_area_entered(_area: Area2D) -> void:
	harvestable = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	harvestable = false
