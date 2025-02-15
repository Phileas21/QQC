extends MarginContainer
class_name MenuOptions
const DOGICA_28_PX : Theme = preload("res://assets/fonts/dogica28px.tres")
var boutons : Array[Button] = []
var sélection_index :int = 0
@onready var sélection: Sprite2D = $"sélection"
@onready var v_box_container: VBoxContainer = $VBoxContainer

var clé_choix : String
signal option_choisie


func effacer_options()->void:
	# retire tous les boutons
	for child in v_box_container.get_children():
		v_box_container.remove_child(child)
		child.queue_free()
	boutons = []


func ajouter_option(nom : String, clé: String) ->void:
	var bouton : Button = Button.new()
	bouton.theme = DOGICA_28_PX
	bouton.text = nom
	bouton.flat = true
	bouton.focus_mode = Control.FOCUS_NONE
	bouton.alignment = HORIZONTAL_ALIGNMENT_LEFT
	bouton.custom_minimum_size.y = 50
	bouton.pressed.connect(
		func ():
			clé_choix = clé
			option_choisie.emit()
	)
	bouton.mouse_entered.connect(
		func ():
			sélection.global_position.y = bouton.global_position.y + bouton.size.y/2
	)
	v_box_container.add_child(bouton)
	boutons.append(bouton)
	
	await bouton.resized
	sélection.global_position.y = boutons[0].global_position.y + boutons[0].size.y/2
	sélection_index = 0
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey && not boutons.is_empty():
		if event.pressed && event.keycode == KEY_UP:
			sélection_index = (sélection_index - 1)% boutons.size()
		if event.pressed && event.keycode == KEY_DOWN:
			sélection_index = (sélection_index + 1)% boutons.size()
		
		sélection.global_position.y = boutons[sélection_index].global_position.y + boutons[sélection_index].size.y/2
		
		if event.pressed && event.keycode == KEY_ENTER:
			boutons[sélection_index].pressed.emit()
