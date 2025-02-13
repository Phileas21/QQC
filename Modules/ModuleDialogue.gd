extends ZoneInteraction

@export var dialogue : String = "Bonjour, l'heure est venue jeune apprenti"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nom_interaction = "parler "
	
	interagir = func():
		InterfaceUtilisateur.afficher_dialogue(dialogue)
	
