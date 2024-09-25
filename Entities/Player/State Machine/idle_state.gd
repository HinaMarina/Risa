extends State

func _ready() -> void:
	super()
	set_state_assets()


func set_state_assets():
	for child in self.get_children():
		if child is AnimationTree:
			animation_tree = child
		if child is AnimationPlayer:
			animation_player = child
		if child is Sprite2D:
			sprite = child	
