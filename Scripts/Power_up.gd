extends RigidBody2D

var number_of_powers = 5

func _ready():
	randomItems()
	set_fixed_process(true)



#Function that produces the random numbers for the type of Power-Up. It also sets the correct texture and adds the node to the right group. It also sets a random speed between 300 and 500.
func randomItems():
	randomize()
	var power_number = randi()%number_of_powers + 1
	var speed_number = randi()%300 + 200
	get_node(".").get_node("Sprite").set_texture(load("res://Textures/Power" + str(power_number) + ".png"))
	get_node(".").set_linear_velocity(Vector2(0, speed_number))
	get_node(".").add_to_group("Power" + str(power_number))


func _fixed_process(delta):
	#Clear the reamaining Power-ups when the stage finishes
	if global.win == true:
		queue_free()

	var bodies = get_colliding_bodies()
	#Check if the power-up collides with the paddle
	for body in bodies:
		if body.get_name() == "Paddle":
			#Effect when the Power1 (bigger paddle) hits the Paddle
			if get_node(".").is_in_group("Power1"):
				var scale = get_node("/root/World/Paddle/Sprite").get_scale()
				if (scale.x < 2.2):
					var new_scale = Vector2(0.4 + scale.x, scale.y)
					get_node("/root/World/Paddle/Sprite").set_scale(new_scale)
					get_node("/root/World/Paddle/CollisionShape2D").set_scale(new_scale)
					
			#Effect when the Power2 (smaller Paddle) hits the Paddle
			if get_node(".").is_in_group("Power2"):
				var scale = get_node("/root/World/Paddle/Sprite").get_scale()
				if (scale.x > 0.4):
					var new_scale = Vector2(-0.3 + scale.x, scale.y)
					get_node("/root/World/Paddle/Sprite").set_scale(new_scale)
					get_node("/root/World/Paddle/CollisionShape2D").set_scale(new_scale)
					
			#Effect when the Power3 (smaller ball) hits the Paddle
			if get_node(".").is_in_group("Power3"):
				var ball_paths = global.getBalls()
				if ball_paths.size() != 0:
					for child in ball_paths:
						var scale = get_node(child).get_node("Sprite").get_scale()
						if (scale.x > 0.5):
							var new_scale = Vector2(-0.5 + scale.x, -0.5 + scale.y)
							get_node(child).get_node("Sprite").set_scale(new_scale)
							get_node(child).get_node("CollisionShape2D").set_scale(new_scale)

			#Effect when the Power4 (bigger ball) hits the Paddle
			if get_node(".").is_in_group("Power4"):
				var ball_paths = global.getBalls()
				if ball_paths.size() != 0:
					for child in ball_paths:
						var scale = get_node(child).get_node("Sprite").get_scale()
						if (scale.x < 4):
							var new_scale = Vector2(1 + scale.x, 1 + scale.y)
							get_node(child).get_node("Sprite").set_scale(new_scale)
							get_node(child).get_node("CollisionShape2D").set_scale(new_scale)

			#Effect when the Power5 (Double Balls) hits the Paddle
			if get_node(".").is_in_group("Power5"):
				var ball_paths = global.getBalls()
				if ball_paths.size() != 0:
					for child in ball_paths:
						var Ball = load("res://Ball.tscn").instance()
						Ball.set_pos(get_node(child).get_pos())
						var ball_velocity = get_node(child).get_linear_velocity()
						var ball_speed = ball_velocity.length()
						var ball_angle = 90
						
						#Calculate the direction of the ball and verify if we need to add 180 deg
						if (ball_velocity.x > 0):
							ball_angle = atan(-ball_velocity.y/ball_velocity.x)
						else:
							ball_angle = PI + atan(-ball_velocity.y/ball_velocity.x)
						
						#Change course for the original ball
						get_node(child).set_linear_velocity(Vector2(ball_speed * cos(ball_angle + PI/8), -ball_speed * sin(ball_angle + PI/8)))

						#Set course for new ball
						Ball.set_linear_velocity(Vector2(ball_speed * cos(ball_angle - PI/8), -ball_speed * sin(ball_angle - PI/8)))
						get_tree().get_root().add_child(Ball)
						global.number_of_balls += 1

			#Clear the Power-Up after it touches the Paddle
			queue_free()

	#Destroy the power up when it exits the viewport (if the player doesn't pick it up)
	if get_pos().y > get_viewport_rect().end.y:
		queue_free()
		