extends Control

@onready var stats_dmg: Label = $MarginContainer/stats_dmg

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var stats = FileAccess.open("res://local_assets/actors/items/damage_up.tres", FileAccess.READ)
	#var dmg_stats = stats.get_as_text()
	#stats_dmg.text = dmg_stats
	#var stats = load("res://local_assets/actors/items/damage_up.tres")
	#var name = stats.stat_boost.damage
	#stats_dmg.text = str(name)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stats = load("res://local_assets/actors/items/damage_up.tres")
	var name = stats.stat_boost.damage
	stats_dmg.text = str(name)
	pass
