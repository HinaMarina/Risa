extends State

@export var picking_spot:Node2D
var item_harvested:PackedScene
var picking:Node2D
signal harvested(item_harvested:PackedScene)

func _ready() -> void:
	super()
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_tree.active = false

func do():
	super()
	picked_up(item_harvested)
	if input_vector.x >= 0:
		animation_player.play("E")
	else:
		animation_player.play("W")


func sets_animation():
	animation_tree.set("parameters/blend_position",input_vector)
	
func _on_animation_finished(anim_name: StringName):
	print("passeicá")
	if picking != null:
		picking.visible = true
		harvested.emit(item_harvested)
		complete()
	

func picked_up(item:PackedScene):
	picking = item.instantiate()
	picking_spot.add_child(picking)
	picking.global_transform = picking_spot.global_transform
	picking.visible = false
