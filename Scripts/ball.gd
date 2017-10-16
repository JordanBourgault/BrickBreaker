extends RigidBody2D

const SPEEDUP = 6
const MAXSPEED = 800
const MINSPEED = 400

func _ready():
	randomize()
	set_fixed_process(true)
	
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		#Detect the contacts with the bricks and destroy them after the contact
		if body.is_in_group("Bricks"):
			get_node("/root/World/SamplePlayer").play("Brick_Hit")
			body.queue_free()
			get_node("/root/World").score += 5
			get_tree().get_root().get_node("World").bricks_destroyed += 1
			
			#Random chance to get a power up
			if (global.items_state == true):
				if (randi()%10 <= 5):
					var power = load("res://Power_up.tscn").instance()
					get_tree().get_root().add_child(power)
					power.set_pos(body.get_pos())
			
		#Detect the contact with the tough bricks
		if body.is_in_group("Tough_Bricks") or body.is_in_group("Tough_Round_Bricks"):
			get_node("/root/World").score += 5
			for child in body.get_children():
				if child.get_type() == "Sprite":
					#Detect if the brick is rectangular
					if body.is_in_group("Tough_Bricks"):
						child.set_texture(load("res://Textures/Brick_2_Broken.png"))
						body.remove_from_group("Tough_Bricks")
					#Detect if the brick is round
					else:
						child.set_texture(load("res://Textures/Round_Brick_2_Broken.png"))
						body.remove_from_group("Tough_Round_Bricks")
			#Set the froup to bricks so it can be dectroyed on the next hiy
			body.add_to_group("Bricks")
			get_node("/root/World/SamplePlayer").play("Brick_Hit")
		
		#Decect the contact with the paddle and calculate the resulting velocity and direction of the ball
		if body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Anchor").get_global_pos()
			var velocity = max(min(speed + SPEEDUP, MAXSPEED), MINSPEED) * direction.normalized()
			set_linear_velocity(velocity)
			get_node("/root/World/SamplePlayer").play("Hit")

	#Destroy the ball if it gets out of the viewport
	if get_pos().y > get_viewport_rect().end.y:
		queue_free()
		global.number_of_balls -= 1
		get_node("/root/World/SamplePlayer").play("Death")
		
		#Detect if there are more than 1 balls (to check if a life needs to be removed)
		if global.number_of_balls <= 0:
			global.number_of_lives -= 1
			get_node("/root/World/Lives").set_text("Lives : " + str(global.number_of_lives))
			var pointer = load("res://Pointer.tscn").instance()
			get_node("/root/World/Paddle").add_child(pointer)
		
		#Detect if there are any lives left to play the Game Over screen
		if global.number_of_lives <= 0:
			get_tree().get_root().get_node("Bricks" + str(global.level_complete)).queue_free()
			get_tree().change_scene("res://Game_Over.tscn")