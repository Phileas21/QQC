extends CharacterBody2D

@onready var m_dialogue: ModuleDialogue = $ModuleDialogue

func _ready() -> void:
	m_dialogue.clé_début = "salutations"
	m_dialogue.ajouter_dialogue(
		"salutations", 
		["Bonjour! L'heure est venue jeune apprenti."],
		"r1")
	m_dialogue.ajouter_réponses(
		"r1",
		["L'heure de quoi ?", "Partir"],
		["petit_dej","fin"] )
	m_dialogue.ajouter_fin("fin")
	m_dialogue.ajouter_dialogue(
		"petit_dej",
		["Du troisième petit déjeuner évidemment..."],
		"fin"
		)
