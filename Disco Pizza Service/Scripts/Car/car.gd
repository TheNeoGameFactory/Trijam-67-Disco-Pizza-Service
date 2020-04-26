extends KinematicBody2D

var MAX_SPEED = 500
var ACCELERATION = 1000
var motion = Vector2.ZERO

func _ready():
	set_process(true)
#	set_process_input(true)

#func _input_event(viewport, event, shape_idx):
#	if event is InputEventMouseMotion:
#		var mouse_position = get_global_mouse_position()
#		print(mouse_position)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("car_right")) - int(Input.is_action_pressed("car_left"))
	axis.y = int(Input.is_action_pressed("car_down")) - int(Input.is_action_pressed("car_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion.y *= 0.9
	motion = motion.clamped(MAX_SPEED)

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION  * delta)
#	if (motion.x < 1 && motion.x > -1):
#		motion.y = motion.x
	motion = move_and_slide(motion)
