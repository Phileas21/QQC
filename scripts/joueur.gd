extends CharacterBody2D
var touché = 0
var attacking = false
var time0 = 0
signal pv
signal direction2
signal touche
#vitesse de déplacement
const VITESSE = 50.0
const un_sur_r2 = 1/sqrt(2)
enum DIRECTION {
	NORD,
	NORDEST,
	SUDEST,
	SUD,
	SUDOUEST,
	NORDOUEST
}

const idle_animation_name = {
	DIRECTION.NORD : "idleN",
	DIRECTION.NORDEST : "idleNE",
	DIRECTION.NORDOUEST : "idleNO",
	DIRECTION.SUD : "idleS",
	DIRECTION.SUDEST : "idleSE",
	DIRECTION.SUDOUEST : "idleSO",
}

const run_animation_name = {
	DIRECTION.NORD : "runN",
	DIRECTION.NORDEST : "runNE",
	DIRECTION.NORDOUEST : "runNO",
	DIRECTION.SUD : "runS",
	DIRECTION.SUDEST : "runSE",
	DIRECTION.SUDOUEST : "runSO",
}

@export var direction := DIRECTION.SUD
func get_direction():
	return direction

# instance d'animation
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var main_gauche: Sprite2D = $main_gauche
@onready var main_droite: Sprite2D = $main_droite
var is_running := false

func _ready() -> void:
	animated_sprite_2d.play("idleS")




# processus physiques du joueur ayant lieu au cours d'un temps "delta"
func _physics_process(delta: float) -> void:
	
	# direction = -1,0,1 selon les touches pressées
	var direction_x := Input.get_axis("déplacement_gauche", "déplacement_droit")
	var direction_y := Input.get_axis("déplacement_haut", "déplacement_bas")
	var vecteur_direction = Vector2i(direction_x,direction_y)
	
	#Déplacement
	if abs(direction_x) + abs(direction_y) < 1.5: #moins d'une direction à la fois
		velocity.x = direction_x * VITESSE
		velocity.y = direction_y * VITESSE
	else: #Sinon on normalise par racine de 2 :p
		velocity.x = direction_x * VITESSE * un_sur_r2
		velocity.y = direction_y * VITESSE * un_sur_r2
	
	#Mise à jour de la direction du joueur
	match vecteur_direction:
		Vector2i(0,0):
			pass
		Vector2i(0,1):
			direction = DIRECTION.SUD
		Vector2i(-1,0):
			direction = DIRECTION.SUDOUEST
		Vector2i(1,0):
			direction = DIRECTION.SUDEST
		Vector2i(-1,1):
			direction = DIRECTION.SUDOUEST
		Vector2i(1,1):
			direction = DIRECTION.SUDEST
		Vector2i(0,-1):
			direction = DIRECTION.NORD
		Vector2i(-1,-1):
			direction = DIRECTION.NORDOUEST
		Vector2i(1,-1):
			direction = DIRECTION.NORDEST
			
			
	if Input.is_action_pressed("attaque") and attacking == false:
		attacking = true
		#print(touché)
		time0 = Time.get_ticks_msec()
		if touché == 1:
			emit_signal("touche")
			emit_signal("pv",40)
		
	if Time.get_ticks_msec()>time0+200:
		attacking = false
		
	#Début de l'animation de repos
	if is_running and vecteur_direction == Vector2i(0,0):
		is_running = false
		animated_sprite_2d.play(idle_animation_name[direction])
	elif vecteur_direction != Vector2i(0,0):
		is_running = true
		animated_sprite_2d.play(run_animation_name[direction])

	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion:
		emit_signal("direction2",get_global_mouse_position())#event.position)




func _on_zoneattaque_body_entered(body):
	if body.has_method("enemy"):
		touché = 1
		
		


func _on_zoneattaque_body_exited(body):
	if body.has_method("enemy"):
		touché = 0
