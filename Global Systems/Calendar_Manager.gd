extends Node

@onready var current_day:int = 1
@onready var current_month:int = 1
signal day_updated(day,month)
var month_size:int = 28
@warning_ignore("integer_division")
var current_week = func week(): return int(current_day/7)
	
func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_released("ui_accept"):
		update_day()
	if Input.is_action_pressed("Speed_up_Time"):
		GlobalTimeManager.time_to_a_minute = 0.03
	if Input.is_action_just_released("Speed_up_Time"):
		GlobalTimeManager.time_to_a_minute = 3

func update_day():
	if current_day+1 <= month_size:
		current_day += 1
	else:
		current_day = 1
		current_month += 1
	
	day_updated.emit()
	print("day updated")
	update_UI()

	
func day_of_the_week() -> String:
	var day_of_the_week = int(current_day%7)
	var day: String
	match day_of_the_week:
		0: day = "Sunday"
		1: day = "Monday"
		2: day = "Tuesday"
		3: day = "Wednesday"
		4: day = "Thursday"
		5: day = "Friday"
		6:day = "Saturday"

	return day
		
func month_of_the_year() -> String:
	var month = int(current_month%12)
	var month_string:String
	
	match month:
		0: month_string = "December"
		1: month_string = "January"
		2: month_string = "February"
		3: month_string = "March"
		4: month_string = "April"
		5: month_string = "May"
		6: month_string = "June"
		7: month_string = "July"
		8: month_string = "August"
		9: month_string = "September"
		10: month_string = "October"
		11: month_string = "November"

	return month_string
func update_UI():
	pass
