extends Area2D

var other_character : Node2D
var damage = .0017
var speed = 10
var velocity = Vector2.ZERO

func _physics_process(delta):
	global_position += velocity.normalized() * speed
	
	if overlaps_body(other_character):
		other_character.hit()
		other_character.health -= damage
		other_character.knockback = 0
	



func _on_disippear_timer_timeout():
	queue_free()
