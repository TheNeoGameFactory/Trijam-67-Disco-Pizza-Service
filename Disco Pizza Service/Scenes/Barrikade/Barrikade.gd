extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2(-8,0))
	pass


func _on_Barrikade_body_entered(body):
	if body.get_name() == "Car":
		get_parent().health-=1
		queue_free()
	pass # Replace with function body.
