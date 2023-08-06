extends Area2D

var Lightning_effect = preload("res://cayen_lightning_effect.tscn")
var damage = 1
var speed = 50
var other_character : Node2D

func _physics_process(delta):
	global_position += Vector2(-speed , 0).rotated(rotation - deg2rad(90))
	
	if overlaps_body(other_character):
		var lightning_effect = Lightning_effect.instance()
		lightning_effect.global_position = global_position
		get_parent().add_child(lightning_effect)
		lightning_effect.emitting = true
		other_character.health -= damage


func _on_disappear_timer_timeout():
	queue_free()
