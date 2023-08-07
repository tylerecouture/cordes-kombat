extends Node2D

var selected_player_1 : PackedScene
var selected_player_2 : PackedScene



var characters = [
	preload("res://Rohan.tscn"),
	preload("res://Kaeus.tscn"),
	preload("res://Logan.tscn"),
	preload("res://Thayden.tscn"),
	preload("res://cayen.tscn"),
	preload("res://Joah.tscn")
]

func _ready():
	$restart_button.hide()
	$BackgroundMusic.playing = true

func _physics_process(delta):
	if Global.game_started and not is_instance_valid(Global.player_1) or Global.game_started and not is_instance_valid(Global.player_2):
		$restart_button.show()


func _on_Start_Button_button_down():
	Global.game_started = true
	
	$Start_Button.hide()
	$Player_1_Select.hide()
	$Player_2_Select.hide()
	
	Global.player_1 = selected_player_1.instance()
	Global.player_2 = selected_player_2.instance()
	
	Global.player_1.global_position = Vector2(400,500)
	Global.player_2.global_position = Vector2(1500,500)
	
	Global.player_1.player_number = 1
	Global.player_2.player_number = 2
	
	add_child(Global.player_1)
	add_child(Global.player_2)





func _on_Player_1_Select_item_selected(index):
	selected_player_1 = characters[index]


func _on_Player_2_Select_item_selected(index):
	selected_player_2 = characters[index]


func _on_restart_button_button_down():
	
	$restart_button.hide()
	
	Global.game_started = false
	
	if is_instance_valid(Global.player_1):
		Global.player_1.queue_free()
	if is_instance_valid(Global.player_2):
		Global.player_2.queue_free()
	
	$Start_Button.show()
	$Player_1_Select.show()
	$Player_2_Select.show()
	
