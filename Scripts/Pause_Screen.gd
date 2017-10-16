extends Node


func _ready():
	set_process_input(true)


func _input(event):
	if event.is_action("Pause"):
		get_tree().set_pause(false)