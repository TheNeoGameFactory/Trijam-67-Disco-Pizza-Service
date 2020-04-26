extends Node2D


signal music_stoped
signal music_started

onready var pizzaGeschoss =preload("res://scenes/Geschoss/PizzaGeschoss.tscn")
onready var gegner = preload("res://scenes/Enemys/Enemy.tscn")




func _on_start_music_button_down():
	emit_signal("music_started")
	$PizzaGeschoss.queue_free()
	$"Demo Level".show()
	$start_music.hide()




func _on_stop_music_button_down():
	emit_signal("music_stoped")


func _on_sound_detectorplayer_barrikaden_spawn_now():
	#$AnimationPlayer.play("blink_colorRect")
	pass

func _on_sound_detectorplayer_farbaenderung_now():
	$AnimationPlayer.play("blink_colorRect")
	pass

func _on_sound_detectorplayer_gegner_spawn_now():
	var enemy = gegner.instance()
	get_node("Demo Level").add_child(enemy)


func _on_sound_detectorplayer_schiesen_now():
	#$AnimationPlayer.play("blink_colorRect")
	var pizza = pizzaGeschoss.instance()
	var origin = $"Demo Level/Car".position
	add_child(pizza)
	pizza.init(origin,get_global_mouse_position())
	pass
