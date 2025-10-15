extends Control

@export var UI: Node
@export var tilemap: Node
@export var camera: Node

@export var mouse: Node

var left_span = 0

var randomiser = 0

var previous_tile = Vector2i(0, 0)

var previous_mouse_pos = Vector2(0, 0)
var absolute = true
var current_mouse_pos = Vector2(0, 0)
var move = Vector2(0, 0)

var mouse_start = Vector2(0, 0)
var mouse_end = Vector2(1, 1)
var selected_tile_position = Vector2i(0, 0)

func _ready() -> void:
	for y in range(global.map_size*2 - 1):
		if y < global.map_size:
			left_span = (y+1)/2
		elif y >= global.map_size:
			left_span = (global.map_size*2 -1 -y)/2
			
		if y < (global.map_size -1):
			for x in range(global.map_size + y):
				_random_tile(Vector2i(x - left_span, y))
		elif y == global.map_size -1:
			for x in range(global.map_size*2 -1):
				_random_tile(Vector2i(x - left_span, y))
		elif y > (global.map_size -1):
			for x in range(global.map_size*3 - 2 - y):
				_random_tile(Vector2i(x - left_span, y))
		
		if y == 0:
			tilemap.set_cell(Vector2i(global.map_size -2, 0), 1, Vector2i(0,0))
			global.tile_info[str(Vector2i(global.map_size -2, 0))][1] = "Enemy"
			tilemap.set_cell(Vector2i(global.map_size -1, 0), 1, Vector2i(3,3))
			global.tile_info[str(Vector2i(global.map_size -1, 0))] = ["Home", "Enemy"]
		if y == 1:
			tilemap.set_cell(Vector2i(global.map_size -1, 1), 1, Vector2i(0,0))
			global.tile_info[str(Vector2i(global.map_size -1, 1))][1] = "Enemy"
			tilemap.set_cell(Vector2i(global.map_size -2, 1), 1, Vector2i(0,0))
			global.tile_info[str(Vector2i(global.map_size -2, 1))][1] = "Enemy"
			
		if y == (global.map_size*2) -3:
			tilemap.set_cell(Vector2i(-left_span +1, y), 1, Vector2i(8,0))
			global.tile_info[str(Vector2i(-left_span +1, y))][1] = "Player"
			if global.difficulty == "EASY":
				tilemap.set_cell(Vector2i(-left_span, y), 1, Vector2i(10,3))
				global.tile_info[str(Vector2i(-left_span, y))] = ["Mine", "Player"]
			else:
				tilemap.set_cell(Vector2i(-left_span, y), 1, Vector2i(8,0))
				global.tile_info[str(Vector2i(global.map_size -2, 0))][1] = "Player"
		if y == (global.map_size*2) -2:
			if global.difficulty == "EASY":
				tilemap.set_cell(Vector2i(-left_span +1, y), 1, Vector2i(9,3))
				global.tile_info[str(Vector2i(-left_span +1, y))] = ["Lumber", "Player"]
			else:
				tilemap.set_cell(Vector2i(-left_span +1, y), 1, Vector2i(8,0))
			tilemap.set_cell(Vector2i(-left_span, y), 1, Vector2i(11,3))
			global.tile_info[str(Vector2i(-left_span, y))] = ["Home", "Player"]
			global.home_tile = Vector2i(-left_span, y)
			camera.position = tilemap.map_to_local(global.home_tile)
		
func _random_tile(coordinate) -> void:
	randomiser = randi_range(1,9)
	if randomiser == 1 or randomiser == 2:
		tilemap.set_cell(coordinate, 1, Vector2i(4,0))
		global.tile_to_army[str(coordinate)] = []
		global.tile_to_enemy[str(coordinate)] = []
		global.tile_info[str(coordinate)] = ["Grass", "Free"]
	if randomiser == 3 or randomiser == 4:
		tilemap.set_cell(coordinate, 1, Vector2i(5,0))
		global.tile_to_army[str(coordinate)] = []
		global.tile_to_enemy[str(coordinate)] = []
		global.tile_info[str(coordinate)] = ["Grass", "Free"]
	if randomiser == 5 or randomiser == 6:
		tilemap.set_cell(coordinate, 1, Vector2i(6,0))
		global.tile_to_army[str(coordinate)] = []
		global.tile_to_enemy[str(coordinate)] = []
		global.tile_info[str(coordinate)] = ["Rock", "Free"]
	if randomiser == 7 or randomiser == 8:
		tilemap.set_cell(coordinate, 1, Vector2i(7,0))
		global.tile_to_army[str(coordinate)] = []
		global.tile_to_enemy[str(coordinate)] = []
		global.tile_info[str(coordinate)] = ["Rock", "Free"]
	if randomiser == 9:
		tilemap.set_cell(coordinate, 1, Vector2i(4,3))
		global.tile_to_army[str(coordinate)] = []
		global.tile_to_enemy[str(coordinate)] = []
		global.tile_info[str(coordinate)] = ["Forest", "Free"]

