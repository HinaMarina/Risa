extends State

@export var normal_idle_texture:Texture
@export var holding_idle_texture:Texture
var holding_something :bool

func do():
	super()
	sets_animation()


func holding_something_setter(value:bool, _item:Node2D):
	holding_something = value

			
func sets_animation():
	if holding_something:
		sprite.texture = holding_idle_texture
	else:
		sprite.texture = normal_idle_texture
	animation_tree.set("parameters/blend_position",input_vector)
