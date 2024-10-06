extends Node

@onready var current_day:int = 1
@onready var current_month:int
signal day_updated(day,month)
var month_size:int = 28
var current_week = func week(): return int(current_day/7)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept"):
		update_day()
		print(str(current_day) + " " + str(current_month))		
		
func update_day():
	if current_day+1 <= month_size:
		current_day += 1
	else:
		current_day = 1
		current_month += 1
	
	day_updated.emit()
	update_UI()

	
func day_of_the_week() -> String:
	var day_of_the_week = int(current_day%7)
	var day: String
	match day_of_the_week:
		0: day = "sunday"
		1: day = "monday"
		2: day = "tuesday"
		3: day = "wednesday"
		4: day = "thursday"
		5: day = "friday"
		6:day = "saturday"

	return day
		

func update_UI():
	pass
