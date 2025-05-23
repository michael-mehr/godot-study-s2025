extends Node

class_name GameManager

signal toggle_game_paused(is_paused : bool)

var next_scene = preload("res://scenes/test_level.tscn")

@onready var debug_level: Node3D = $DebugLevel
@onready var test_level: Node3D = next_scene.instantiate()
@onready var current_level: Node3D = debug_level

@onready var coin_count: Label = $UI/HUD/CoinCounter/Coins
@onready var hp_count: Label = $UI/HUD/HealthCounter/HPCount

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _input(event : InputEvent):
	if(event.is_action_pressed("toggle_pause")):
		game_paused = !game_paused

func switch_level():
	remove_child(current_level)
	add_child(test_level)
	game_paused = false

func update_coins(num_coins):
	coin_count.text = str(num_coins)

func update_hp(num_hp):
	hp_count.text = str(num_hp)
