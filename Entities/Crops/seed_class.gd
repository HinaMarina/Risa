class_name Seed extends Crop

@export var nutrient_receiver : nutrient_receiver

func update_age():
	super()
	if age >= 1:
		grow()
