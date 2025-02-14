extends CanvasLayer

@onready var label_dialogue: Label = $Dialogue/MarginContainer/TexteDialogue
@onready var timerDefilement = $Dialogue/DefilementLettres
@onready var menu_options: MenuOptions = $Dialogue/Menu_options

var Largeur_max = 1000 #largeur max de la zone de texte
var texte :String = ""
var série_dialogue : Dictionary
var dialogue : Dialogue
var clé_dialogue : String
var ligne_index = 0
var lettre_index : int = 0
var dialogue_actif : bool = false

#temps d'affichage des caractères:
var temps_lettre : float = 0.03
var temps_espace : float = 0.06 # oui je sais
var temps_ponctuation : float = 0.2

#signal texte_affiché
var ligne_affichée : bool = false

func _ready():
	$Dialogue.hide()
	$Dialogue.set_process_input(false)

func quitter_dialogue():
	$Dialogue.hide()
	$Dialogue.set_process_input(false)
	timerDefilement.stop()
	dialogue_actif = false

func afficher_ligne(dialogue :String)-> void:
	$Dialogue.show()
	$Dialogue.set_process_input(true)
	texte = dialogue
	lettre_index = 0
	label_dialogue.text = ""
	ligne_affichée = false
	afficher_charactère()
	#await $Dialogue.resized
	
func afficher_dialogue() -> void:
	# Affiche le dialogue suivant
	var orateur = dialogue.orateur
	
	match orateur:
		Dialogue.Orateur.PNJ:
			menu_options.hide()
			$Dialogue/MarginContainer.show()
			if ligne_index >= dialogue.lignes.size():
				# On passe à la séquence de dialogue suivante
				séquence_suivante(dialogue.clé_suivants[0])
			else:
				afficher_ligne(dialogue.lignes[ligne_index])
			
		Dialogue.Orateur.JOUEUR:
			menu_options.show()
			$Dialogue/MarginContainer.hide()
			menu_options.effacer_options()
			var num_options:int = dialogue.lignes.size()
			var num_clés:int = dialogue.clé_suivants.size()
			for i in num_options:
				if i < num_clés:
					menu_options.ajouter_option(dialogue.lignes[i],dialogue.clé_suivants[i])
				else:
					menu_options.ajouter_option(dialogue.lignes[i]," ")
			pass
		_:
			quitter_dialogue()
			
	
	
func démarrer_dialogue(dialogues : Dictionary, clé : String):
	if dialogue_actif: 
		# on ne démarre pas deux dialogues
		return
	
	série_dialogue = dialogues
	clé_dialogue = clé
	
	if not clé_dialogue in série_dialogue:
		quitter_dialogue()
		return
	
	dialogue = série_dialogue[clé_dialogue]
	ligne_index = 0
	
	$Dialogue.show()
	$Dialogue.set_process_input(true)
	dialogue_actif = true
	afficher_dialogue()

func séquence_suivante(clé:String):
	print(clé)
	clé_dialogue = clé
	
	if not clé_dialogue in série_dialogue:
		quitter_dialogue()
		return
	
	dialogue = série_dialogue[clé_dialogue]
	ligne_index = 0

	afficher_dialogue()


func afficher_charactère() -> void:
	# affiche un caractère en plus à la ligne en cours
	if lettre_index >= texte.length():
		#texte_affiché.emit()
		ligne_affichée = true
		ligne_index += 1
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


func afficher_ligne_entière() -> void:
	timerDefilement.stop()
	label_dialogue.text = texte
	ligne_affichée = true
	ligne_index += 1



func _on_defilement_lettres_timeout() -> void:
	afficher_charactère()


	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_ESCAPE:
			quitter_dialogue()
	if event.is_action_pressed("Avancer dialogue"):
		if ligne_affichée:
			afficher_dialogue()
		else:
			afficher_ligne_entière()
			
			
			


func _on_option_choisie() -> void:
	séquence_suivante(menu_options.clé_choix)
	pass
