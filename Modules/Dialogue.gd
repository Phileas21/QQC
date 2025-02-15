class_name Dialogue
# La classe permettant de décrire un dialogue
enum Orateur
{
	JOUEUR,
	PNJ,
	FIN_DE_DIALOGUE,
}

# Qui parle:
var orateur : Orateur
	
# Des lignes de dialogue si c'est le PNJ,
# Des choix de réponses si c'est le joueur:
var lignes : Array[String] 
	
# Clés dans le dictionnaire des prochains dialogues:
var clé_suivants : Array[String]
