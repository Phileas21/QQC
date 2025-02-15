extends Area2D
class_name ZoneInteraction

# Nom de l'interaction affiché au dessus de la zone d'interaction
@export var nom_interaction: String = "interagir"

# Action à effectuer lorsque l'interaction est enclenchée
# - l'action est une fonction stockée sous la forme d'une variable
# - par défaut la fonction ne fait rien
# - c'est à l'entité ratachée à la zone d'interaction de définir cette fonction
var interagir: Callable = func():
	pass 


func _on_body_entered(body: Node2D) -> void:
	GestionnaireInteraction.ajouter_zone(self)


func _on_body_exited(body: Node2D) -> void:
	GestionnaireInteraction.retirer_zone(self)
