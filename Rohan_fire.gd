extends Area2D

var damage = 1.5
var can_hit = true
var facing_left
var other_character : Node2D

func _ready():
	if facing_left:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func _physics_process(delta):
	if is_instance_valid(other_character):
		if overlaps_body(other_character) and can_hit:
			can_hit = false
			other_character.hit()
			other_character.health -= damage

			other_character.knockback = 5

func _on_disappear_timer_timeout():
	get_parent().get_node("Rohan").can_move = true
	queue_free()
