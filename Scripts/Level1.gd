extends TextureButton


func _on_Next_Level_pressed():
	global.level_complete += 1
	get_tree().change_scene("res://Main_game.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")