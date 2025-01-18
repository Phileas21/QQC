extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_2_damage(pv) -> void:
	if pv>0:
		self.value = pv
	else:
		self.value = 0
