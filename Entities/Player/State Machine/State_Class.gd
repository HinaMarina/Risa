class_name State extends Node2D

@onready var animation_tree:AnimationTree
@onready var animation_player:AnimationPlayer
@onready var sprite : Sprite2D

@export var body : CharacterBody2D
var children_states : Array[State] = []
var parent_state : State
var current_state : State

var start_time : float
var lambda_time = func(): return Time.get_ticks_msec() - start_time
var is_complete : bool
var is_state_possible:bool

var can_player_move:bool = true
var can_exit:bool


func _ready() -> void:
	for child in self.get_children():
		if child is State:
			children_states.append(child)
	var parent_node = self.get_parent()
	if parent_node is State:
		parent_state = parent_node

func pause_movement():
	can_player_move = false

func enter():
	start_time = Time.get_ticks_msec()
	is_complete = false

func do():
	if current_state != null and current_state.is_complete == false:
		current_state.do()

func physics_do():
	if current_state != null and current_state.is_complete == false:
		current_state.physics_do()
		
func complete():
	is_complete = true

func set_state(new_state:State):
	if new_state != null and new_state != current_state:
		if current_state!=null:
			current_state.complete()
		current_state = new_state
		current_state.enter()
		
