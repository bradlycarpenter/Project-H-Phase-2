class_name Item
extends Resource

@export var icon: Texture2D
@export var name: String
@export var description: String
@export var stat_boost: Dictionary = {}

func apply_effect(player):
	for stat in stat_boost:
		player.adjust_stat(stat, stat_boost[stat])
