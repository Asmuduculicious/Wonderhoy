extends Control

@export var UI: Node
@export var tilemap: Node
@export var camera: Node
@export var mouse: Node
@export var army_scene: PackedScene
@export var army_control: Node
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
var selected = []
var army_list = []
var existing_army = []
var click_tile = Vector2i(0, 0)
var to_search = []
var searched = []
var tile_distance = {}
var currently_searching = Vector2i(0,0)
var result_distance = 0
var previous_army_pos = Vector2i(0, 0)
var name_list = []
var can_move = true
var upmost_list = []
var child_name_list = []

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
	# Ths creates the hexagonal shape with the side length being the map size
	# The left span is due to the hexagonal tile map shape
		
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
		
		# At top right corner, set the enemy's starting position
			
		if y == (global.map_size*2) -3:
			tilemap.set_cell(Vector2i(-left_span +1, y), 1, Vector2i(8,0))
			global.tile_info[str(Vector2i(-left_span +1, y))][1] = "Player"
			
			if global.difficulty == "EASY":
				tilemap.set_cell(Vector2i(-left_span, y), 1, Vector2i(10,3))
				global.tile_info[str(Vector2i(-left_span, y))] = ["Mine", "Player"]
			else:
				tilemap.set_cell(Vector2i(-left_span, y), 1, Vector2i(8,0))
				global.tile_info[str(Vector2i(-left_span, y))][1] = "Player"
				
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
			
		# At the bottom left corner, set the player's starting position
		# If the difficulty is easy, start with extra buildings

func _random_tile(coordinate) -> void:
	# There is a random chance of each tile spawning
	# As there are two types of grass tiles and two types of rock tiles
	# These are also random to make the map not look so bland
	# The ratio of spawn of grass to rock to forest is 4:4:1
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
	# This function will take the coordinate of where is being occupied and by who
	# If enemy is occupying it, it will change the atlas coordinate to color it red
	# If the player is occupying it, it will change the atlas coordinate to color it blue
	# Either will set the global variable to update the tile information
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
	# When the player wants to build things
	# And they click and tile, it will disable the building mode
	global.building_mode = false
	if global.tile_info[str(coordinate)][1]== "Player":
		# If the player occupy that tile, then progress, can't build otherwise
		if what == "Trench":
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
			# Trench an only build trench on rock or grass, not on forest or other building
			# If they try to build on other places, it stops them
			else:
				print("Can't build Trench, it's " + str(global.tile_info[str(coordinate)][0]))
				_stop_building()
		elif what == "Hospital":
			# If they are trying to build a hospital
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
			# Can only build on rocks and grass
			else:
				print("Can't build Hospital, it's " + str(global.tile_info[str(coordinate)][0]))
				_stop_building()
		elif what == "Lumber":
			# if they are trying to build a Lumberhut
			if tilemap.get_cell_atlas_coords(coordinate) == Vector2i(8,3):
				tilemap.set_cell(coordinate, 2, Vector2i(9, 3))
				global.tile_info[str(coordinate)][0] = "Lumber"
			else:
				print("Can't build Lumber, not Forest")
				_stop_building()
			# Can only build on forest
		elif what == "Mine":
			# If they are trying to build a mine
			if tilemap.get_cell_atlas_coords(coordinate) == Vector2i(10, 0):
				tilemap.set_cell(coordinate, 2, Vector2i(10,3))
				global.tile_info[str(coordinate)][0] = "Mine"
			elif tilemap.get_cell_atlas_coords(coordinate) == Vector2i(11, 0):
				tilemap.set_cell(coordinate, 2, Vector2i(11,3))
				global.tile_info[str(coordinate)][0] = "Mine"
			else:
				print("Can't build Mine, not Rock")
				_stop_building()
			# Can only build on rock
	else:
		print("Not Occupied by you")
		_stop_building()

func _stop_building() -> void:
	global.money += global.building_resources[0]
	global.steel += global.building_resources[1]
	global.food += global.building_resources[2]
	global.wood += global.building_resources[3]
	UI._update_resources()
	global.building_mode = false
	# If the player tries to build stop but is stopped, fully refund the resources used

