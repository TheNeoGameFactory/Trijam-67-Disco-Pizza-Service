extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target=Vector2(0,0)
var t=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(_startPos, _target):
	position = _startPos
	target = _target
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.linear_interpolate(target,t)
	t+=delta*1.5
	if position == target:
		queue_free()
	pass
