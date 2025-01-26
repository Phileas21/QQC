extends Control

var inventory_toggled=false #inventaire ouvert

func _ready() -> void:
	%Inventory.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		inventory_toggled=not inventory_toggled
		print("a")
		if inventory_toggled:
			%Inventory.show()
		else:
			%Inventory.hide()
