extends HBoxContainer

var heart_full = preload("res://assets/hud_heartFull.png")
var heart_half = preload("res://assets/hud_heartHalf.png")
var heart_empty = preload("res://assets/hud_heartEmpty.png")

func _process(_delta):
	var life = Globals.player_life
	for i in get_child_count():
		if life > i * 2 + 1:
			get_child(i).texture = heart_full
		elif life > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
