extends Node

var score = 0 setget set_score
var bricks_destroyed = 0 setget set_bricks_destroyed
var lives = 3 setget set_lives


func _ready():
	#Win is used to dictate when the power-ups are clearedd on screen
	global.win = false
	if global.level_complete <= global.number_of_levels:
		play_level(global.level_complete)
	else:
		play_level(0)


func set_bricks_destroyed(value):
	bricks_destroyed = value
	
	if bricks_destroyed == global.number_of_bricks:
		global.win = true
		global.number_of_balls = 0
		
		#Clear all the balls (Even if there are more than 1)
		for child in global.getBalls():
			get_node(child).queue_free()
		
		#Clear the bricks in case there was an error in the collisions
		for node in get_tree().get_root().get_children():
			if node.is_in_group("BRICKS"):
				node.queue_free()

		#Load the Win scene
		get_tree().change_scene("res://You_Win_1.tscn")


func set_score(value):
	score = value
	get_node("Score").set_text("Score : " + str(score))


func set_lives(value):
	lives = value
	get_node("Lives").set_text("Lives : " + str(lives))


func play_level(lvl_number):
	global.number_of_lives = 3
	var lvl_name = "res://Levels/Level_" + str(lvl_number) + "_bricks.tscn"
	var level = load(lvl_name)
	level = level.instance()
	get_tree().get_root().add_child(level)
	global.number_of_bricks = level.get_child_count()