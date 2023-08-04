extends Area2D

var player_number : int
var velocity := Vector2.AXIS_X
var speed = 10

func _physics_process(delta):
	if player_number == 1:
		velocity = Input.get_axis("Player_1_move_left" , "player_1_move_right") * speed
	else:
		velocity = Input.get_axis("player_2_move_left" , "player_2_move_right") * speed
	
	global_position.x += velocity


