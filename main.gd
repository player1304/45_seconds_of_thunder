extends Node2D

# for RNG to pick from
var enemy0 = preload("res://enemies/enemy_default.tscn")
var enemy_list = [enemy0]

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTimer.start() # 45s
	$BossTimer.start() # 30s
	#$EnemyTimer.start() # every 1.5 seconds, will start auto

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Globals.game_remaining_time = int($GameTimer.get_time_left())


func _on_boss_timer_timeout():
	print("boss should appear, no new enemies")
	$EnemyTimer.stop() # no new enemies
	randomize()
	spawn_boss()

func _on_game_timer_timeout():
	print("game over (due to time out)")
	get_tree().change_scene_to_file("res://game_over.tscn")


func _on_enemy_timer_timeout():
	#print("a new enemy is out")
	randomize()
	spawn_enemy()
	

func spawn_enemy():
	# pick a random enemy from enemy_list
	var enemy_picked = enemy_list[randi_range(0, len(enemy_list) - 1)]
	print("there are this many enemies in the list: " + str(len(enemy_list)))
	var e = enemy_picked.instantiate()
	e.position.x = Globals.SCREEN_SIZE[0] - 25
	e.position.y = randi_range(25, int(Globals.SCREEN_SIZE[1]) - 25)
	add_child(e)
	e.add_to_group("Enemies")

func spawn_boss():
	pass
