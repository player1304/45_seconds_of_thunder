extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTimer.start() # 45s
	$BossTimer.start() # 20s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Globals.game_remaining_time = int($GameTimer.get_time_left())


func _on_boss_timer_timeout():
	print("boss should appear")


func _on_game_timer_timeout():
	print("game over (due to time out)")
