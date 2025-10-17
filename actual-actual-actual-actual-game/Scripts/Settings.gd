extends Control

@export var easy_text: Node
@export var normal_text: Node
@export var hell_text: Node
@export var map_size: Node
@export var difficulty: Node

func _ready() -> void:
	# By default, the difficulty is easy and the map size is a hexagon with 10 tile edges
	normal_text.visible = false
	hell_text.visible = false
	global.map_size = 10
	map_size.text = "10"
	difficulty.text = "EASY"

func _on_start_button_pressed() -> void:
	# Only when the start button is pressed, the global variable will be set
	# This is to prevent unnecessary lines of code
	global.map_size = int(map_size.text)
	global.difficulty = difficulty.text
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_map_size_reduce_pressed() -> void:
	# Clicking the left arrow key will reduce the map size but no smaller than 8
	if int(map_size.text) > 8:
		map_size.text = str(int(map_size.text) - 1)

func _on_map_size_increase_pressed() -> void:
	# Clicking the right arrow key will increase the map size but no larger than 32
	if int(map_size.text) < 32:
		map_size.text = str(int(map_size.text) + 1)

func _on_difficulty_decrease_pressed() -> void:
	# Clicking the left arrow will cycle to the left from easy, normal, hell
	# And change text accordingly
	if difficulty.text == "EASY":
		difficulty.text = "HELL"
		easy_text.visible = false
		hell_text.visible = true
	elif difficulty.text == "HELL":
		difficulty.text = "NORMAL"
		hell_text.visible = false
		normal_text.visible = true
	elif difficulty.text == "NORMAL":
		difficulty.text = "EASY"
		normal_text.visible = false
		easy_text.visible = true

func _on_difficulty_increase_pressed() -> void:
	# Clicking the right button will cycle to the other direction and change text accordingly
	if difficulty.text == "EASY":
		difficulty.text = "NORMAL"
		easy_text.visible = false
		normal_text.visible = true
	elif difficulty.text == "NORMAL":
		difficulty.text = "HELL"
		normal_text.visible = false
		hell_text.visible = true
	elif difficulty.text == "HELL":
		difficulty.text = "EASY"
		hell_text.visible = false
		easy_text.visible = true
