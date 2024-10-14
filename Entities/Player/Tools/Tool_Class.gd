class_name tool extends Node

@export var tool_name : String
@export var sprite:Sprite2D
@export_multiline var description : String

signal tool_equipped(tool_name:String,eqquiped:bool)
var equipped : bool

func _ready() -> void:
	if !(sprite != null):
		for child in get_children():
			if child is Sprite2D:
				sprite = child
				print (sprite)

func equip_tool():
	equipped = !equipped
	tool_equipped.emit(tool_name,equipped)