func _process(float) -> void:
	mouse.position = get_global_mouse_position()
	# Set a dot to follow the mouse at all time

func _on_mousefollow_body_shape_entered(body_rid: RID, body: Node2D, 
body_shape_index: int, local_shape_index: int) -> void:
	if not global.in_UI:
		tilemap.set_cell(tilemap.get_coords_for_body_rid(body_rid), 2, 
		tilemap.get_cell_atlas_coords(tilemap.get_coords_for_body_rid(body_rid)))
		tilemap.set_cell(previous_tile, 1, tilemap.get_cell_atlas_coords(previous_tile))
		previous_tile = tilemap.get_coords_for_body_rid(body_rid)
		
	# When the dot enters a tile from the tilemap, if it is not in UI
	# It will set the tile to another set of tile, which visually appears like a black border
	# As well as removing the border from the previous tile
	# This will allow the player to see what tile they are on and make it look nicer

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
		
		if Input.is_action_just_pressed("click"):
			mouse_start = get_global_mouse_position()
	
		if (Input.is_action_just_released("left_click")
		and get_global_mouse_position() == mouse_start):
			mouse_end = get_global_mouse_position()
			click_tile = str(tilemap.local_to_map(mouse_end))
			print(click_tile)
			if global.tile_info.has(click_tile):
				if global.building_mode:
					_build(tilemap.local_to_map(mouse_end), global.current_building)
				else:
					if selected.is_empty():
						if global.tile_to_army[click_tile].is_empty():
							print("nothing there")
						else:
							for i in range(global.tile_to_army[click_tile].size()):
								selected.append(global.tile_to_army[click_tile][i])
							previous_army_pos = tilemap.local_to_map(mouse_end)
					else:
						_pathfinding(previous_army_pos, tilemap.local_to_map(mouse_end))
						if result_distance > 0:
							for i in range(selected.size()):
								for u in range(global.army_list.size()):
									name_list.append(global.army_list[u][0])
								can_move = true
								if result_distance<= global.army_list[name_list.find(selected[i])][7]:
									global.army_list[name_list.find(selected[i])][7]-= result_distance
								else:
									global.army_list[name_list.find(selected[i])]
									for u in range(army_control.get_child_count()):
										child_name_list.append(army_control.get_children()[u].name)
									army_control.get_children()[child_name_list.find(selected[i])]\
									.name_text.text = selected[i]
									child_name_list.clear()
									can_move = false
								name_list.clear()
								if can_move:
									if not global.tile_to_army[click_tile].is_empty():
										_merge(global.tile_to_army[click_tile], selected[i])
									else:
										global.tile_to_army[click_tile].append(selected[i])
									global.tile_to_army[str(previous_army_pos)].\
									pop_at(global.tile_to_army[str(previous_army_pos)].\
									find(selected[i]))
									for u in range(army_control.get_child_count()):
										existing_army.append(army_control.get_children()[u].name)
									army_control.get_child((existing_army.\
									find(selected[i]))).position = tilemap.map_to_local(tilemap.\
									local_to_map(mouse_end)) - Vector2(9, 9)
									existing_army.clear()
							selected.clear()
						else:
							selected.clear()
			else:
				if global.building_mode:
					_stop_building()
				selected.clear()
				
		elif (Input.is_action_just_released("right_click") 
		and get_global_mouse_position() == mouse_start):
			mouse_end = get_global_mouse_position()
			click_tile = str(tilemap.local_to_map(mouse_end))
			
			if global.building_mode:
				_stop_building()
			else:
				if global.tile_info.has(click_tile):
					if selected.is_empty():
						if global.tile_to_army[click_tile].is_empty():
							print("nothing there")
						else:
							if global.tile_to_army[click_tile].size() > 1:
								selected.append(global.tile_to_army[click_tile].pop_front())
								previous_army_pos = tilemap.local_to_map(mouse_end)
								for i in range(army_control.get_child_count()):
									child_name_list.append(army_control.get_children()[i].name)
								army_control.get_children()[child_name_list.find(selected[0])]\
								.name_text.text = selected[0]
								army_control.get_children()[child_name_list.find(selected[0])]\
								.top_level = true
								child_name_list.clear()
							else:
								selected.append(global.tile_to_army[click_tile].pop_front())
								previous_army_pos = tilemap.local_to_map(mouse_end)
					else:
						_pathfinding(previous_army_pos, tilemap.local_to_map(mouse_end))
						if result_distance < 1:
							global.tile_to_army[click_tile].append(selected[0])
							for i in range(army_control.get_child_count()):
								child_name_list.append(army_control.get_children()[i].name)
							army_control.get_children()[child_name_list.find(selected[0])]\
							.name_text.text = selected[0]
							
							army_control.get_children()[child_name_list.find(selected[0])]\
							.z_index = 1
							selected.clear()
							selected.append(global.tile_to_army[click_tile].pop_front())
							previous_army_pos = tilemap.local_to_map(mouse_end)
						else:
							selected.clear()
				else:
					selected.clear()

