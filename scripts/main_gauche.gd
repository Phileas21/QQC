extends Sprite2D


@onready var lance: Sprite2D = $lance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var trans = get_global_transform().inverse()
	var relative_pos = trans*mouse_pos
	var angle = relative_pos.angle()
	lance.rotation = angle + PI/2
