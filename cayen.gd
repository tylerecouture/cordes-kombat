extends KinematicBody2D

var health = 100
var attacking = false
var can_move = true
var knockback = 0
var can_hit = true
var other_character : Node2D
var player_number : int
var velocity := Vector2.ZERO
var speed = 600
var Cayen_cloud = preload("res://Cayen_cloud.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	
	rng.randomize()
	
	$HealthBar.max_value = health
	
	$AnimatedSprite.position.x = 0
	
	
	if player_number == 1:
		other_character = Global.player_2
	else:
		other_character = Global.player_1

func _physics_process(delta):
	if is_instance_valid(other_character):
		if health <= 0:
			$Health_bar.hide()
			$AnimatedSprite.play("explosion")
			yield($AnimatedSprite , "animation_finished")
			queue_free()
		
		if knockback > 0:
			knockback -= 1
			if other_character.get_node("AnimatedSprite").flip_h == false:
				global_position.x += 25
			else:
				global_position.x -= 25
		elif not attacking:
			can_move = true
		
		if can_move:
			if player_number == 1:
				velocity.x = Input.get_axis("Player_1_move_left" , "player_1_move_right") * speed
			else:
				velocity.x = Input.get_axis("player_2_move_left" , "player_2_move_right") * speed
		
		move_and_slide(velocity , Vector2.UP)
		
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = false
		
		if player_number == 1 and Input.is_action_just_pressed("player_1_attack") and can_hit:
			attack()
		elif player_number == 2 and Input.is_action_just_pressed("player_2_attack") and can_hit:
			attack()
		
		$HealthBar.value = health

func attack():
	for i in range(30):
		var cayen_cloud = Cayen_cloud.instance()
		cayen_cloud.global_position = Vector2(rng.randf_range(0,1920) , 100)
		cayen_cloud.other_character = other_character
		get_parent().add_child(cayen_cloud)
		$laugh_timer.start()

func hit():
	$hit.play()




func _on_cry_timer_timeout():
	$attack.play()
