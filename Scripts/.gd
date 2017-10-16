extends KinematicBody2D

const ball_scene = preload("res://Ball.tscn")

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	
	var y = get_pos().y
	var x = get_viewport().get_mouse_pos().x
	
	set_pos(Vector2(x, y))


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		var ball = ball_scene.instance()
		
		if not get_tree().get_root().has_node("Ball"):
			
			ball.set_pos(get_pos() + Vector2(0, -10))
			
			var rot = 2 * PI - get_node("Pointer").get_rot()
			var y_speed = global.ball_speed * cos(rot)
			var x_speed = global.ball_speed * sin(rot)
			
			get_tree().get_root().add_child(ball)
			global.number_of_balls += 1
			ball.set_linear_velocity(Vector2(x_speed, -y_speed))
			get_node("Pointer").queue_free()

	if event.is_action("Pause"):
		get_tree().set_pause(true)
		
		var pause_screen = load("res://Pause_Screen.tscn").instance()
		get_tree().get_root().add_child(pause_screen)