extends Node2D

enum DIRECTION {
	NORD,
	NORDEST,
	SUDEST,
	SUD,
	SUDOUEST,
	NORDOUEST
}

@onready var main_gauche: Sprite2D = $main_gauche
@onready var main_droite: Sprite2D = $main_droite


#La main a la physique d'un système masse ressort avec frottements (approximation des plus classiques en physique)
var k = 500 #constante de raideur
var l = 20 #frottements
#position centrale des mains en fonction du contexte:
var Positions_equilibre = {
	"gauche face" : Vector2(7,7),
	"gauche dos" : Vector2(-7,7),
	"droite face" : Vector2(-7,7),
	"droite dos" : Vector2(7,7),
}
# Position selon l'axe Z (devant/derrière le corps) des mains suivant la direction:
# Vector2i( z_offset main gauche , z_offset main droite)
var POSITIONS_Z = {
	DIRECTION.SUD : Vector2i(1,1),
	DIRECTION.SUDEST : Vector2i(-1,1),
	DIRECTION.SUDOUEST : Vector2i(1,-1),
	DIRECTION.NORD : Vector2i(-1,-1),
	DIRECTION.NORDEST : Vector2i(-1,1),
	DIRECTION.NORDOUEST : Vector2i(1,-1),
}
var direction = DIRECTION.SUD
var Corps_Z_pos = 2 #position de AnimatedSprite2D...

var position_absolue_gauche := Vector2(0,0)
var position_absolue_droite := Vector2(0,0)
var position_cible_gauche = Positions_equilibre["gauche face"]
var position_cible_droite = Positions_equilibre["droite face"]
var velocite_gauche := Vector2(0,0)
var velocite_droite := Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_gauche.position = position_cible_gauche
	position_absolue_gauche = get_parent().position + main_gauche.position
	main_droite.position = position_cible_droite
	position_absolue_droite = get_parent().position + main_droite.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var frequence_oscillations = 0.003
	if get_parent().is_running:
		frequence_oscillations = 0.010
	
	var parent_pos = get_parent().position
	#physique main gauche
	var position_eq = parent_pos + position_cible_gauche + Vector2(0,0.6*sin(frequence_oscillations*Time.get_ticks_msec()))
	var acceleration = k*(position_eq - position_absolue_gauche) - l*velocite_gauche
	velocite_gauche += acceleration*delta
	main_gauche.position = (position_absolue_gauche-parent_pos) +  velocite_gauche*delta
	position_absolue_gauche = parent_pos + main_gauche.position
	#physique main droite
	position_eq = parent_pos + position_cible_droite + Vector2(0,0.6*sin(frequence_oscillations*Time.get_ticks_msec()))
	acceleration = k*(position_eq - position_absolue_droite) - l*velocite_droite
	velocite_droite += acceleration*delta
	main_droite.position = (position_absolue_droite-parent_pos) +  velocite_droite*delta
	position_absolue_droite = parent_pos + main_droite.position
	
	#MaJ direction
	var parent_dir = get_parent().direction
	if parent_dir != direction:
		direction = parent_dir
		main_gauche.z_index = Corps_Z_pos + POSITIONS_Z[direction].x
		main_droite.z_index = Corps_Z_pos + POSITIONS_Z[direction].y
		
		if direction == DIRECTION.SUD or direction == DIRECTION.SUDEST or direction == DIRECTION.SUDOUEST:
			position_cible_gauche = Positions_equilibre["gauche face"]
			position_cible_droite = Positions_equilibre["droite face"]
		else:
			position_cible_gauche = Positions_equilibre["gauche dos"]
			position_cible_droite = Positions_equilibre["droite dos"]
			
		
		
