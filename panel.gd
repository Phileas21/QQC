extends Panel
signal son
var time0 = 0
var parle = false
var etapedialogue = 0
var txt1 = ["L'heure de quoi ?","Bien entendu !","Discuter"]
var txt2 = ["Bonjour, l'heure est venue jeune apprenti","Du 3ème petit déjeuner évidemment..."]
#@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_text : RichTextLabel = get_node("text")
@onready var talk_button : Button = get_node("Talk")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 
	
func initalize_with_npc (npc):
	dialogue_text.text = ""
	talk_button.disabled = true

func _process(delta: float) -> void:
	if parle == true:
		if Time.get_ticks_msec()>time0+3000 and etapedialogue == 0:
			dialogue_text.text = "Bonjour, l'heure est venue jeune apprenti"
	for i in range (0,len(txt1)):
		if parle == true:
			if Time.get_ticks_msec()>time0+3000 and etapedialogue == i:
				talk_button.text = txt1[i]
				etapedialogue += 1
				emit_signal("son")
				parle = false
	#if parle == true:
	#	if Time.get_ticks_msec()>time0+5000 and etapedialogue == 1:
	#		talk_button.text = "Bien entendu !"
	#		etapedialogue += 1
	#		parle = false

func _on_talk_pressed():
	if parle == false:
		time0 = Time.get_ticks_msec()
		for i in range(0,len(txt2)):
			if etapedialogue == i:
				dialogue_text.text = txt2[i]
				parle = true
				break
			if etapedialogue == len(txt2):
				dialogue_text.text = "..."
				talk_button.text = "Discuter"
				parle = false
				etapedialogue = 0
