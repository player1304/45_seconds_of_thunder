# enemy_default
extends CharacterBody2D

@export var Bullet : PackedScene
var boss_in_which_half : int
var screensize = Globals.screensize
var speed = 20
var hp = 400

func _physics_process(delta):
	position.x -= speed * delta # will automatically go left
	if position.x <= 0: # out of bound
		self.queue_free()
	
	# make the boss oscillate from top to bottom and back to top
	if $OsciTimer.is_stopped() == true: # timer not running
		boss_in_which_half = check_which_half()
		#print("boss in which half?" + str(boss_in_which_half))
		var osci_int : int = randi_range(2, 5) # random osci interval
		$OsciTimer.wait_time = osci_int
		#print("how long to osci? " + str(osci_int))
		$OsciTimer.start()
		#print("Timer started")
	else: # timer is running
		position.y += boss_in_which_half * speed * delta
		position.y = clamp(position.y, 50, screensize.y - 50)
		#print("Going up (-1) or down (1): " + str(boss_in_which_half))

func shoot():
	# traverse muzzles and instantiate the bullet
	var MainScene = self.find_parent("Main")
	var muzzles : Array[Node] = $Muzzles.get_children()
	for m in muzzles:
		var b = Bullet.instantiate()
		MainScene.add_child(b)
		b.transform = m.global_transform
		b.add_to_group("EnemyBullets")

func _on_firing_freq_timeout():
	# call shoot automatically
	shoot()

func _on_area_2d_area_entered(area):
	if area.is_in_group("PlayerBullets"):
		hp -= Globals.saved_params.player_bullet_strength
		#print("PlayerBullet hit me! My hp now at: " + str(hp))
	
	if self.hp <= 0:
		Globals.score += (5 + Globals.game_remaining_time) # boss has a higher score
		print("Boss killed")
		
		print("TODO 有error，可能需要emit一个signal然后再退出")
		self.queue_free()
		get_tree().change_scene_to_file("res://game_over.tscn")

func check_which_half():
	'''check if the boss is in the upper (1) or lower half (-1)'''
	if position.y < screensize[1] / 2:
		return 1 # upper
	else:
		return -1 # lower
	
