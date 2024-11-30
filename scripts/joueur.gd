extends CharacterBody2D

#vitesse de déplacement
const VITESSE = 250.0
const un_sur_r2 = 1/sqrt(2)
enum DIRECTION {
	GAUCHE,
	DROIT
}
@export var direction := DIRECTION.DROIT
func get_direction():
	return direction

# instance d'animation
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var main_gauche: Sprite2D = $main_gauche
@onready var main_droite: Sprite2D = $main_droite


# processus physiques du joueur ayant lieu au cours d'un temps "delta"
func _physics_process(delta: float) -> void:
	
	# directin = -1,0,1 selon les touches pressées
	var direction_x := Input.get_axis("déplacement_gauche", "déplacement_droit")
	var direction_y := Input.get_axis("déplacement_haut", "déplacement_bas")
	
	if abs(direction_x) + abs(direction_y) < 2:
		velocity.x = direction_x * VITESSE
		velocity.y = direction_y * VITESSE
	else:
		velocity.x = direction_x * VITESSE * un_sur_r2
		velocity.y = direction_y * VITESSE * un_sur_r2
		
	
	if direction_x == 0:
		#pas de déplacement
		if direction == DIRECTION.GAUCHE:
			animated_sprite_2d.play("idle_3_4_g")
		else:
			animated_sprite_2d.play("idle_3_4_d")
	
	elif direction_x == 1: #déplacement vers la gauche
		animated_sprite_2d.play("marche_3_4_d")
		direction = DIRECTION.DROIT
		
	elif direction_x ==-1: #déplacement vers la gauche
		animated_sprite_2d.play("marche_3_4_g")
		direction = DIRECTION.GAUCHE
		
	main_gauche.update_direction(direction)
	main_droite.update_direction(direction)

	move_and_slide()
