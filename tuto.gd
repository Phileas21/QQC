extends Node2D
var enemyscene = load("res://enemy_2.tscn")
var enemy2 = enemyscene.instantiate()
var enemy3 = enemyscene.instantiate()
var enemy4 = enemyscene.instantiate()
var kcount = 0

@onready var dialogue_text : RichTextLabel = get_node("joueur/killcount")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(enemy2)
	enemy2.position.x = 371+randf()*50
	enemy2.position.y = 10+randf()*50
	add_child(enemy3)
	enemy3.position.x = 400+randf()*50
	enemy3.position.y = 10+randf()*50
	add_child(enemy4)
	enemy4.position.x = 420+randf()*50
	enemy4.position.y = 10+randf()*50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemy2.PV<0 :
		kcount += 1 
		dialogue_text.text = "Killcount :" + str(kcount)
		enemy2.PV = 100
		enemy2.position.x = 371+randf()*150
		enemy2.position.y = 10+randf()*150
	if enemy3.PV<0 :
		kcount += 1 
		dialogue_text.text = "Killcount :" + str(kcount)
		enemy3.PV = 100
		enemy3.position.x = 371+randf()*150
		enemy3.position.y = 10+randf()*150
	if enemy4.PV<0 :
		kcount += 1 
		dialogue_text.text = "Killcount :" + str(kcount)
		enemy4.PV = 100
		enemy4.position.x = 371+randf()*150
		enemy4.position.y = 10+randf()*150
