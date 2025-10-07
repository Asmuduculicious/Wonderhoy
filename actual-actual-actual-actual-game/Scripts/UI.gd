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


func _ready() -> void:
	_update_resources()
	money_note.visible = false
	steel_note.visible = false
	food_note.visible = false
	wood_note.visible = false
	
	craft_menu.visible = false
	draft_menu.visible = false
	build_menu.visible = false
	
func _update_resources() -> void:
	money_number.text = str(global.money)
	steel_number.text = str(global.steel)
	food_number.text = str(global.food)
	wood_number.text = str(global.wood)

func _update_equipment() -> void:
	level_1_weapon_amount.text = str(global.level_1_weapon_available)
	level_2_weapon_amount.text = str(global.level_2_weapon_available)
	level_3_weapon_amount.text = str(global.level_3_weapon_available)
	level_1_armor_amount.text = str(global.level_1_armor_available)
	level_2_armor_amount.text = str(global.level_2_armor_available)
	level_3_armor_amount.text = str(global.level_3_armor_available)
	level_1_armor_amount.text = str(global.level_1_armor_available)
	level_2_armor_amount.text = str(global.level_2_armor_available)
	level_3_armor_amount.text = str(global.level_3_armor_available)
	

func _on_money_control_mouse_entered() -> void:
	global.in_UI = true
	money_timer.start()
	
func _on_money_timer_timeout() -> void:
	money_note.visible = true

func _on_money_control_mouse_exited() -> void:
	money_note.visible = false
	money_timer.stop()
	global.in_UI = false

func _on_steel_control_mouse_entered() -> void:
	global.in_UI = true
	steel_timer.start()
	
func _on_steel_timer_timeout() -> void:
	steel_note.visible = true

func _on_steel_control_mouse_exited() -> void:
	steel_note.visible = false
	steel_timer.stop()
	global.in_UI = false

func _on_food_control_mouse_entered() -> void:
	global.in_UI = true
	food_timer.start()

func _on_food_timer_timeout() -> void:
	food_note.visible = true

func _on_food_control_mouse_exited() -> void:
	food_note.visible = false
	food_timer.stop()
	global.in_UI = false

func _on_wood_control_mouse_entered() -> void:
	global.in_UI = true
	wood_timer.start()

func _on_wood_timer_timeout() -> void:
	wood_note.visible = true

func _on_wood_control_mouse_exited() -> void:
	wood_note.visible = false
	wood_timer.stop()
	global.in_UI = false

func _on_craft_control_mouse_entered() -> void:
	global.in_UI = true

func _on_craft_control_mouse_exited() -> void:
	global.in_UI = false
	
func _on_draft_control_mouse_entered() -> void:
	global.in_UI = true

func _on_draft_control_mouse_exited() -> void:
	global.in_UI = false

func _on_build_control_mouse_entered() -> void:
	global.in_UI = true

func _on_build_control_mouse_exited() -> void:
	global.in_UI = false
	
func _on_craft_button_pressed() -> void:
	if craft_menu.visible == true:
		craft_menu.visible = false
	elif craft_menu.visible == false:
		craft_menu.visible = true
		draft_menu.visible = false
		build_menu.visible = false

func _on_draft_button_pressed() -> void:
	if draft_menu.visible == true:
		draft_menu.visible = false
	elif draft_menu.visible == false:
		draft_menu.visible = true
		craft_menu.visible = false
		build_menu.visible = false

func _on_build_button_pressed() -> void:
	if build_menu.visible == true:
		build_menu.visible = false
	elif build_menu.visible == false:
		build_menu.visible = true
		craft_menu.visible = false
		draft_menu.visible = false

func _on_craft_menu_mouse_entered() -> void:
	global.in_UI = true

func _on_craft_menu_mouse_exited() -> void:
	global.in_UI = false
