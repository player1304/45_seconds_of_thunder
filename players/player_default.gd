# player_default
extends CharacterBody2D

@export var Bullet : PackedScene
var shield_strength : int = Globals.saved_params.player_shield_max_strength
var screensize = Globals.screensize
var speed = 300
var dragging = false
@onready var last_position : Vector2 = get_viewport().get_mouse_position()
	
func _physics_process(delta):
	var v : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += v * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if Input.is_action_pressed('LMB'):
		dragging = true
		var current_position : Vector2 = get_viewport().get_mouse_position()
		velocity.x = (current_position.x - last_position.x) * speed * delta
		velocity.y = (current_position.y - last_position.y) * speed * delta
		
	if Input.is_action_just_released('LMB'):
		dragging = false
		velocity = Vector2.ZERO
	
	last_position = position
	
	move_and_slide()
		
	# if player life <=0, end game
	if Globals.player_life <= 0:
		print("Game over")
		get_tree().change_scene_to_file("res://game_over.tscn")
	


func _process(_delta):
	if shield_strength <= 0:
		$ShieldHitBox/ShieldAnimation.modulate.a = 0.01 # almost invisible

	# animation
	if Input.is_action_just_pressed('ui_up'):
		$AnimatedSprite2D.play("up")
	elif Input.is_action_just_pressed('ui_down'):
		$AnimatedSprite2D.play("down")


func shoot():
	var muzzles : Array[Node] = $Muzzles.get_children()
	for m in muzzles:
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.speed = Globals.saved_params.bullet_speed_player
		b.transform = m.global_transform
		b.add_to_group("PlayerBullets")

func _on_firing_freq_timeout():
	shoot()
	#print("bullet firing cancelled for debug")
	$BulletSound.play()


func _on_player_hit_box_area_entered(area):
	if area.name == "EnemyHitBox": # Collided with enemy
		print("Player collided with enemy.")
		Globals.player_life = 0
	elif area.is_in_group("EnemyBullets"): # Hit by bullet
		if shield_strength <= 0: # no shield, take HP hit
			Globals.player_life -= 1
			#print("Player Hit! life: " + str(Globals.player_life))
		else: # reduce shield
			shield_strength -= 1
			print("Shield hit! shield at: " + str(shield_strength))


func _on_shield_restore_timer_timeout():
	if shield_strength < Globals.saved_params.player_shield_max_strength: # shield replenishes automatically
		shield_strength += 1
	else: # return shield transparency
		$ShieldHitBox/ShieldAnimation.modulate.a = 0.5 # normal
