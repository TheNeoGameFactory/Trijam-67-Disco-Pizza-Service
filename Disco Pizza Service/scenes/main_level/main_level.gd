extends Node2D


signal music_stoped
signal music_started

onready var pizzaGeschoss =preload("res://scenes/Geschoss/PizzaGeschoss.tscn")
onready var gegner = preload("res://scenes/Enemys/Enemy.tscn")
onready var barrikade = preload("res://scenes/Barrikade/Barrikade.tscn")




func _on_start_music_button_down():
	emit_signal("music_started")
	$PizzaGeschoss.queue_free()
	$"Demo Level".show()
	$start_music.hide()

func _ready():
	randomize()


func _on_stop_music_button_down():
	emit_signal("music_stoped")


func _on_sound_detectorplayer_barrikaden_spawn_now():
	var barri = barrikade.instance()
	get_node("Demo Level").add_child(barri)
	var random_number = randi()%3+1
	barri.position = get_node("Demo Level/Spawpunkte Barrikaden/"+str(random_number)).position
	pass

func _on_sound_detectorplayer_farbaenderung_now():
	$AnimationPlayer.play("blink_colorRect")
	pass

func _on_sound_detectorplayer_gegner_spawn_now():
	var enemy = gegner.instance()
	get_node("Demo Level").add_child(enemy)
	var random_number = randi()%7+1
	enemy.position = get_node("Demo Level/Spawnpunkte Gegner/"+str(random_number)).position

func _on_sound_detectorplayer_schiesen_now():
	#$AnimationPlayer.play("blink_colorRect")
	var pizza = pizzaGeschoss.instance()
	var origin = $"Demo Level/Car".position
	add_child(pizza)
	pizza.init(origin,get_global_mouse_position())
	pass
