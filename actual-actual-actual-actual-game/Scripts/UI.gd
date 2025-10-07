extends CanvasLayer

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

func _ready() -> void:
	money_note.visible = false
	steel_note.visible = false
	food_note.visible = false
	wood_note.visible = false

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
	
