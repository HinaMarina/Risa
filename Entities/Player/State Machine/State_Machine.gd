class_name State_Machine extends State

@export var Idle_state : State
@export var Run_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_state(Idle_state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	is_idle()
	current_state.do()
	for each in children_states:
		print (str(each.name) +" "+ str(each.sprite.visible))
			
func _physics_process(delta: float) -> void:
	current_state.physics_do()
	
func is_idle():
	if !Input.is_action_pressed("movement_action"):
		set_state(Idle_state)
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("movement_action"): #custom input that identifies every directional button
		if can_player_move:
			set_state(Run_state)
			input_vector.x = Input.get_axis("ui_left","ui_right")
			input_vector.y = Input.get_axis("ui_up","ui_down")
			input_vector = input_vector.normalized()
			update_state_input_vector()
			
func set_state(new_state:State):
	super(new_state)
	hide_other_state_sprites()
						
func hide_other_state_sprites():
	for each in children_states:
		if each != current_state:
			each.sprite.visible = false
		else:
			each.sprite.visible = true

func update_state_input_vector():
	for each in children_states:
		each.input_vector = input_vector
