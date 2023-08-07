extends Area2D

var damage = .15
var other_character : Node2D
var speed = 12

func _ready():
	$bomb_falling.play()
	$Sprite.visible = true
	$explosion.visible = false
	$explode_radius/CollisionShape2D.disabled = true

func _physics_process(delta):
	global_position.y += speed
	if $explode_radius.overlaps_body(other_character):
		other_character.hit()
		other_character.health -= damage
		other_character.knockback = 0


func _on_Joah_bomb_body_entered(body):
	speed = 0
	$bomb.play()
	$AnimationPlayer.play("explosion")
	yield($AnimationPlayer , "animation_finished")
	queue_free()

