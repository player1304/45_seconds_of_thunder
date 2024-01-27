extends Node2D


func _ready():
	var current_score : int = Globals.score
	var min_score : int = Globals.saved_params.high_scores.min()
	$ScoreLabel.text = "Your score is: " + str(current_score)
	$GameOverSound.play()
	
	if current_score > min_score:
		Globals.saved_params.high_scores.append(current_score)
		Globals.saved_params.high_scores.sort_custom(func(a,b): return a>b) # descending
		Globals.saved_params.high_scores.pop_back() # remove last score from highscores
		
		# 1 upgrade for every 5 above min
		var new_ups : int = (current_score - min_score) / 5
		Globals.saved_params.upgrades += new_ups # decimal discarded
		$NewUpgradesLabel.text = "New upgrade points awarded: " + str(new_ups)
	else:
		$NewUpgradesLabel.text = ""

	Globals.save_game()

func _unhandled_input(_event):
	if Input.is_action_just_released('ui_accept'):
		_on_new_game_button_button_up()
		
func _on_new_game_button_button_up():
	get_tree().change_scene_to_file("res://start_game.tscn")
