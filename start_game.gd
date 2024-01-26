extends Node2D

func _ready():
	reset_game_vars()
	load_game()
	
	# update high score board
	var score_labels : Array[Node] = [%Score0, %Score1, %Score2, %Score3, %Score4]
	var high_scores = Globals.high_scores
	high_scores.sort_custom(func(a,b): return a>b)
	for i in range(0,5):
		if high_scores.size() < (i+1): # not enough high scores
			high_scores.append(0)

		score_labels[i].text = str(i+1) + ": " + str(high_scores[i])

func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://main.tscn")

func _unhandled_input(_event):
	if Input.is_action_just_released('ui_accept'):
		_on_start_button_button_up()

func load_game():
	"""load game settings and high scores from save file"""
	var save_path = Globals.save_path
	var saved_params : Array = [Globals.high_scores, Globals.bullet_speed_player, 
							Globals.player_bullet_strength, Globals.player_shield_max_strength]
	
	if FileAccess.file_exists(save_path):
		print("found save file")
		var file = FileAccess.open(save_path, FileAccess.READ)
		for v in saved_params: # TODO URGENT 没有真的load上？第一次打开程序会出问题
			# v是variables的内容，没有直接调用variable本身
			print(file.get_var())
			print("loaded " + str(v))
			
	else:
		print("save file not found")

func reset_game_vars():
	"""reset game variables"""
	Globals.player_life = 10
	Globals.score = 0
