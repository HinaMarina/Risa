extends Node

@onready var current_turn:int
@onready var number_of_turns:int
signal day_has_ended
signal not_enough_turns

func update_time(turns_passed:int):
	if current_turn+turns_passed <= number_of_turns:
		current_turn += turns_passed
		update_UI()
	else:
		emit_signal("not_enough_turns")
		
func unlock_night_turns():
	number_of_turns +=2
	update_UI()
	
func end_the_day():
	current_turn = 0
	emit_signal("day_has_ended")
	
func update_UI():
	pass