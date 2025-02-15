extends Node2D



@onready var joueur: CharacterBody2D = get_tree().get_first_node_in_group("joueur")
@onready var label: Label = $TexteInteraction

const touche_interaction : String  ="[E]"

# liste de des zones d'interaction à portée du joueur
var zones_actives : Array[ZoneInteraction] = []
var peut_interagir : bool = true

func ajouter_zone(zone : ZoneInteraction):
	zones_actives.push_back(zone)

func retirer_zone(zone: ZoneInteraction):
	var index = zones_actives.find(zone)
	if index != -1:
		zones_actives.remove_at(index)
	

# fonction permettant de trier les zones d'interaction en fonction
# de leur distance au joueur
func tri_distance_joueur(zone1, zone2):
	var d1 = joueur.global_position.direction_to(zone1)
	var d2 = joueur.global_position.direction_to(zone2)
	return d1 < d2

func _process(delta: float) -> void:
	if zones_actives.size() > 0 && peut_interagir:
		zones_actives.sort_custom(tri_distance_joueur)
		label.text = zones_actives[0].nom_interaction + touche_interaction
		label.global_position = zones_actives[0].global_position
		label.global_position.y -= 40
		label.global_position.x -= label.size.x /2
		label.show()
	else:
		label.hide()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interagir") && peut_interagir:
		if zones_actives.size() > 0:
			peut_interagir = false
			label.hide()
			await zones_actives[0].interagir.call()
			
			peut_interagir = true
		
