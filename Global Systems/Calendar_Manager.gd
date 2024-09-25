extends Node

@onready var current_day:int
@onready var current_month:int
signal day_updated(day,month)
var month_size:int = 28
var current_week = func week(): return int(current_day/7)

func _ready() -> void:
	pass

func update_day():
	if current_day+1 <= month_size:
		current_day += 1
		emit_signal("day_updated",current_day,current_month)
	else:
		current_day = 1
		current_month += 1
		emit_signal("day_updated",current_day,current_month)
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
