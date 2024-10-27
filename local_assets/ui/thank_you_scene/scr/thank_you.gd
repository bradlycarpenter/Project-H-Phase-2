extends Node2D

@onready var scene_timer: Timer = $SceneTimer
@export var mainmenu: PackedScene
@export var stats: Stats

const scene_time = 20.0

func _ready() -> void:
	scene_timer.wait_time = scene_time
	scene_timer.start()

func _on_scene_timer_timeout() -> void:
	
	#saves stats
	stats.current_health = 100
	stats.base_damage = 0
	stats.crit_chance = 0.1
	stats.move_speed = 200
	stats.attack_speed = 1
	stats.defense = 0
	stats.dash_count = 1
	stats.cooldown_reduction = 0
	stats.double_hit_chance = 0
	stats.shield = 0
	stats.dash_attack = false
	
	var save = ResourceSaver.save(stats)
	
	#back to main menu
	get_tree().change_scene_to_packed(mainmenu)
