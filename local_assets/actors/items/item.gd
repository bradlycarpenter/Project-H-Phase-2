class_name Item
extends Resource

@export var icon: Texture
@export var name: String
@export var description: String
@export var stat_boost: Dictionary = {}
@export var tier: String
@export var tierColor: Texture

func apply_effect(player: Player) -> void:
	for stat: String in stat_boost:
		player.adjust_stat(stat, stat_boost[stat])
		print("stat adjusted")
