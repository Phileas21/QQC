extends CharacterBody2D
signal damage
var PV = 100
var id = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _animated_sprite = $AnimatedSprite2D
func enemy():
	pass

func _physics_process(delta: float) -> void:
	if PV>0:
		_animated_sprite.play("default")
	if not is_on_floor():
		velocity = 0*sin(Time.get_ticks_msec()*6.34/1000)*get_gravity() * delta


	move_and_slide()
