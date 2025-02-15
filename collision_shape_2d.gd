extends CollisionShape2D
var costheta
var sintheta
var x
var y
@onready var player = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_joueur_direction_2(b) -> void:
	x = b.x - (player.position.x)#+235.4)/0.4
	y = b.y - (player.position.y)#+64.44)/0.4
	costheta = x/(sqrt(x*x+y*y))
	sintheta = y/(sqrt(x*x+y*y))
	#print(costheta)
	#print(sintheta)
	self.position.x = costheta*50
	self.position.y = sintheta*50
