extends ZoneInteraction
class_name ModuleDialogue


var Dialogues : Dictionary = {}
var clé_début : String = ""
@export var dialogue : String = "Bonjour, l'heure est venue jeune apprenti"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nom_interaction = "parler "
	interagir = func():
		InterfaceUtilisateur.démarrer_dialogue(Dialogues,clé_début)



func ajouter_dialogue
(clé : String, lignes : Array[String], clé_suivant : String) -> void:
	var diag : Dialogue = Dialogue.new()
	diag.orateur = Dialogue.Orateur.PNJ
	diag.lignes = lignes
	diag.clé_suivants = [clé_suivant]
	self.Dialogues[clé] = diag
	
func ajouter_réponses
(clé : String, options : Array[String], clé_suivants : Array[String]) -> void:
	var diag : Dialogue = Dialogue.new()
	diag.orateur = Dialogue.Orateur.JOUEUR
	diag.lignes = options
	diag.clé_suivants = clé_suivants
	self.Dialogues[clé] = diag
	
func ajouter_fin(clé: String)->void:
	var diag : Dialogue = Dialogue.new()
	diag.orateur = Dialogue.Orateur.FIN_DE_DIALOGUE
	self.Dialogues[clé] = diag
	
