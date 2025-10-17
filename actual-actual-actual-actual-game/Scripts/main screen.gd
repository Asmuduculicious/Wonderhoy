extends Control

# If they want to play they can get into it if they don't they can quit

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
