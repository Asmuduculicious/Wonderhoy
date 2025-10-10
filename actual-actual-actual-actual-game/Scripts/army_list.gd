extends Control

var army_name = "1"
var type = "1"
var hp = 0
var current_hp = 0
var atk = 0
var def = 0

var current_weapon = ""
var current_armor = ""
var current_tank = ""

@export var army_name_label: Node
@export var type_label: Node
@export var hp_label: Node
@export var atk_label: Node
@export var def_label: Node

@export var weapon: Node
@export var armor: Node

var army_name_list = []

func _ready() -> void:
	army_name_label.text = army_name
	type_label.text = type
	hp_label.text = str(current_hp) + "/" + str(hp)
	atk_label.text = str(atk)
	def_label.text = str(def)
	
	weapon.add_item(current_weapon)
	armor.add_item(current_armor)
	
	if type != "TD":
		if weapon.get_item_text(0) == "Level 0 weapon":
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 1 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 2 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 3 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
	elif type == "TD":
		if weapon.get_item_text(0) == "Level 0 tank":
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 1 tank":
			weapon.add_item("Level 0 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 2 tank":
			weapon.add_item("Level 0 tank")
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 3 tank":
			weapon.add_item("Level 0 tank")
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
				
	if type != "TD":
		if armor.get_item_text(0) == "Level 0 armor":
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 1 armor":
			armor.add_item("Level 0 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 2 armor":
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 3 armor":
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
	else:
		armor.add_item("-")

func _update_status() -> void:
	for i in range(global.army_list.size()):
		army_name_list.append(global.army_list[i][0])
	global.army_list[army_name_list.find(army_name)][6] = weapon.get_item_text(weapon.selected)
	global.army_list[army_name_list.find(army_name)][7] = armor.get_item_text(armor.selected)
	armor.clear()
	weapon.clear()
	weapon.add_item(global.army_list[army_name_list.find(army_name)][6])
	armor.add_item(global.army_list[army_name_list.find(army_name)][7])
	
	army_name_list.clear()
	
	if type != "TD":
		if weapon.get_item_text(0) == "Level 0 weapon":
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 1 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 2 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_3_weapon_available >= 1:
				weapon.add_item("Level 3 weapon")
				
		elif weapon.get_item_text(0) == "Level 3 weapon":
			weapon.add_item("Level 0 weapon")
			if global.level_1_weapon_available >= 1:
				weapon.add_item("Level 1 weapon")
			if global.level_2_weapon_available >= 1:
				weapon.add_item("Level 2 weapon")
	elif type == "TD":
		if weapon.get_item_text(0) == "Level 0 tank":
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 1 tank":
			weapon.add_item("Level 0 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 2 tank":
			weapon.add_item("Level 0 tank")
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_3_tank_available >= 1:
				weapon.add_item("Level 3 tank")
		elif weapon.get_item_text(0) == "Level 3 tank":
			weapon.add_item("Level 0 tank")
			if global.level_1_tank_available >= 1:
				weapon.add_item("Level 1 tank")
			if global.level_2_tank_available >= 1:
				weapon.add_item("Level 2 tank")
				
	if type != "TD":
		if armor.get_item_text(0) == "Level 0 armor":
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 1 armor":
			armor.add_item("Level 0 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 2 armor":
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 3 armor":
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
	else:
		armor.add_item("-")

func _on_weapon_button_item_selected(index: int) -> void:
	if type == "TD":
		if weapon.get_item_text(0) == "Level 1 tank":
			global.level_1_tank_available += 1
		elif weapon.get_item_text(0) == "Level 2 tank":
			global.level_2_tank_available += 1
		elif weapon.get_item_text(0) == "Level 3 tank":
			global.level_3_tank_available += 1
			
		if weapon.get_item_text(weapon.selected) == "Level 1 tank":
			global.level_1_tank_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 2 tank":
			global.level_2_tank_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 3 tank":
			global.level_3_tank_available -= 1
	else:
		if weapon.get_item_text(0) == "Level 1 weapon":
			global.level_1_weapon_available += 1
		elif weapon.get_item_text(0) == "Level 2 weapon":
			global.level_2_weapon_available += 1
		elif weapon.get_item_text(0) == "Level 3 weapon":
			global.level_3_weapon_available += 1
		if weapon.get_item_text(weapon.selected) == "Level 1 weapon":
			global.level_1_weapon_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 2 weapon":
			global.level_2_weapon_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 3 weapon":
			global.level_3_weapon_available -= 1
			
	for i in get_parent().get_children():
		i._update_status()
	get_parent().parent._update_equipment()



func _on_armor_button_item_selected(index: int) -> void:
	if armor.get_item_text(0) == "Level 1 armor":
		global.level_1_armor_available += 1
	elif armor.get_item_text(0) == "Level 2 armor":
		global.level_2_armor_available += 1
	elif armor.get_item_text(0) == "Level 3 armor":
		global.level_3_armor_available += 1
		
	if armor.get_item_text(armor.selected) == "Level 1 armor":
		global.level_1_armor_available -= 1
	elif armor.get_item_text(armor.selected) == "Level 2 armor":
		global.level_2_armor_available -= 1
	elif armor.get_item_text(armor.selected) == "Level 3 armor":
		global.level_3_armor_available -= 1
			
	for i in get_parent().get_children():
		i._update_status()
	get_parent().parent._update_equipment()
