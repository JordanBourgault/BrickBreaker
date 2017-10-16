extends Node

func _ready():
	if (global.items_state == true):
		get_node(".").get_node("CheckButton").set_pressed(true)
	else:
		get_node(".").get_node("CheckButton").set_pressed(false)


func _on_CheckButton_toggled( pressed ):
	global.items_state = not(global.items_state)
	print(str(global.items_state))
	


func _on_Button_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")