func _occupy(coordinate, who) -> void:
	if who == "Enemy":
		if global.tile_info[str(coordinate)[1]] == "Player":
			tilemap.set_cell(coordinate, 1, 
			(tilemap.get_cell_atlas_coords(coordinate) + Vector2i(-8, 0)))
		elif global.tile_info[str(coordinate)[1]] == "Free":
			tilemap.set_cell(coordinate, 1, 
			(tilemap.get_cell_atlas_coords(coordinate) + Vector2i(-4, 0)))
		global.tile_info[str(coordinate)][1] = "Enemy"
	elif who == "Player":
		if global.tile_info[str(coordinate)[1]] == "Enemy":
			tilemap.set_cell(coordinate, 1, 
			(tilemap.get_cell_atlas_coords(coordinate) + Vector2i(8, 0)))
		elif global.tile_info[str(coordinate)[1]] == "Free":
			tilemap.set_cell(coordinate, 1, 
			(tilemap.get_cell_atlas_coords(coordinate) + Vector2i(4, 0)))
		global.tile_info[str(coordinate)][1] = "Player"

func _build(coordinate, what) -> void:
	print(global.tile_info[str(coordinate)])
	if global.tile_info[str(coordinate)][1]== "Player":
		if what == "Trench":
			if global.tile_info[str(coordinate)][0] == "Trench":
				print("Already Trench")
			else:
				if (global.tile_info[str(coordinate)][0] == "Grass"
				or global.tile_info[str(coordinate)][0] == "Rock"):
					if tilemap.get_cell_atlas_coords(coordinate) == Vector2i(8,0):
						tilemap.set_cell(coordinate, 2, Vector2i(8, 1))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(9, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(9, 1))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(10, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(10, 1))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(11, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(11, 1))
					global.tile_info[str(coordinate)][0] = "Trench"
				else:
					print("Already" + str(global.tile_info[str(coordinate)][0]))
		elif what == "Hospital":
			if global.tile_info[str(coordinate)][0] == "Hospital":
				print("Already hospital")
			else:
				if (global.tile_info[str(coordinate)][0] == "Grass"
				or global.tile_info[str(coordinate)][0] == "Rock"):
					if tilemap.get_cell_atlas_coords(coordinate) == Vector2i(8,0):
						tilemap.set_cell(coordinate, 2, Vector2i(8, 2))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(9, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(9, 2))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(10, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(10, 2))
					elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(11, 0):
						tilemap.set_cell(coordinate, 2, Vector2i(11, 2))
					global.tile_info[str(coordinate)][0] = "Hospital"
				else:
					print("Already" + str(global.tile_info[str(coordinate)][0]))
		elif what == "Lumber":
			if global.tile_info[str(coordinate)][0] == "Lumber":
				print("Already Lumber")
			else:
				if tilemap.get_cell_atlas_coords(coordinate) == Vector2i(8,3):
					tilemap.set_cell(coordinate, 2, Vector2i(9, 3))
					global.tile_info[str(coordinate)][0] = "Lumber"
				else:
					print("Not Forest")
		elif what == "Mine":
			if global.tile_info[str(coordinate)][0] == "Mine":
				print("Already mine")
			elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(10, 0):
				tilemap.set_cell(coordinate, 2, Vector2i(10,3))
				global.tile_info[str(coordinate)][0] = "Mine"
			elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(10, 0):
				tilemap.set_cell(coordinate, 2, Vector2i(11,3))
				global.tile_info[str(coordinate)][0] = "Mine"
			else:
				print("Not Rock")
	else:
		print("Not Occupied by you")

func _process(float) -> void:
	mouse.position = get_global_mouse_position()

func _on_mousefollow_body_shape_entered(body_rid: RID, body: Node2D, 
body_shape_index: int, local_shape_index: int) -> void:
	if not global.in_UI:
		tilemap.set_cell(tilemap.get_coords_for_body_rid(body_rid), 2, 
		tilemap.get_cell_atlas_coords(tilemap.get_coords_for_body_rid(body_rid)))
		tilemap.set_cell(previous_tile, 1, tilemap.get_cell_atlas_coords(previous_tile))
		previous_tile = tilemap.get_coords_for_body_rid(body_rid)

func _input(event: InputEvent) -> void:
	if not global.in_UI:
		if Input.is_action_pressed("left_click"):
			previous_mouse_pos.x = event.position.x
			previous_mouse_pos.y = event.position.y
			if absolute == false:
				absolute = true
				current_mouse_pos.x = event.position.x
				current_mouse_pos.y = event.position.y
			else:
				absolute = false
				previous_mouse_pos.x = event.position.x
				previous_mouse_pos.y = event.position.y
			move.x = (current_mouse_pos.x - previous_mouse_pos.x)/camera.zoom.x
			move.y = (current_mouse_pos.y - previous_mouse_pos.y)/camera.zoom.y
			camera.position += move
		else:
			absolute = false
		
		if Input.is_action_just_pressed("left_click"):
			mouse_start = get_global_mouse_position()
	
		if Input.is_action_just_released("left_click"):
			mouse_end = get_global_mouse_position()
			if mouse_start == mouse_end:
				if global.tile_info.has(str(tilemap.local_to_map(mouse_end))):
					selected_tile_position = tilemap.local_to_map(mouse_end)
					if global.building_mode:
						_build(selected_tile_position, global.current_building)
						global.building_mode = false

func _spawn_soldier(type, army_name) -> void:
	pass
