extends Control

@export var easy_text: Node
@export var normal_text: Node
@export var hell_text: Node
@export var map_size: Node
@export var difficulty: Node


func _ready() -> void:
	normal_text.visible = false
	hell_text.visible = false
	global.map_size = 10
	map_size.text = "10"
	difficulty.text = "EASY"

func _on_start_button_pressed() -> void:
	global.map_size = int(map_size.text)
	global.difficulty = difficulty.text
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_map_size_reduce_pressed() -> void:
	if int(map_size.text) > 8:
		map_size.text = str(int(map_size.text) - 1)

func _on_map_size_increase_pressed() -> void:
	if int(map_size.text) < 32:
		map_size.text = str(int(map_size.text) + 1)

func _on_difficulty_decrease_pressed() -> void:
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
		
