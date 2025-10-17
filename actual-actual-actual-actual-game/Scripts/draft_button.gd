extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0
@export var type = ""
@export var ui: Node
var army_name = ""

func _on_pressed() -> void:
	# If they have enough resources, use them, else don't run
	# The type will depend on what triggered this, which is an export variable that can be changed
	# It will add to the global army list according to the pre-determined stats
	# With their name being an ordered list from one to one hundred of their type
	# It will then update the army list as well as add them to the tilemap
	if (money <= global.money and steel <= global.steel
	and food <= global.food and wood <= global.wood):
		global.money -= money
		global.steel -= steel
		global.food -= food
		global.wood -= wood
		ui._update_resources()
		if type == "TD":
			army_name = global.army_name_list_td.pop_front()
			global.army_list.append([army_name, type, 60, 60, 18, 10, 3, 3, "Level 0 tank", "-"])
		elif type == "LI":
			army_name = global.army_name_list_li.pop_front()
			global.army_list.append([army_name, type, 
			60, 60, 22, 8, 4, 4, "Level 0 weapon", "Level 0 armor"])
		elif type == "SR":
			army_name = global.army_name_list_sr.pop_front()
			global.army_list.append([army_name, type, 
			100, 100, 30, 14, 2, 2, "Level 0 weapon", "Level 0 armor"])
		elif type == "SF":
			army_name = global.army_name_list_sf.pop_front()
			global.army_list.append([army_name, type, 
			110, 110, 46, 20, 4, 4, "Level 0 weapon", "Level 0 armor"])
		ui._update_soldiers()
		ui.get_parent()._spawn_soldier(army_name)
