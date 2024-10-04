class_name Player extends Node2D

@export var Body:CharacterBody2D
@export var State_Machine:State_Machine
@export var Camera: Camera2D
var status : String

func camera_limit(pontos:Vector4i):
	Camera.limit_left = pontos.x
	Camera.limit_top = pontos.y
	Camera.limit_right = pontos.z
	Camera.limit_bottom = pontos.w
