extends State

func _ready() -> void:
	super()
	set_state_assets()


func do():
	super()
	sets_animation()

func set_state_assets():
	for child in self.get_children():
		if child is AnimationTree:
			animation_tree = child
		if child is AnimationPlayer:
			animation_player = child
		if child is Sprite2D:
			sprite = child
			
func sets_animation():
	animation_tree.set("parameters/blend_position",input_vector)
