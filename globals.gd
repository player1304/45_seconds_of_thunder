extends Node2D

const SCREEN_SIZE = Vector2(960,640)

# per game variables, should be reset each game
var game_remaining_time : float # updated by GameTimer in Main
var score : int
var player_life : int

var save_path = "res://savefile"
var saved_params : Dictionary = {"high_scores": [], 
								"bullet_speed_player": 500, 
								"player_bullet_strength": 10, 
								"player_shield_max_strength": 2}

var high_scores : Array = saved_params["high_scores"]

# player upgradable settings
var bullet_speed_player : int = saved_params["bullet_speed_player"]
var player_bullet_strength : int = saved_params["player_bullet_strength"]
var player_shield_max_strength : int = saved_params["player_shield_max_strength"]

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for v in saved_params: # TODO URGENT 这个肯定不对
		file.store_var(v)
		print("saved " + str(v))


