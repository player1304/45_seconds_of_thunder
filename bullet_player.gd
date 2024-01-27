# bullet of player
extends Area2D

var speed = Globals.saved_params.bullet_speed_player # can be updated when instantiated
signal enemy_hit

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		enemy_hit.emit()

func _on_area_entered(area):
	if area.is_in_group("EnemyBullets"):
		#print("PlayerBullet cancelled")
		self.queue_free()


func _on_enemy_hit():
	# currently enemy hit is treated by Enemy(enemy_default) and not the player's bullet
	self.queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	# check if out of screen, then queue_free
	self.call_deferred("queue_free")
	#print("playerbullet out")
