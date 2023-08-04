extends Node2D

var selected_player_1 : PackedScene
var selected_player_2 : PackedScene

var player_1 : Node2D
var player_2 : Node2D

var characters = [
	preload("res://Rohan.tscn"),
	preload("res://Kaiyus.tscn")
]




func _physics_process(delta):
	pass


func _on_Start_Button_button_down():
	$Start_Button.hide()
	
	player_1 = selected_player_1.instance()
	player_2 = selected_player_2.instance()
	
	player_1.global_position = Vector2(100,300)
	player_2.global_position = Vector2(924,300)
	
	player_1.player_number = 1
	player_2.player_number = 2
	
	add_child(player_1)
	add_child(player_2)





func _on_Player_1_Select_item_selected(index):
	selected_player_1 = characters[index]


func _on_Player_2_Select_item_selected(index):
	selected_player_2 = characters[index]
