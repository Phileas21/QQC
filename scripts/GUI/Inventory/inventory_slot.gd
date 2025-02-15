class_name InventorySlot
extends PanelContainer

@export var type:ItemData.Type
#VAR JOUEUR

#FUNC _READY():
	#PLAYER = GET_TREE().GET_NODES_IN_GROUP("Player")

func init(t: ItemData.Type, cms:Vector2)->void:
	type=t
	custom_minimum_size=cms
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:#vérifie si on peut dropt un item dans un slot
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count()==0: #rien dans le slot
				return true
			else:
				if type == data.get_parent().type:
					return true
				return get_child(0).data.type ==data.data.type
		else:
			return data.data.type== type
	return false 

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count()>0: #déja un item ds le slot
		var item:= get_child(0) 
		####JOUEUR.STAT -=ITEM.STAT
		if item ==data:
			return 
		item.reparent(data.get_parent()) #Change le noeud auquel appartient l'item
	if type != ItemData.Type.MAIN:
		pass#A REMPLACER
		####JOUEUR.STAT +=ITEM.STAT (data.data.item_damage)
	data.reparent(self)