func _spawn_soldier(army_name) -> void:
	var army = army_scene.instantiate()
	army.name = army_name
	army.amount = 1
	army.position = tilemap.map_to_local(global.home_tile) - Vector2(9, 9)
	army.army_name = army_name
	global.tile_to_army[str(global.home_tile)].append(army_name)
	army_control.add_child(army)

func _pathfinding(current_tile: Vector2i, target_tile) -> void:
	to_search.append(current_tile)
	tile_distance[current_tile] = 0
	_get_surrounding(current_tile, 1)
	_search(target_tile)
	
func _search(target_tile) -> void:
	if to_search.size() > 0:
		currently_searching = to_search.pop_front()
		if global.tile_info.has(str(currently_searching)):
			
			if currently_searching == target_tile:
				result_distance = tile_distance[currently_searching]
				to_search.clear()
				searched.clear()
				tile_distance.clear()
			else:
				searched.append(currently_searching)
				_get_surrounding(currently_searching, tile_distance[currently_searching] + 1)
				_search(target_tile)

func _get_surrounding(tile: Vector2i, distance) -> void:
	_get_tile(tile, Vector2i(0, 1), distance)
	_get_tile(tile, Vector2i(1, 0), distance)
	_get_tile(tile, Vector2i(0, -1), distance)
	if tile.y % 2 == 0:
		_get_tile(tile, Vector2i(-1, 1), distance)
		_get_tile(tile, Vector2i(-1, 0), distance)
		_get_tile(tile, Vector2i(-1, -1), distance)
	else:
		_get_tile(tile, Vector2i(1, 1), distance)
		_get_tile(tile, Vector2i(-1, 0), distance)
		_get_tile(tile, Vector2i(1, -1), distance)

func _get_tile(tile: Vector2i, diff, distance) -> void:
	if global.tile_info.has(str(tile + diff)) and not to_search.has(tile + diff):
		tile_distance[tile + diff] = distance
		to_search.append(tile + diff)

func _next_day() -> void:
	global.date += 1
	UI.date_label.text = str(global.date)
	if global.date <= 5:
		global.money += 100
		global.steel += 20
		global.food += 100
		global.wood += 50
	elif global.date <= 10:
		global.money += 80
		global.steel += 16
		global.food += 80
		global.wood += 40
	elif global.date <= 15:
		global.money += 60
		global.steel += 12
		global.food += 60
		global.wood += 30
	else:
		global.money += 40
		global.steel += 8
		global.food += 40
		global.wood += 20
	UI._update_resources()
	
	for i in range(global.army_list.size()):
		global.army_list[i][7] = global.army_list[i][6]
	
func _merge(one, two) -> void:
	one.append(two)
	for i in range(one.size()):
		for u in range(army_control.get_child_count()):
			child_name_list.append(army_control.get_children()[u].name)
		upmost_list.append(child_name_list.find(one[i]))
		child_name_list.clear()
	army_control.get_children()[upmost_list.find(upmost_list.max())].name_text.text = str(one)
	upmost_list.clear()
