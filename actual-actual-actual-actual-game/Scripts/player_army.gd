extends Control

@export var single: Node
@export var double: Node
@export var multi: Node

func _ready() -> void:
	single.visible = false
	double.visible = false
	multi.visible = false
