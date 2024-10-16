extends CanvasLayer
@export var Tool_Inventory_BG:TextureRect
@export var Tool_Inventory_grid:GridContainer

@export var Seed_Inventory_BG:TextureRect
@export var Seed_Inventory_grid:GridContainer

@export var Hand_texture_placement:Sprite2D
@export var item_selection_label:Label
@export var ToolxSeed_Button:TextureButton
@export var item_info_label:Label

var item_on_hand : Node

var all_tool_slots : Array[Slot]
var all_seed_slots : Array[Slot]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_tool_slots = Tool_Inventory_grid.all_slots
	all_seed_slots = Seed_Inventory_grid.all_slots
	print(all_seed_slots == all_tool_slots)
	for slot in all_tool_slots:
		slot.slot_equip.connect(_on_slot_slot_equip)
		slot.slot_info.connect(display_item_info)
		slot.slot_off.connect(_on_slot_off)
	for slot in all_seed_slots:
		slot.slot_equip.connect(_on_slot_slot_equip)
		slot.slot_info.connect(display_item_info)
		slot.slot_off.connect(_on_slot_off)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func display_item_info(item:Node, slot:Slot):
	if item is tool:
		item_selection_label.text = item.tool_name
		item_info_label.text = item.description
	if item == null:
		item_selection_label.text = ""
		item_info_label.text = ""

func _on_slot_slot_equip(item: Node, slot: Slot) -> void:
	if item != null:
		item_on_hand = item
		Hand_texture_placement.texture = item.sprite.texture
		Hand_texture_placement.hframes = item.sprite.hframes
		Hand_texture_placement.frame = item.sprite.frame
		if item.tool_name == "Unequip":
			item_on_hand = null
			Hand_texture_placement.texture = null
			
func _on_slot_off(item:Node,slot:Slot):
	if item == item_on_hand:
		Hand_texture_placement.texture = null

func _on_tool_seed_button_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		Tool_Inventory_BG.visible = true
		Seed_Inventory_BG.visible = false
		ToolxSeed_Button.focus_neighbor_bottom = Tool_Inventory_grid.all_buttons[0].get_path()
	else:
		Tool_Inventory_BG.visible = false
		Seed_Inventory_BG.visible = true
		ToolxSeed_Button.focus_neighbor_bottom = Seed_Inventory_grid.all_buttons[0].get_path()
