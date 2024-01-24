# enemy_default
extends CharacterBody2D

@export var Bullet : PackedScene
var screensize = Globals.SCREEN_SIZE
var speed = 10
var hp = 100

func _physics_process(delta):
	position.x -= speed * delta # will automatically go left
	# TODO make the boss oscillate from top to bottom and back to top
	if position.x <= 0: # out of bound
		self.queue_free()

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
		hp -= Globals.player_bullet_strength
		#print("PlayerBullet hit me! My hp now at: " + str(hp))
	
	if self.hp <= 0:
		Globals.score += 10 # boss has a higher score
		#print("Enemy killed, global score: " + str(Globals.score))
		self.queue_free()
