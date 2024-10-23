class_name State_Machine extends State

@export var Idle_state : State
@export var Run_state: State
@export var Harvesting_state: State
@export var Throwing_state: State
var is_holding:bool
var item_being_hold:Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_state(Idle_state)
	ItemPickManager.item_pickup.connect(harvesting_requisition)
	Harvesting_state.harvested.connect(finished_harvesting)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	is_idle()
	current_state.do()

			
func _physics_process(_delta: float) -> void:
	current_state.physics_do()
	
func is_idle():
	if !Input.is_action_pressed("movement_action") && can_player_move:
		set_state(Idle_state)
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("movement_action"): #custom input that identifies every directional button
		if can_player_move:
			set_state(Run_state)
			input_vector.x = Input.get_axis("ui_left","ui_right")
			input_vector.y = Input.get_axis("ui_up","ui_down")
			input_vector = input_vector.normalized()
			update_state_input_vector()
	if is_holding:
		if event.is_action("Harvest") && (current_state == Idle_state || current_state == Run_state):
			set_state(Throwing_state)
			can_player_move = false
			await Throwing_state.item_throw
			can_player_move = true
			is_holding = false
			update_holding_status()
			
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
		
func harvesting_requisition(item:PackedScene):
	ItemPickManager.harvest_answer.emit(!is_holding)
	if !is_holding:
		can_player_move = false
		Harvesting_state.item_harvested = item
		set_state(Harvesting_state)
	
func finished_harvesting(item:Node2D):
	can_player_move = true
	is_holding = true
	item_being_hold = item
	update_holding_status()

func update_holding_status():
	for each in children_states:
		if each.has_method("holding_something_setter"):
			each.holding_something_setter(is_holding,item_being_hold)
