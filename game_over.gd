extends Node2D


func _ready():
	$ScoreLabel.text = "Your score is: " + str(Globals.score)


func _on_new_game_button_button_up():
	get_tree().change_scene_to_file("res://start_game.tscn")
