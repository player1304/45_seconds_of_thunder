extends Node2D


func _on_start_button_button_up():
	Globals.reset_values() # reset life, etc. to default
	get_tree().change_scene_to_file("res://main.tscn")

func _unhandled_input(_event):
	if Input.is_action_just_released('ui_accept'):
		_on_start_button_button_up()
