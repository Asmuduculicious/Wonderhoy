extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0

@export var type = ""

@export var ui: Node

var hp = 0
var atk = 0
var def = 0

func _ready() -> void:
	if type == "LI":
		pass
	elif type == "SR":
		pass
	elif type == "SF":
		pass
	elif type == "TD":
		pass

func _on_pressed() -> void:
	
	if global.money >= money:
		global.money -= money
		ui._update_resources()
		
		if type == "TD":
			global.army_list.append([str(global.army_list.size() + 1), type, hp, hp, atk, def, "Level 0 tank", "-"])
		else:
			global.army_list.append([str(global.army_list.size() + 1), type, hp, hp, atk, def, "Level 0 weapon", "Level 0 armor"])
		
		ui._update_soldiers()
		
