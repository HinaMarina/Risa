extends State

@export var throwing_spot:Node2D
var holding_something:bool
var item_holding:Node2D
signal item_throw
var thrown:bool = false
var t :float = 0.0
var interpolating:bool = false
var p1:Vector2
var p2:Vector2
var p3:Vector2

func physics_do():
	super()
	if interpolating:
		t += 0.05
		item_holding.position = quadratic_bezier(p1,p2,p3,t)
		if t>=1:
			interpolating = !interpolating
			item_holding.queue_free()
			item_throw.emit()
			thrown = false
		
func do():
	super()
	if item_holding != null and !thrown:
		if input_vector.x >= 0:
			animation_player.play("E")
		else:
			animation_player.play("W")
		thrown = true

func throw():
	t = 0
	interpolating = true
	#var tween = create_tween()
	#tween.set_trans(Tween.TRANS_LINEAR)
	#tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(item_holding,"global_position",throwing_spot.global_position,0.5)
	#await tween.finished
	#item_holding.queue_free()
	#item_throw.emit()
	#thrown = false

func _input(event: InputEvent) -> void:
	if event.is_action("movement_action"):
		var input = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
		if input != Vector2.ZERO:
			throwing_spot.position = input.normalized()*80
			if item_holding != null:
				p1 = Vector2(0,-40+40)
				p3 = Vector2(throwing_spot.position.x,throwing_spot.position.y+40)
				p2 = Vector2((p1.x + p3.x)/2,((p1.y+p2.y)/2) - 20)
				
func quadratic_bezier(p0:Vector2,p1:Vector2,p2:Vector2,t:float):
	var q0 = p0.lerp(p1,t)
	var q1 = p1.lerp(p2,t)
	var r = q0.lerp(q1,t)
	return r

func holding_something_setter(value:bool, item:Node2D):
	holding_something = value
	item_holding = item
