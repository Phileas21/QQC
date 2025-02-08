class_name LootTable
extends Resource

#créer un fichier txt pour chaque table... (items+poids)

@export var junk_table := [
	"res://scenes/GUI/Inventory/Resources/coal.tres",
	"res://scenes/GUI/Inventory/Resources/dirt.tres",
	"res://scenes/GUI/Inventory/Resources/scrap.tres"
]#Item+Poids

@export var total_weight=0

func _ready():
	for i in junk_table.size():
		total_weight+=1

func _generate_loot(n_min:int,n_max:int): #génère n items au pif, entre n_min & n_max
	var loot=[]
	var n=randi_range(n_min,n_max)
	for i in n:
		loot.append(junk_table[randi_range(1,3)])
	
	return loot
