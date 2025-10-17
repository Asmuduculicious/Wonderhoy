extends CanvasLayer

@export var ui: Node
@export var money_number: Node
@export var steel_number: Node
@export var food_number: Node
@export var wood_number: Node
@export var money_timer: Node
@export var steel_timer: Node
@export var food_timer: Node
@export var wood_timer: Node
@export var money_note: Node
@export var steel_note: Node
@export var food_note: Node
@export var wood_note: Node
@export var craft_menu: Node
@export var draft_menu: Node
@export var build_menu: Node
@export var level_1_weapon_amount: Node
@export var level_2_weapon_amount: Node
@export var level_3_weapon_amount: Node
@export var level_1_armor_amount: Node
@export var level_2_armor_amount: Node
@export var level_3_armor_amount: Node
@export var level_1_tank_amount: Node
@export var level_2_tank_amount: Node
@export var level_3_tank_amount: Node
@export var army_list: Node
@export var army: PackedScene
@export var zoom_label: Node
@export var date_label: Node

func _ready() -> void:
	# When the game launches, it will update resources to the start amount
	# It will also hide the hover menus and set the day label to one
	_update_resources()
	money_note.visible = false
	steel_note.visible = false
	food_note.visible = false
	wood_note.visible = false
	craft_menu.visible = false
	draft_menu.visible = false
	build_menu.visible = false
	date_label.text = "1"
	
func _update_resources() -> void:
	# Easy to call function that updates the resources
	money_number.text = str(global.money)
	steel_number.text = str(global.steel)
	food_number.text = str(global.food)
	wood_number.text = str(global.wood)

func _update_equipment() -> void:
	# Easy to call function that updates the inventory
	level_1_weapon_amount.text = str(global.level_1_weapon_available)
	level_2_weapon_amount.text = str(global.level_2_weapon_available)
	level_3_weapon_amount.text = str(global.level_3_weapon_available)
	level_1_armor_amount.text = str(global.level_1_armor_available)
	level_2_armor_amount.text = str(global.level_2_armor_available)
	level_3_armor_amount.text = str(global.level_3_armor_available)
	level_1_tank_amount.text = str(global.level_1_tank_available)
	level_2_tank_amount.text = str(global.level_2_tank_available)
	level_3_tank_amount.text = str(global.level_3_tank_available)

func _update_soldiers() -> void:
	# Easy to call functions that updates the army list
	for i in range(army_list.get_child_count()):
		army_list.get_child(i).queue_free()
	for i in range(global.army_list.size()):
		var army_indivisual = army.instantiate()
		army_indivisual.army_name = global.army_list[i][0]
		army_indivisual.type = global.army_list[i][1]
		army_indivisual.hp = global.army_list[i][2]
		army_indivisual.current_hp = global.army_list[i][3]
		army_indivisual.atk = global.army_list[i][4]
		army_indivisual.def = global.army_list[i][5]
		army_indivisual.current_weapon = global.army_list[i][8]
		army_indivisual.current_armor = global.army_list[i][9]
		army_list.add_child(army_indivisual)

# All the mouse entered code below will trigger their seperate timer
# And when the timer hits zero the corresponding label will appear

func _on_money_control_mouse_entered() -> void:
	_mouse_entered()
	money_timer.start()
	
func _on_money_timer_timeout() -> void:
	money_note.visible = true

func _on_money_control_mouse_exited() -> void:
	money_note.visible = false
	money_timer.stop()
	_mouse_exited()

func _on_steel_control_mouse_entered() -> void:
	_mouse_entered()
	steel_timer.start()
	
func _on_steel_timer_timeout() -> void:
	steel_note.visible = true

func _on_steel_control_mouse_exited() -> void:
	steel_note.visible = false
	steel_timer.stop()
	_mouse_exited()

func _on_food_control_mouse_entered() -> void:
	_mouse_entered()
	food_timer.start()

func _on_food_timer_timeout() -> void:
	food_note.visible = true

func _on_food_control_mouse_exited() -> void:
	food_note.visible = false
	food_timer.stop()
	_mouse_exited()

func _on_wood_control_mouse_entered() -> void:
	_mouse_entered()
	wood_timer.start()

func _on_wood_timer_timeout() -> void:
	wood_note.visible = true

func _on_wood_control_mouse_exited() -> void:
	wood_note.visible = false
	wood_timer.stop()
	_mouse_exited()

# When each button is pressed, it will hide the other two menus
# Then it will show itself and update everything the player will see
# So that the player information is always up to date
# If the button is pressed while it is already open, it will close it

func _on_craft_button_pressed() -> void:
	if craft_menu.visible == true:
		craft_menu.visible = false
		global.in_UI = false
	elif craft_menu.visible == false:
		craft_menu.visible = true
		draft_menu.visible = false
		build_menu.visible = false
		_update_equipment()
		global.in_UI = true

func _on_draft_button_pressed() -> void:
	if draft_menu.visible == true:
		draft_menu.visible = false
		global.in_UI = false
	elif draft_menu.visible == false:
		draft_menu.visible = true
		craft_menu.visible = false
		build_menu.visible = false
		_update_soldiers()
		global.in_UI = true

func _on_build_button_pressed() -> void:
	if build_menu.visible == true:
		build_menu.visible = false
		global.in_UI = false
	elif build_menu.visible == false:
		build_menu.visible = true
		craft_menu.visible = false
		draft_menu.visible = false
		global.in_UI = true

# Easy to call function below that will tell if the player mouse is in the UI
# Which may determine the outcome of certain actions
# This will prevent them from clicking through the panels to do things unknowingly

func _mouse_entered() -> void:
	global.in_UI = true

func _mouse_exited() -> void: 
	if draft_menu.visible or craft_menu.visible or build_menu.visible:
		pass
	else:
		global.in_UI = false

# When the next day button is pressed, get the main scene's function to handle it

func _on_next_day_button_pressed() -> void:
	get_parent()._next_day()

# Zooming in and zooming out buttons proportionally
# Also show to the players what zoom level they are in

func _on_zoom_out_pressed() -> void:
	ui.get_parent().camera.zoom.x *= 0.9
	ui.get_parent().camera.zoom.y *= 0.9
	zoom_label.text = (str(snapped(ui.get_parent().camera.zoom.x, 0.1)) + "x")

func _on_zoom_in_pressed() -> void:
	ui.get_parent().camera.zoom.x *= 1.1
	ui.get_parent().camera.zoom.y *= 1.1
	zoom_label.text = (str(snapped(ui.get_parent().camera.zoom.x, 0.1)) + "x")
