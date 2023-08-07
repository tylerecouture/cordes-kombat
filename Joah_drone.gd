extends KinematicBody2D

var other_character : Node2D
var speed = 500
var Bomb = preload("res://Joah_bomb.tscn")

func _physics_process(delta):
	
	if not is_instance_valid(get_parent().get_node("Joah")):
		queue_free()
	
	
	if not $drone_fly.playing:
		$drone_fly.play()
	
	
	move_and_slide(Vector2(speed , 0) , Vector2.UP)
	if is_on_wall():
		speed *= -1

func drop_bomb():
	var bomb = Bomb.instance()
	bomb.other_character = other_character
	bomb.global_position = $bomb_spawn.global_position
	get_parent().add_child(bomb)
