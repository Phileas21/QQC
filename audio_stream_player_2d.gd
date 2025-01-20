#extends Node

Preload your audio file
var music = preload("res://assets/sons/Enregistrement.mp3")

func _ready():
 $AudioStreamPlayer.stream = music
 $AudioStreamPlayer.play() 
