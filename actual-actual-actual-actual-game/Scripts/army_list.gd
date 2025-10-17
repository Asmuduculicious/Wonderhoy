extends Control

var army_name = ""
var type = ""
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

var name_list = []

func _ready() -> void:
	army_name_label.text = army_name
	type_label.text = type
	hp_label.text = str(current_hp) + "/" + str(hp)
	atk_label.text = str(atk)
	def_label.text = str(def)
	weapon.add_item(current_weapon)
	armor.add_item(current_armor)
	
	# When this is spawned it will have all the labels being updated to the stats
	# Then depending on it's type and the currently equipped armor/weapon
	# It will add available items to choose from in the drop down selector
	
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
			def += 2
			hp += 5
			current_hp += 5
			armor.add_item("Level 0 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 2 armor":
			def += 6
			hp += 12
			current_hp += 12
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_3_armor_available >= 1:
				armor.add_item("Level 3 armor")
		elif armor.get_item_text(0) == "Level 3 armor":
			def += 12
			hp += 30
			current_hp += 30
			armor.add_item("Level 0 armor")
			if global.level_1_armor_available >= 1:
				armor.add_item("Level 1 armor")
			if global.level_2_armor_available >= 1:
				armor.add_item("Level 2 armor")

func _update_status() -> void:
	for i in range(global.army_list.size()):
		name_list.append(global.army_list[i][0])
	global.army_list[name_list.find(army_name)][8] = weapon.get_item_text(weapon.selected)
	global.army_list[name_list.find(army_name)][9] = armor.get_item_text(armor.selected)
	armor.clear()
	weapon.clear()
	weapon.add_item(global.army_list[name_list.find(army_name)][8])
	armor.add_item(global.army_list[name_list.find(army_name)][9])
	hp_label.text = (str(global.army_list[name_list.find(army_name)][3]) 
	+ "/" + str(global.army_list[name_list.find(army_name)][2]))
	atk_label.text = str(global.army_list[name_list.find(army_name)][4])
	def_label.text = str(global.army_list[name_list.find(army_name)][5])
	name_list.clear()
	
	# When it updates, it will find it's spot in the global army list
	# All the labels will be set again with correspondance to the stats stored there
	# It will save the current weapon/armor selected, clear it, add them back
	# Then it will add other options back in
	
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

func _on_weapon_button_item_selected(index: int) -> void:
	# When they select something, it will check their selection
	# It will reduce the amount of them available and give them a corresponding stat bonus
	# The stat increase is used multiple times so there is a function created for it below
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
			_update_army_list(0, -5, 0)
			global.level_1_weapon_available += 1
		elif weapon.get_item_text(0) == "Level 2 weapon":
			_update_army_list(0, -12, 0)
			global.level_2_weapon_available += 1
		elif weapon.get_item_text(0) == "Level 3 weapon":
			_update_army_list(0, -25, 0)
			global.level_3_weapon_available += 1
			
		if weapon.get_item_text(weapon.selected) == "Level 1 weapon":
			_update_army_list(0, 5, 0)
			global.level_1_weapon_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 2 weapon":
			_update_army_list(0, 12, 0)
			global.level_2_weapon_available -= 1
		elif weapon.get_item_text(weapon.selected) == "Level 3 weapon":
			_update_army_list(0, 25, 0)
			global.level_3_weapon_available -= 1
			
	for i in get_parent().get_children():
		i._update_status()

func _on_armor_button_item_selected(index: int) -> void:
	if armor.get_item_text(0) == "Level 1 armor":
		global.level_1_armor_available += 1
		_update_army_list(-5, 0, -2)
	elif armor.get_item_text(0) == "Level 2 armor":
		global.level_2_armor_available += 1
		_update_army_list(-12, 0, -6)
	elif armor.get_item_text(0) == "Level 3 armor":
		global.level_3_armor_available += 1
		_update_army_list(-30, 0, -12)
		
	if armor.get_item_text(armor.selected) == "Level 1 armor":
		global.level_1_armor_available -= 1
		_update_army_list(5, 0, 2)
	elif armor.get_item_text(armor.selected) == "Level 2 armor":
		global.level_2_armor_available -= 1
		_update_army_list(12, 0, 6)
	elif armor.get_item_text(armor.selected) == "Level 3 armor":
		global.level_3_armor_available -= 1
		_update_army_list(30, 0, 12)
			
	for i in get_parent().get_children():
		i._update_status()

func _update_army_list(hp, atk, def) -> void:
	# A function used multiple times, taking hp and attack and defense as values
	# This is because equipments only change these values
	# It will find the position of the current army from the global list
	# And it will update the stat in the global list accordingly
	# And then it will update so the stat increase is visible
	for i in range(global.army_list.size()):
		name_list.append(global.army_list[i][0])
	global.army_list[name_list.find(army_name)][2] += hp
	global.army_list[name_list.find(army_name)][4] += atk
	global.army_list[name_list.find(army_name)][5] += def
	if (global.army_list[name_list.find(army_name)][3] 
	> global.army_list[name_list.find(army_name)][2]):
		global.army_list[name_list.find(army_name)][3] = \
		global.army_list[name_list.find(army_name)][2]
	name_list.clear()
