extends Sprite2D


enum direction{
	GAUCHE,
	DROIT
}

#position au repos de la main pour l'orientation du personnage vers la droite
var position_dir_droit := Vector2(7,6)
var position_dir_gauche := Vector2(7,6)
var position_equilibre = position_dir_gauche
var position_absolue
var velocity = Vector2(0,0)

#La main a la physique d'un système masse ressort avec frottements:
var k = 500 #constante de raideur
var l = 20 #frottements

func update_direction(dir: direction):
	if dir == direction.GAUCHE:
		position_equilibre = position_dir_gauche
		z_index = 2
	else:
		position_equilibre = position_dir_droit
		z_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = position_dir_droit
	position_absolue = get_parent().position + position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var direction = get_parent().direction()
	# la main est attirée vers une position d'équilibre "position_dir_XXX"
	var parent_pos = get_parent().position
	var position_eq = parent_pos + position_equilibre + Vector2(0,1*sin(0.003*Time.get_ticks_msec()))
	var acceleration = k*(position_eq - position_absolue) - l*velocity
	velocity += acceleration*delta
	position = (position_absolue-parent_pos) +  velocity*delta
	
	position_absolue = parent_pos + position
	
	
	
	
	
