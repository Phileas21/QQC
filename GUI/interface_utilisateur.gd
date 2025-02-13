extends CanvasLayer

@onready var label_dialogue: Label = $Dialogue/MarginContainer/TexteDialogue
@onready var timerDefilement = $Dialogue/DefilementLettres

var Largeur_max = 1000 #largeur max de la zone de texte
var texte :String = ""
var lettre_index : int = 0

#temps d'affichage des caractères:
var temps_lettre : float = 0.03
var temps_espace : float = 0.06 # oui je sais
var temps_ponctuation : float = 0.2

signal texte_affiché


func _ready():
	$Dialogue.hide()
	$Dialogue.set_process_input(false)

func afficher_dialogue(dialogue :String)-> void:
	$Dialogue.show()
	$Dialogue.set_process_input(true)
	texte = dialogue
	lettre_index = 0
	label_dialogue.text = ""
	afficher_charactère()
	#await $Dialogue.resized


func afficher_charactère() -> void:
	
	if lettre_index >= texte.length():
		texte_affiché.emit()
		return
	
	label_dialogue.text += texte[lettre_index]
	match texte[lettre_index]:
		",",".",";",":","!","?" :
			timerDefilement.start(temps_ponctuation)
		" ":
			timerDefilement.start(temps_espace)
		_:
			timerDefilement.start(temps_lettre)
			
	lettre_index += 1

func _on_defilement_lettres_timeout() -> void:
	afficher_charactère()

#func afficher_dialogue(texte: String ):
	#label_dialogue.text = texte
	#$Dialogue.show()
	#$Dialogue.set_process_input(true)
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_ESCAPE:
			$Dialogue.hide()
			$Dialogue.set_process_input(false)
			
