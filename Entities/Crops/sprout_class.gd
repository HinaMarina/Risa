class_name Sprout extends Crop

@export var receiver : nutrient_receiver
@export var giver : nutrient_giver

@export var nourished_interval: Vector2i
@export var interval: Vector2i


func _ready() -> void:
	super()
	receiver.nourished.connect(on_nourished)

func on_nourished():
	interval = nourished_interval
	
func update_age():
	super()
	if age >= 2:
		plant_growing_age = randi_range(interval.x,interval.y)
		grow()
