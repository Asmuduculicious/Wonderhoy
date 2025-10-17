extends Control

@export var single: Node
@export var double: Node
@export var multi: Node
@export var label: Node
@export var name_text: Node
@export var amount = 0
@export var army_name = [""]

func _ready() -> void:
	# When it is spawned, this will determine what appearance it will take
	single.visible = false
	double.visible = false
	multi.visible = false
	label.visible = false
	if amount == 1:
		single.visible = true
	elif amount == 2:
		double.visible = true
	elif amount >= 3:
		multi.visible = true
	# And it will have a name that is hidden
	name_text.text = str(army_name)

func _on_mouse_entered() -> void:
	label.visible = true

func _on_mouse_exited() -> void:
	label.visible = false
	
# Unless the player's mouse is hovering over it
