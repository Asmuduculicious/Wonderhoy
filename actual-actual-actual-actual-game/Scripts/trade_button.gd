extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0

@export var UI: Node

func _on_pressed() -> void:
	if (global.money >= money and global.steel >= steel
	and global.food >= food and global.wood >= wood):
		global.money -= money
		global.steel -= steel
		global.food -= food
		global.wood -= wood
		UI._update_resources()
	else: 
		print("Not enough shit")
