extends MarginContainer
class_name MenuOptions
const DOGICA_28_PX : Theme = preload("res://assets/fonts/dogica28px.tres")
#var boutons : Array[Button] = []
#var clés : Array[String] = []
@onready var sélection: Sprite2D = $"sélection"
@onready var v_box_container: VBoxContainer = $VBoxContainer

var clé_choix : String
signal option_choisie


func effacer_options()->void:
	# retire tous les boutons
	for child in v_box_container.get_children():
		v_box_container.remove_child(child)
		child.queue_free()


func ajouter_option(nom : String, clé: String) ->void:
	var bouton : Button = Button.new()
	bouton.theme = DOGICA_28_PX
	bouton.text = nom
	bouton.flat = true
	bouton.focus_mode = Control.FOCUS_NONE
	bouton.alignment = HORIZONTAL_ALIGNMENT_LEFT
	bouton.pressed.connect(
		func ():
			clé_choix = clé
			option_choisie.emit()
	)
	v_box_container.add_child(bouton)
	#boutons.append(bouton)
	#clés.append(clé)
