extends CharacterBody2D
signal damage
var PV = 100
var time0 = 0
var attacking = false
var click = 0
var X = 0
var Y = 0
var id = 5
var chasing = false
var player = null
var sintheta = 0
var costheta = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#@onready var _animated_sprite = $AnimatedSprite2D2
#@onready var player = get_parent().get_child(3)

func enemy():
	pass

func _physics_process(delta: float) -> void:
	if chasing == true:
		X = player.position.x-self.position.x
		Y = player.position.y-self.position.y
		costheta = X/(sqrt(X*X+Y*Y))
		sintheta = Y/(sqrt(X*X+Y*Y))
		#print(X*X+Y*Y)
		#if X*X+Y*Y<3000:
			#emit_signal("pvjoueur")
		if X*X+Y*Y>2500 and PV>0 :
			self.position.x += costheta*0.5
			self.position.y += sintheta*0.5
			#_animated_sprite.play("default")
		else :
			velocity.x = 0
			velocity.y = 0
		if Time.get_ticks_msec()>time0+200:
			attacking = false
		if Input.is_action_pressed("attaque") and attacking == false:
			if click == 1:
				time0 = Time.get_ticks_msec()
				attacking = true
				PV-=40
		emit_signal("damage",40)
			
	
		
func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("_input"):
		player = body
		chasing = true

func _on_damage_3_area_entered(area: Area2D) -> void:
	if area.name == "zoneattaque":
		click = 1
		
func _on_damage_3_area_exited(area: Area2D) -> void:
	if area.name == "zoneattaque":
		click = 0
		


		
