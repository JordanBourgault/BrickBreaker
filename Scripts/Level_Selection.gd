extends Node


func _on_2_pressed():
	global.level_complete = 0
	get_tree().change_scene("res://Main_game.tscn")

func _on_TextureButton_pressed():
	global.level_complete = 1
	get_tree().change_scene("res://Main_game.tscn")


func _on_TextureButton1_pressed():
	global.level_complete = 2
	get_tree().change_scene("res://Main_game.tscn")


func _on_TextureButton2_pressed():
	global.level_complete = 3
	get_tree().change_scene("res://Main_game.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")


func _on_04_pressed():
	global.level_complete = 4
	get_tree().change_scene("res://Main_Menu.tscn")
