extends TextureButton



func _on_Select_Level_pressed():
	get_tree().change_scene("res://Select_Level.tscn")


func _on_TextureButton_2_pressed():
	get_tree().change_scene("res://Options.tscn")
