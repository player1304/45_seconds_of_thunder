# bullet of enemies
extends Area2D

var speed = 100
signal player_hit

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_player_hit():
	# life reduce is done in player_default
	self.queue_free() # bullet goes away after hit player

func _on_area_entered(area):
	if area.is_in_group("PlayerBullets"):
		#print("Bullet cancelled")
		self.queue_free()
	elif area.name == "PlayerHitBox":
		player_hit.emit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	# check if out of screen, then queue_free
	self.call_deferred("queue_free")
	#print("enemy bullet out")
