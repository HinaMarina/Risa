extends Node2D
@onready var player:Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Player:
			player = child
	var vetor = Vector4i(-150,-220,350,210)
	player.camera_limit(vetor)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
