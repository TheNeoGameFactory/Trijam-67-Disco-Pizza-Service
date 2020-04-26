extends Node2D


var health = 20
var currentRound=1

func _process(delta):
	$Label.text = str(health)
	if health == 0:
		get_tree().reload_current_scene()

func increaseRoundLabel():
	currentRound+=1
	$Round.text = "Round: "+str(currentRound)
