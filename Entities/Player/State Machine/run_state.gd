extends State

var input_vector:Vector2
var is_in_stairs:bool

@export var MAX_SPEED:float
@export var acceleration:float

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
func move():
	var input_vector_fixed = fixing_input_vector_angles(input_vector)
	if is_in_stairs:
		input_vector_fixed.y = 2.3 * fixing_input_vector_angles(input_vector).y
		input_vector_fixed = input_vector_fixed.normalized()
	body.velocity = body.velocity.move_toward(input_vector_fixed*MAX_SPEED,acceleration)
	body.move_and_slide()
	
func fixing_input_vector_angles (input_vector:Vector2):
	# 0.45364 is the aproximation of the angle for pixel art isometric in radians
	# this function is constructed to take the directions of the input vector and map [...]
	# [...] the directions to the correct vector for isometric movement with fixed angles.
	if input_vector == Vector2.UP || input_vector == Vector2.DOWN || input_vector == Vector2.RIGHT || input_vector == Vector2.LEFT:
		return input_vector
	elif input_vector.x == input_vector.y:
		if input_vector.x > 0:
			return Vector2.from_angle(0.46364)
		if input_vector.x < 0:
			return Vector2.from_angle(PI + (0.46364))
	elif input_vector.x != input_vector.y:
		if input_vector.x > 0:
			return Vector2.from_angle(2*PI - (0.46364))
		if input_vector.x < 0:
			return Vector2.from_angle(PI - (0.46364))
