extends Control

var map_size = 0
var difficulty = ""
var in_UI = false

var money = 0
var steel = 0
var food = 0
var wood = 0

var level_1_weapon = 0
var level_2_weapon = 0
var level_3_weapon = 0
var level_1_armor = 0
var level_2_armor = 0
var level_3_armor = 0
var level_1_tank = 0
var level_2_tank = 0
var level_3_tank = 0

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

var tile = []
var home_tile = Vector2i(0,0)

var tile_to_army = {}
var tile_to_enemy = {}
var tile_info = {}

var building_mode = false
var current_building = ""
