extends Node

@export var lil_bug_scene: PackedScene
@export var boss_rock_thrower_scene: PackedScene

func _ready():
	var all_spawn_points = get_tree().get_nodes_in_group("spawn_points")
	
	# Randomly shuffle the list and take the first 6 points
	all_spawn_points.shuffle()
	var selected_spawn_points = all_spawn_points.slice(0, 6)
	
	# Spawn 5 lil bug dude at the first 5
	for i in range(5):
		spawn_enemy(lil_bug_scene, selected_spawn_points[i].global_position)
	
	# Spawn a rock thrower at the last
	spawn_enemy(boss_rock_thrower_scene, selected_spawn_points[5].global_position)

func spawn_enemy(enemy_scene: PackedScene, spawn_position: Vector2):
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = spawn_position
	add_child(enemy_instance)
