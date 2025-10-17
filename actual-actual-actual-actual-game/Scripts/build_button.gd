extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0
@export var building = ""
@export var UI: Node

func _on_pressed() -> void:
	# When it is pressed, if it has all the resources, use them, else don't run
	# It will reduce these resources and update the resources for the UI counterparts
	# Then it will hide the build menu, and enter the building mode
	# Using export variables, it will store the building type in the global variable
	# As well as the amount of resources that are used, so it can be used later
	if (global.money >= money and global.steel >= steel
	and global.food >= food and global.wood >= wood):
		global.building_resources = [money, steel, food, wood]
		global.money -= money
		global.steel -= steel
		global.food -= food
		global.wood -= wood
		UI._update_resources()
		global.in_UI = false
		UI.build_menu.visible = false
		global.building_mode = true
		global.current_building = building
	else: 
		print("Not enough resources")
