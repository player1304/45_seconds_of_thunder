extends Node2D


func _ready():
	var current_score : int = Globals.score
	var min_score : int = Globals.high_scores.min()
	$ScoreLabel.text = "Your score is: " + str(current_score)
	$GameOverSound.play()
	
	if current_score > min_score:
		print("TODO new high score")
		Globals.high_scores.append(current_score)
		Globals.high_scores.sort_custom(func(a,b): return a>b) # descending
		Globals.high_scores.pop_back() # remove last one
		#print(Globals.high_scores)

	Globals.save_game()

func _unhandled_input(_event):
	if Input.is_action_just_released('ui_accept'):
		_on_new_game_button_button_up()
		
func _on_new_game_button_button_up():
	get_tree().change_scene_to_file("res://start_game.tscn")
