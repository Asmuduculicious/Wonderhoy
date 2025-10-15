extends TextureButton

@export var money = 0
@export var steel = 0
@export var food = 0
@export var wood = 0
@export var building = ""

@export var UI: Node



func _on_pressed() -> void:
	if (global.money >= money and global.steel >= steel
	and global.food >= food and global.wood >= wood):
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
		print("Not enough shit")
