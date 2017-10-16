extends KinematicBody2D

var rotation = -0.02

func _ready():
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	rotate(rotation)
	if ((get_rotd() < -60) and (rotation < 0)) or ((get_rotd() > 60) and (rotation > 0)):
		rotation = -rotation
		