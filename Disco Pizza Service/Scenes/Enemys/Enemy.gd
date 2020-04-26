extends Area2D


var car_pos = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var random_rotation

func _ready():
	rng.randomize()
	random_rotation = rng.randf_range(-5.0, 5.0)
	self.position = Vector2(200,200)
	self.scale = Vector2(0.145,0.145)

func _physics_process(delta):
	car_pos = get_node("../Car").position
	
	self.look_at(car_pos)
	self.rotation_degrees += 90 + random_rotation
	var way_to_move = Vector2(0,-2).rotated(self.rotation)
	if get_parent().visible:
		self.position += way_to_move




func _on_Enemy_body_entered(body):
	if body.name == "Car":
		get_parent().health-=1
	self.queue_free()
