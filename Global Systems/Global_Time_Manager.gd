extends Node

@onready var current_turn:int
@onready var number_of_turns:int
signal day_has_ended
signal time_updated
var real_time_in_seconds : float
var start_time:int
var time_to_a_minute:float = 3

var game_minutes:int

var game_hours:int

func _ready() -> void:
	start_time = Time.get_ticks_msec()
	CalendarManager.day_updated.connect(on_day_updated)
	time_updated.emit()
	
func _process(_delta: float) -> void:
	real_time_in_seconds = float(Time.get_ticks_msec() - start_time)/1000
	real_time_to_game_time()
	

func real_time_to_game_time():
	if real_time_in_seconds >= time_to_a_minute:
		game_minutes += 10
		if game_minutes >= 60:
			game_hours += 1
			game_minutes = 0
			if game_hours >= 24:
				game_hours = 0
				CalendarManager.update_day()
		start_time = Time.get_ticks_msec()
		time_updated.emit()
	
func update_time(turns_passed:int):
	if current_turn+turns_passed <= number_of_turns:
		current_turn += turns_passed
		update_UI()
			
func unlock_night_turns():
	number_of_turns +=2
	update_UI()
	
func on_day_updated():
	game_hours = 0
	game_minutes = 0
	start_time = Time.get_ticks_msec()
	
func end_the_day():
	current_turn = 0
	day_has_ended.emit()
	
func update_UI():
	pass
