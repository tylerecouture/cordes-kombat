extends Sprite

var Lightning = preload("res://Cayen_lightning.tscn")
var other_character : Node2D

func _on_lightning_timer_timeout():
	var lightning = Lightning.instance()
	lightning.global_position = $Position2D.global_position
	lightning.look_at(other_character.global_position)
	lightning.global_rotation_degrees -= 90
	lightning.other_character = other_character
	get_parent().add_child(lightning)
	queue_free()

