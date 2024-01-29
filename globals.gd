extends Node2D

#const SCREEN_SIZE = Vector2(960,640)

# per game variables, should be reset each game
var game_remaining_time : float # updated by GameTimer in Main
var score : int
var player_life : int

var save_path = "user://savefile"
var saved_params : Dictionary = {"high_scores": [0,0,0,0,0], 
								"bullet_speed_player": 500, 
								"player_bullet_strength": 10, 
								"player_shield_max_strength": 2,
								"upgrades": 0}

# the current viewport size, updated in _process
var screensize

func _process(_delta):
	screensize = get_viewport().get_visible_rect().size

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(saved_params, true)
	print("Game saved")


