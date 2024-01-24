extends Node2D

const SCREEN_SIZE = Vector2(960,640)

var bullet_speed_player : int
var game_remaining_time : float # updated by GameTimer in Main
var player_bullet_strength : int
var player_life : int
var player_shield_max_strength : int = 2
var score : int

func _ready():
	reset_values()

func reset_values():
	bullet_speed_player = 500
	player_bullet_strength = 10
	player_life = 10
	score = 0
