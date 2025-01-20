extends Panel
#@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_text : RichTextLabel = get_node("text")
@onready var talk_button : Button = get_node("Talk")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("gg")
	pass # Replace with function body.
func initalize_with_npc (npc):
	dialogue_text.text = ""
	talk_button.disabled = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_talk_pressed():
	dialogue_text.text = "Hmm.."
