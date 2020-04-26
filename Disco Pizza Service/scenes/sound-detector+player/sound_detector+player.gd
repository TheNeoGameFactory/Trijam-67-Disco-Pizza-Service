extends Node

var notes_of_barrikaden_spawn = {} 
var notes_of_gegner_spawn = {}
var notes_of_schiesen = {}
var notes_of_farbaenderung = {}

var time_accurancy = 0.1


signal barrikaden_spawn_now
signal gegner_spawn_now
signal schiesen_now
signal farbaenderung_now


var oftenBarrikade = 8
var oftenGegner= 4


func _readNotes():
	read_notes("res://Music/Midi/barrikaden spawn_json.txt", notes_of_barrikaden_spawn, oftenBarrikade)
	
	read_notes("res://Music/Midi/farbaenderung_json.txt", notes_of_farbaenderung, 2)
	
	read_notes("res://Music/Midi/evtl gegner spawn_json.txt", notes_of_gegner_spawn, oftenGegner)
	
	read_notes("res://Music/Midi/schießen_json.txt", notes_of_schiesen, 1)

func _ready():
	_readNotes()
	print(notes_of_schiesen)

func add_note_to_main_array(array, note):
	var time = str(stepify(note["time"], time_accurancy))
	print(time)
	
	if !array.has(time):
		array[time]= []
		print("creating")
	
	
	array[time].append([note["midi"], note["duration"]])



func music_should_start():
		$AudioStreamPlayer.play()
		$note_timer.start(time_accurancy)
		if notes_of_barrikaden_spawn.has("0"):
			emit_signal("barrikaden_spawn_now")
		if notes_of_farbaenderung.has("0"):
			emit_signal("farbaenderung_now")
		if notes_of_gegner_spawn.has("0"):
			emit_signal("gegner_spawn_now")
		if notes_of_schiesen.has("0"):
			emit_signal("schiesen_now")

func music_should_stop():
	$AudioStreamPlayer.stop()


func _on_Timer_timeout():
	var time_of_song = str(stepify($AudioStreamPlayer.get_playback_position(), time_accurancy))
	print(time_of_song)
	if notes_of_barrikaden_spawn.has(time_of_song):
		emit_signal("barrikaden_spawn_now")
	if notes_of_farbaenderung.has(time_of_song):
		emit_signal("farbaenderung_now")
	if notes_of_gegner_spawn.has(time_of_song):
		emit_signal("gegner_spawn_now")
	if notes_of_schiesen.has(time_of_song):
		emit_signal("schiesen_now")

func read_notes(notes_path, array_to_add, scip_notes):
	var file = File.new()
	file.open(notes_path, file.READ)#"res://Music/Midi/barrikaden spawn_json.txt"
	var text = file.get_as_text()
	var sound_json = JSON.parse(text).result
	file.close()
	var scip_notes_count = scip_notes
	for track in sound_json["tracks"]:
		for note in track["notes"]:
			if scip_notes == scip_notes_count:
				add_note_to_main_array(array_to_add, note)
				scip_notes_count = 0
			scip_notes_count +=1


func _on_AudioStreamPlayer_finished():
	if oftenBarrikade>2:
		oftenBarrikade-=1
	if oftenGegner >=2:
		oftenGegner-=1
	_readNotes()
	get_tree().get_root().get_node("main_level/Demo Level").health+=25
	get_tree().get_root().get_node("main_level/Demo Level").increaseRoundLabel()
	
	var timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout", self, "_timer_callback")
	timer.start()
	pass # Replace with function body.
	
func _timer_callback():
	$AudioStreamPlayer.play()
