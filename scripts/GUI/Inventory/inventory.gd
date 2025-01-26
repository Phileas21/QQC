extends Control

var items_to_load := ["res://GUI/Inventory/Resources/lance.tres",
"res://GUI/Inventory/Resources/epee.tres"]
#@export var table=LootTable.junk_table

var test_chest =[]#generate_loot(1,2)
#var test= table.generate_loot(1,2)

func _ready():
	for i in 1000:
		print("a")
	for i in 24: #nombre de slots
		var slot:= InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32,32))# Nom des slots, taille des slots
		%PlayerGrid.add_child(slot)
	for i in items_to_load.size():
		var item:=InventoryItem.new()
		item.init(load(items_to_load[i]))
		%PlayerGrid.get_child(i).add_child(item)
	initiate_chest()
	#fill_chest()
	
	
func initiate_chest():#Initiates ChestGrid
	for i in 12:
		var slot:= InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32,32))# Nom des slots, taille des slots
		%ChestGrid.add_child(slot)


func fill_chest(chest_items):#fills ChestGrid with item list
	for i in chest_items.size():
		var item:=InventoryItem.new()
		item.init(load(chest_items[i]))
		%ChestGrid.get_child(i).add_child(item)

func open_chest():
	%ChestGrid.show()

func close_chest():
	%ChestGrid.hide()

func empty_chest():
	for i in 12:
		if %ChestGrid.get_child(i).get_child_count():
			%ChestGrid.get_child(i).get_child(0).free()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		open_chest()
		
	if Input.is_action_just_pressed("ui_down"):
		close_chest()
	
	if Input.is_action_just_pressed("ui_left"):
		empty_chest()
