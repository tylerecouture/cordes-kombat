extends KinematicBody2D

var jumpforce = 1000
var gravity = 25
var damage = 1
var max_health = 15
var health = 20
var attacking = false
var can_move = true
var knockback = 0
var can_hit = true
var other_character : Node2D
var player_number : int
var velocity := Vector2.ZERO
var speed = 600

func _ready():
	
	$ProgressBar.max_value = health
	
	$AnimatedSprite.position.x = 0
	
	$attack_box/CollisionShape2D.disabled = true
	
	if player_number == 1:
		other_character = Global.player_2
	else:
		other_character = Global.player_1

func _physics_process(delta):
	if is_instance_valid(other_character):
		if health <= 0:
			$ProgressBar.hide()
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
		
		if is_on_floor() and Input.is_action_just_pressed("player_1_jump") and player_number == 1 and can_move:
			velocity.y -= jumpforce
		elif is_on_floor() and Input.is_action_just_pressed("player_2_jump") and player_number == 2 and can_move:
			velocity.y -= jumpforce
		
		velocity.y += gravity
		
		velocity = move_and_slide(velocity , Vector2.UP)
		
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = false
		 
		if attacking:
			if $attack_box.overlaps_body(other_character):
				other_character.hit()
				other_character.health -= damage
				other_character.knockback = 10
			$attack_box/CollisionShape2D.disabled = true
		
		if player_number == 1 and Input.is_action_just_pressed("player_1_attack") and can_hit:
			attack()
		elif player_number == 2 and Input.is_action_just_pressed("player_2_attack") and can_hit:
			attack()
		
		
		$ProgressBar.value = health


func attack():
	can_move = false
	can_hit = false
	$attack_box/CollisionShape2D.disabled = false
	attacking = true
	velocity.x = 0
	if not $attack.playing:
		$attack.play()
	$AnimatedSprite.play("attack")
	
	if $AnimatedSprite.flip_h == true:
		$attack_box/CollisionShape2D.position.x = -200
		$AnimatedSprite.position.x = -100
	else:
		$attack_box/CollisionShape2D.position.x = 200
		$AnimatedSprite.position.x = 100
	
	yield($AnimatedSprite , "animation_finished")
	can_move = true
	$attack_box/CollisionShape2D.disabled = true
	$AnimatedSprite.play("idle")
	$AnimatedSprite.position.x = 0
	can_hit = true
	attacking = false

func hit():
	if not $hit.playing:
		$hit.play()

