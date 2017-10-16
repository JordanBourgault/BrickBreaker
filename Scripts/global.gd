extends Node

var number_of_levels = 3
var level_complete = 1
var number_of_bricks = 2
var number_of_lives = 3
var ball_speed = 400
var number_of_balls = 0
var win = false
var items_state = true


func getBalls():
	var balls = []
	if get_tree().get_root() != null:
			var children = get_tree().get_root().get_children()
			for child in children:
				if child.is_in_group("Ball"):
					balls.append(child.get_path())
	return balls