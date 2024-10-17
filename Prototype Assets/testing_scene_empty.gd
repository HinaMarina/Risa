extends Node2D
@onready var player:Player
@export var corn_seedpack:PackedScene
@export var sunflower_seedpack:PackedScene

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


func _on_sunflower_seedpack_pressed() -> void:
	SeedInventoryManager.on_seedpack_aquisition(sunflower_seedpack,1)


func _on_corn_seedpack_pressed() -> void:
	SeedInventoryManager.on_seedpack_aquisition(corn_seedpack,1)
