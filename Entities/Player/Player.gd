class_name Player extends Node2D

@export var Body:CharacterBody2D
@export var State_Machine:State_Machine
@export var Camera: Camera2D
#########################################
@export var Clock_canvas:CanvasLayer
@export var time_label:Label
@export var weekday_label:Label
@export var month_year_label:Label
@export var am_pm_label:Label
var status : String

func _ready() -> void:
	update_clock()
	GlobalTimeManager.time_updated.connect(update_clock)
	CalendarManager.day_updated.connect(update_clock)

func camera_limit(pontos:Vector4i):
	Camera.limit_left = pontos.x
	Camera.limit_top = pontos.y
	Camera.limit_right = pontos.z
	Camera.limit_bottom = pontos.w

func update_clock():
	time_label.text = str(GlobalTimeManager.game_hours) + ":" + str(GlobalTimeManager.game_minutes)
	am_pm_label.text = "AM"
	weekday_label.text = CalendarManager.day_of_the_week()
	month_year_label.text = CalendarManager.month_of_the_year() + " " + str(CalendarManager.current_day)
	if GlobalTimeManager.game_hours > 12:
		time_label.text = str(GlobalTimeManager.game_hours - 12) + ":" + str(GlobalTimeManager.game_minutes)
		am_pm_label.text = "PM"
	match CalendarManager.current_day:
		1: month_year_label.text = month_year_label.text+"st"
		2: month_year_label.text = month_year_label.text+"nd"
		3: month_year_label.text = month_year_label.text+"rd"
		_: month_year_label.text = month_year_label.text+"th"
	if GlobalTimeManager.game_hours < 10 or (GlobalTimeManager.game_hours - 12 < 10 && GlobalTimeManager.game_hours>12):
		time_label.text = "0" + time_label.text
	if GlobalTimeManager.game_minutes == 0:
		time_label.text = time_label.text + "0"	
