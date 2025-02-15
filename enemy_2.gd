extends CharacterBody2D
signal damage
var PV = 100
var id = 2
var X = 0
var Y = 0
var sintheta = 0
var costheta = 0
signal pvjoueur
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().get_child(3)

func enemy():
	pass

func _physics_process(delta: float) -> void:
	X = player.position.x-self.position.x
	Y = player.position.y-self.position.y
	costheta = X/(sqrt(X*X+Y*Y))
	sintheta = Y/(sqrt(X*X+Y*Y))
	#print(X*X+Y*Y)
	if X*X+Y*Y<3000:
		emit_signal("pvjoueur")
	if PV>0 and X*X+Y*Y>2500 :
		velocity.x = costheta*20
		velocity.y = sintheta*20
		_animated_sprite.play("default")
	else :
		velocity.x = 0
		velocity.y = 0
	#if not is_on_floor():
	#	velocity = 10*sin(Time.get_ticks_msec()*6.34/1000)*get_gravity() * delta
		

	move_and_slide()
	
func _on_joueur_pv(a,b):
	if b == id:
		PV -= a
		if PV<0:
			PV = 0
		emit_signal("damage",PV)


func _on_joueur_touche(b) -> void:
	if b == id:
		if PV<=39:
			_animated_sprite.play("mort")
