extends Control

var map_size = 0
var difficulty = ""

var in_UI = false

var money = 300
var steel = 60
var food = 300
var wood = 150

var level_1_weapon_available = 0
var level_2_weapon_available = 0
var level_3_weapon_available = 0
var level_1_armor_available = 0
var level_2_armor_available = 0
var level_3_armor_available = 0
var level_1_tank_available = 0
var level_2_tank_available = 0
var level_3_tank_available = 0

var army_list = []

var army_name_list_li = []
var army_name_list_sr = []
var army_name_list_sf = []
var army_name_list_td = []

var tile = []
var home_tile = Vector2i(0,0)

var tile_to_army = {}
var tile_to_enemy = {}
var tile_info = {}

var building_mode = false
var current_building = ""
var building_resources = [0, 0, 0, 0]

var date = 1

func _ready() -> void:
	for i in range(99):
		army_name_list_li.append("LI" + str(i + 1))
		army_name_list_sr.append("SR" + str(i + 1))
		army_name_list_sf.append("SF" + str(i + 1))
		army_name_list_td.append("TD" + str(i + 1))
