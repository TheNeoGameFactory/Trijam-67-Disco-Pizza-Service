extends KinematicBody2D


var car_pos = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var random_rotation

func _ready():
	rng.randomize()
	random_rotation = rng.randf_range(-5.0, 5.0)


func _physics_process(delta):
	car_pos = get_node("../Car").position
	
	self.look_at(car_pos)
	self.rotation_degrees += 90 + random_rotation
	var way_to_move = Vector2(0,-100).rotated(self.rotation)
	move_and_slide(way_to_move)
	

