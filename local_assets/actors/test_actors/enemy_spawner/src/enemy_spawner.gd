extends Node

@export var lil_bug_dude_scene: PackedScene
@export var rock_thrower_scene: PackedScene
@export var death_menu: Node
@export var player: Player


#var level_configs = [
	#{"lil_bug_dude": 1, "rock_thrower": 0}, # Level 1
	#{"lil_bug_dude": 1, "rock_thrower": 0}, # Level 2
	#{"lil_bug_dude": 1, "rock_thrower": 0}, # Level 3
	#{"lil_bug_dude": 1, "rock_thrower": 0}, # Level 4
	#{"lil_bug_dude": 1, "rock_thrower": 0} # Level 5
#]

var base_lil_bug_dude_count: int = 3
var base_rock_thrower_count: int = 0

var current_level: int = 0
var remaining_enemies:int = 0
signal level_complete

func _ready() -> void:
	start_level()

func start_level():
	
	var lil_bug_dude_count = base_lil_bug_dude_count + randi()%(current_level+1)
	var rock_thrower_count = base_rock_thrower_count + randi()%(current_level+1)
	
	#if current_level >= level_configs.size():
		#return
	
	#var level_config = level_configs[current_level]
	#var lil_bug_dude_count = level_config.get("lil_bug_dude", 0)
	#var rock_thrower_count = level_config.get("rock_thrower", 0)
	
	var all_spawn_points = get_tree().get_nodes_in_group("spawn_points")
	
	all_spawn_points.shuffle()
	var selected_spawn_points = all_spawn_points.slice(0, lil_bug_dude_count + rock_thrower_count)
	
	
	for i in range(lil_bug_dude_count):
		spawn_enemy(lil_bug_dude_scene, selected_spawn_points[i].global_position)
	
	for i in range(rock_thrower_count):
		var index = lil_bug_dude_count + i
		spawn_enemy(rock_thrower_scene, selected_spawn_points[index].global_position)


func spawn_enemy(enemy_scene: PackedScene, spawn_position: Vector2) -> void:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = spawn_position
	remaining_enemies += 1
	enemy_instance.connect("killed", Callable(self, "on_enemy_killed"))
	call_deferred("add_child", enemy_instance)

func on_level_complete() -> void:
	current_level += 1
	player.show_item_menu()
	start_level()

func on_enemy_killed() -> void:
	remaining_enemies -= 1
	print("remaining_enemies: ", remaining_enemies)
	if remaining_enemies <= 0:
		on_level_complete()
