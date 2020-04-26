extends Node2D


var health = 5

func _process(delta):
	$Label.text = str(health)
	if health == 0:
		get_tree().reload_current_scene()
