extends CanvasLayer
@export var Tool_Inventory_BG:TextureRect
@export var Tool_Inventory_grid:GridContainer
@export var Hand_texture_placement:Sprite2D

var all_slots : Array[Slot]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_slots = Tool_Inventory_grid.all_slots
	for slot in all_slots:
		slot.slot_equip.connect(_on_slot_slot_equip)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_slot_slot_equip(item: Node, slot: Slot) -> void:
	Hand_texture_placement.texture = item.sprite.texture
	Hand_texture_placement.hframes = item.sprite.hframes
	Hand_texture_placement.frame = item.sprite.frame
