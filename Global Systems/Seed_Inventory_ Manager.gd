extends Node

var all_seed_slots:Array[Slot]
var last_pack:PackedScene

func set_slots_in_manager(grid_all_slots:Array[Slot]):
	all_seed_slots = grid_all_slots
	for slot in all_seed_slots:
		slot.slot_is_full.connect(on_slot_full)

func on_seedpack_aquisition(newitem:PackedScene,newquantity:int):
	var item = newitem.instantiate() as tool
	last_pack = newitem
	for slot in all_seed_slots:
		if slot.item == null:
			print(slot.item)
			slot.add_item(item,newquantity)
			return
		if item.tool_name == slot.item.tool_name && slot.is_full == false:
			print(item.tool_name,slot.item.tool_name)
			print('printacá')
			slot.add_item(item,newquantity)
			return
			
		
			
func on_slot_full(item:Node,slot:Slot,quantity:int):
	if quantity > 0:
		on_seedpack_aquisition(last_pack,quantity)