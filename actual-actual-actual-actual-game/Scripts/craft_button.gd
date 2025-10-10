extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0

@export var product = ""

@export var ui: Node

func _on_pressed() -> void:
	if (money >= global.money
	and steel >= global.steel
	and food >= global.food
	and wood >= global.wood):
		
		global.money -= money
		global.steel -= steel
		global.food -= food
		global.wood -= wood
		ui._update_resources()
		
		if product == "level_1_weapon":
			global.level_1_weapon += 1
			global.level_1_weapon_available += 1
		elif product == "level_2_weapon":
			global.level_2_weapon += 1
			global.level_2_weapon_available += 1
		elif product == "level_3_weapon":
			global.level_3_weapon += 1
			global.level_3_weapon_available += 1
		elif product == "level_1_armor":
			global.level_1_armor += 1
			global.level_1_armor_available += 1
		elif product == "level_2_armor":
			global.level_2_armor += 1
			global.level_2_armor_available += 1
		elif product == "level_3_armor":
			global.level_3_armor += 1
			global.level_3_armor_available += 1
		elif product == "level_1_tank":
			global.level_1_tank += 1
			global.level_1_tank_available += 1
		elif product == "level_2_tank":
			global.level_2_tank += 1
			global.level_2_tank_available += 1
		elif product == "level_3_tank":
			global.level_3_tank += 1
			global.level_3_tank_available += 1
		
		ui._update_equipment()
